// Folds consecutive tool calls into one row, the way Claude Code collapses them.
//
//   ✔ bash echo three · earlier: read 3 files, searched 2×, ran 1 command
//
// Only the latest call of a run keeps a row. Earlier calls that finished cleanly
// collapse into the "earlier:" summary; running and failed calls keep their own
// row. Anything visible between two calls (assistant text, a user message) ends
// the run. Ctrl+O expands every card as before; a click on a folded row expands
// or re-folds just that run.
//
// omp exposes no renderer hook for built-in tools, so this patches the host's
// ToolExecutionComponent / TranscriptContainer / Composer prototypes. It reads only
// their public methods and events, and does nothing if a method it needs is gone.
//
// Click support: while `tui.mouse` is off, the extension turns mouse reporting on
// itself and owns clicks (text selection then needs Shift+drag and the wheel needs
// Shift+wheel, exactly as with `tui.mouse`). With `tui.mouse` on, omp's own handler
// consumes clicks first, so folded rows are not clickable and Ctrl+O is the way out.
// Set TOOL_FOLD_CLICK=0 to keep the terminal's native mouse behavior.
//
// Commands: `/fold` toggles folding for this process.
// Only host entry points that the compiled `omp` binary bundles can be imported here
// (`@oh-my-pi/pi-tui/chat/*`, `/prompt/*`, `/mouse` exist in a source checkout but not in the binary).
import {
	AssistantMessageComponent,
	Composer,
	type ExtensionAPI,
	ToolExecutionComponent,
} from "@oh-my-pi/pi-coding-agent";
import { lookup } from "@oh-my-pi/pi-coding-agent/config/registry";
import { parseSgrMouse, theme, truncateToWidth } from "@oh-my-pi/pi-tui";
import { TranscriptContainer } from "@oh-my-pi/pi-tui/chrome";
import { formatStatusIcon } from "@oh-my-pi/pi-tui/render";
import { isRecord } from "@oh-my-pi/pi-utils";

const CLICK = process.env.TOOL_FOLD_CLICK !== "0";
const CLICK_ID_PREFIX = "@omp:tool-fold-ext:";
const SPINNER_REPAINT_MS = 120;

/** Tools whose cards carry their own controls or live agents; they never fold. */
const EXEMPT_TOOLS = new Set(["task", "ask"]);

type Status = "running" | "ok" | "error";
type Category = "read" | "search" | "command" | "edit" | "write" | "other";

const CATEGORY_BY_TOOL: Record<string, Category> = {
	read: "read",
	grep: "search",
	find: "search",
	glob: "search",
	ast_grep: "search",
	web_search: "search",
	bash: "command",
	eval: "command",
	edit: "edit",
	ast_edit: "edit",
	apply_patch: "edit",
	write: "write",
};
const CATEGORY_ORDER: readonly Category[] = ["read", "search", "command", "edit", "write", "other"];
const FILE_CATEGORIES = new Set<Category>(["read", "edit", "write"]);
const DETAIL_KEYS = ["command", "path", "file_path", "pattern", "query", "url", "i"] as const;

interface CardInfo {
	id?: string;
	args?: Record<string, unknown>;
	status: Status;
	/** Global expansion (Ctrl+O) set through `setExpanded`. */
	expanded: boolean;
}

interface FoldState {
	enabled: boolean;
	composer?: Composer;
	epoch: number;
	settings?: unknown;
	unsubscribeInput?: () => void;
	lastRunningRowAt: number;
	hoveredId?: string;
	/** The host's `getClickFocusAgentIds`, before this extension wrapped it. */
	originalClickIds?: Getter;
}

const STATE_KEY = Symbol.for("omp.tool-fold.state");
const globals = globalThis as { [STATE_KEY]?: FoldState };

const infos = new WeakMap<object, CardInfo>();
const toolNameById = new Map<string, string>();
const parents = new WeakMap<object, TranscriptContainer>();
const assistantIsEmpty = new WeakMap<object, boolean>();
const expandedHeads = new WeakSet<object>();
const clickIds = new WeakMap<object, string>();
const clickTargets = new Map<string, WeakRef<ToolExecutionComponent>>();
let clickSeq = 0;

function infoOf(card: object): CardInfo {
	let info = infos.get(card);
	if (info === undefined) {
		info = { status: "running", expanded: false };
		infos.set(card, info);
	}
	return info;
}

type Method = (this: ToolExecutionComponent, ...args: never[]) => unknown;
type Getter = Method;

function install(state: FoldState): void {
	const proto = ToolExecutionComponent.prototype as unknown as Record<string, Method | undefined>;
	const original = (name: string): Method | undefined => proto[name];
	const render = original("render");
	const getClickFocusAgentIds = original("getClickFocusAgentIds");
	if (render === undefined || getClickFocusAgentIds === undefined) return;
	state.originalClickIds = getClickFocusAgentIds;

	const bump = (): void => {
		state.epoch++;
	};
	const wrap = (name: string, before: (card: ToolExecutionComponent, args: unknown[]) => void): void => {
		const orig = original(name);
		if (orig === undefined) return;
		proto[name] = function (this: ToolExecutionComponent, ...args: never[]) {
			before(this, args);
			return orig.apply(this, args);
		};
	};

	wrap("updateArgs", (card, [args, id]) => {
		const info = infoOf(card);
		if (typeof id === "string") info.id ??= id;
		if (isRecord(args)) info.args = args;
	});
	wrap("setArgsComplete", (card, [id]) => {
		if (typeof id === "string") infoOf(card).id ??= id;
	});
	wrap("setExecutionStarted", (card, [id]) => {
		if (typeof id === "string") infoOf(card).id ??= id;
	});
	wrap("updateResult", (card, [result, isPartial, id]) => {
		const info = infoOf(card);
		if (typeof id === "string") info.id ??= id;
		if (isPartial === true) return;
		const next: Status = isRecord(result) && result.isError === true ? "error" : "ok";
		if (info.status !== next) {
			info.status = next;
			bump();
		}
	});
	wrap("seal", card => {
		const info = infoOf(card);
		if (info.status === "running") {
			info.status = "ok";
			bump();
		}
	});
	wrap("setExpanded", (card, [expanded]) => {
		const info = infoOf(card);
		if (info.expanded !== (expanded === true)) {
			info.expanded = expanded === true;
			bump();
		}
	});

	const getVersion = original("getTranscriptBlockVersion");
	if (getVersion !== undefined) {
		proto.getTranscriptBlockVersion = function (this: ToolExecutionComponent) {
			return (getVersion.call(this) as number) + state.epoch;
		};
	}

	proto.getClickFocusAgentIds = function (this: ToolExecutionComponent) {
		const own = getClickFocusAgentIds.call(this) as string[];
		if (own.length > 0 || !state.enabled || !clickable(state)) return own;
		const mode = decide(this, state, getClickFocusAgentIds);
		if (mode.kind === "full" && !mode.inFoldableRun) return own;
		if (mode.kind === "hidden") return own;
		let id = clickIds.get(this);
		if (id === undefined) {
			id = `${CLICK_ID_PREFIX}${++clickSeq}`;
			clickIds.set(this, id);
			clickTargets.set(id, new WeakRef(this));
			if (clickTargets.size > 2000) {
				for (const [key, ref] of clickTargets) if (ref.deref() === undefined) clickTargets.delete(key);
			}
		}
		return [id];
	};

	proto.render = function (this: ToolExecutionComponent, ...args: never[]) {
		if (!state.enabled) return render.apply(this, args) as readonly string[];
		const width = args[0] as unknown as number;
		const mode = decide(this, state, getClickFocusAgentIds);
		if (mode.kind === "hidden") return [];
		if (mode.kind === "full") return render.apply(this, args) as readonly string[];
		return renderRow(this, width, mode.run, render, args, state);
	};

	// A card finds its neighbours through its container. Replayed sessions build cards in a
	// staging container and move them, so ownership is refreshed from the live children
	// whenever the container renders, not recorded once at addChild.
	const containerProto = TranscriptContainer.prototype as unknown as Record<string, Method | undefined>;
	const seen = new WeakMap<object, { length: number; epoch: number }>();
	const claim = (container: TranscriptContainer): void => {
		const children = container.children;
		const last = seen.get(container);
		if (last?.length === children.length && last.epoch === state.epoch) return;
		seen.set(container, { length: children.length, epoch: state.epoch });
		for (const child of children) if (child instanceof ToolExecutionComponent) parents.set(child, container);
	};
	for (const name of [
		"render",
		"renderViewport",
		"renderTail",
		"beginFrame",
		"peekFinalizedBatch",
		"peekReplayBatch",
		"peekFlushBatch",
		"rerenderOfferedBatch",
	]) {
		const orig = containerProto[name];
		if (orig === undefined) continue;
		containerProto[name] = function (this: TranscriptContainer, ...args: never[]) {
			claim(this);
			return (orig as Method).apply(this as never, args);
		} as unknown as Method;
	}
	for (const name of ["addChild", "removeChild"]) {
		const orig = containerProto[name];
		if (orig === undefined) continue;
		containerProto[name] = function (this: TranscriptContainer, ...args: never[]) {
			bump();
			return (orig as Method).apply(this as never, args);
		} as unknown as Method;
	}

	// An assistant block that draws no rows (a tool-call-only turn) does not end a run.
	const assistantProto = AssistantMessageComponent.prototype as unknown as Record<string, Method | undefined>;
	const assistantRender = assistantProto.render;
	if (assistantRender !== undefined) {
		assistantProto.render = function (this: AssistantMessageComponent, ...args: never[]) {
			const rows = assistantRender.apply(this as never, args) as readonly string[];
			const blank = !rows.some(row => Bun.stripANSI(row).trim().length > 0);
			if (assistantIsEmpty.get(this) !== blank) {
				assistantIsEmpty.set(this, blank);
				bump();
			}
			return rows;
		} as unknown as Method;
	}

	// The composer is the only handle to click hit-testing and mouse reporting.
	const composerProto = Composer.prototype as unknown as Record<string, Method | undefined>;
	const renderFrame = composerProto.renderFrame;
	if (renderFrame !== undefined) {
		composerProto.renderFrame = function (this: Composer, ...args: never[]) {
			if (state.composer !== this) {
				state.composer = this;
				this.ui.setInlineMouseTrackingProvider(() => tuiMouseOn(state) || (CLICK && state.enabled));
			}
			return (renderFrame as Method).apply(this as never, args);
		} as unknown as Method;
	}

	const timer = setInterval(() => {
		if (performance.now() - state.lastRunningRowAt < 2 * SPINNER_REPAINT_MS) state.composer?.ui.requestRender();
	}, SPINNER_REPAINT_MS);
	timer.unref?.();
}

function tuiMouseOn(state: FoldState): boolean {
	const handle = lookup("tui.mouse");
	if (handle === undefined || state.settings === undefined) return false;
	return handle.get(state.settings as never) === true;
}

/** Folded rows are clickable only when this extension, not omp's `tui.mouse` handler, owns clicks. */
function clickable(state: FoldState): boolean {
	return CLICK && !tuiMouseOn(state);
}

type Decision =
	| { kind: "hidden" }
	| { kind: "full"; inFoldableRun: boolean }
	| { kind: "row"; run: ToolExecutionComponent[] };

function exempt(card: ToolExecutionComponent, getIds: Getter): boolean {
	const id = infoOf(card).id;
	const name = id === undefined ? undefined : toolNameById.get(id);
	if (name !== undefined) return EXEMPT_TOOLS.has(name);
	// Replayed cards have no name; a task card is the one that names live agents.
	return (getIds.call(card) as string[]).length > 0;
}

function runOf(card: ToolExecutionComponent, getIds: Getter): ToolExecutionComponent[] {
	const parent = parents.get(card);
	if (parent === undefined) return [card];
	const children = parent.children;
	const index = children.indexOf(card);
	if (index < 0) return [card];
	let low = index;
	let high = index;
	const extend = (j: number): boolean => {
		const child = children[j];
		if (child instanceof ToolExecutionComponent) return !exempt(child, getIds);
		if (!(child instanceof AssistantMessageComponent)) return false;
		// A block that has not rendered yet is probed once (the wrapped render records the answer).
		if (!assistantIsEmpty.has(child)) child.render(120);
		return assistantIsEmpty.get(child) === true;
	};
	for (let j = index - 1; j >= 0 && extend(j); j--) if (children[j] instanceof ToolExecutionComponent) low = j;
	for (let j = index + 1; j < children.length && extend(j); j++)
		if (children[j] instanceof ToolExecutionComponent) high = j;
	return children.slice(low, high + 1).filter((c): c is ToolExecutionComponent => c instanceof ToolExecutionComponent);
}

function decide(card: ToolExecutionComponent, state: FoldState, getIds: Getter): Decision {
	const info = infoOf(card);
	if (!state.enabled || info.expanded || exempt(card, getIds)) return { kind: "full", inFoldableRun: false };
	const run = runOf(card, getIds);
	if (expandedHeads.has(run[0]!)) return { kind: "full", inFoldableRun: true };
	if (card !== run[run.length - 1] && info.status === "ok") return { kind: "hidden" };
	return { kind: "row", run };
}

function describe(card: ToolExecutionComponent): { name?: string; detail: string } {
	const info = infoOf(card);
	const name = info.id === undefined ? undefined : toolNameById.get(info.id);
	for (const key of DETAIL_KEYS) {
		const value = info.args?.[key];
		if (typeof value === "string" && value.length > 0) {
			return { name, detail: value.split("\n", 1)[0]!.replace(/\s+/g, " ") };
		}
	}
	return { name, detail: "" };
}

function phrase(category: Category, n: number): string {
	switch (category) {
		case "read":
			return `read ${n} file${n === 1 ? "" : "s"}`;
		case "search":
			return `searched ${n}×`;
		case "command":
			return `ran ${n} command${n === 1 ? "" : "s"}`;
		case "edit":
			return `edited ${n} file${n === 1 ? "" : "s"}`;
		case "write":
			return `wrote ${n} file${n === 1 ? "" : "s"}`;
		case "other":
			return `${n} other tool${n === 1 ? "" : "s"}`;
	}
}

function earlierSummary(run: ToolExecutionComponent[], latest: ToolExecutionComponent): string | undefined {
	const tally = new Map<Category, { calls: number; targets: Set<string> }>();
	for (const member of run) {
		if (member === latest || infoOf(member).status !== "ok") continue;
		const { name } = describe(member);
		const category = (name === undefined ? undefined : CATEGORY_BY_TOOL[name]) ?? "other";
		const entry = tally.get(category) ?? { calls: 0, targets: new Set<string>() };
		entry.calls++;
		const args = infoOf(member).args;
		const target = args?.path ?? args?.file_path;
		if (typeof target === "string" && target.length > 0) entry.targets.add(target);
		tally.set(category, entry);
	}
	if (tally.size === 0) return undefined;
	const parts: string[] = [];
	for (const category of CATEGORY_ORDER) {
		const entry = tally.get(category);
		if (entry === undefined) continue;
		// A file read twice is still one file.
		const n = FILE_CATEGORIES.has(category) && entry.targets.size > 0 ? entry.targets.size : entry.calls;
		parts.push(phrase(category, n));
	}
	return parts.join(", ");
}

function renderRow(
	card: ToolExecutionComponent,
	width: number,
	run: ToolExecutionComponent[],
	render: Method,
	args: never[],
	state: FoldState,
): readonly string[] {
	const info = infoOf(card);
	let { name, detail } = describe(card);
	let label = name ?? "";
	if (label === "") {
		// No event named this card (a replayed session): use the card's own header row.
		const rows = render.apply(card, args) as readonly string[];
		const header = rows.map(row => Bun.stripANSI(row).replace(/^[\s╭╮╰╯│┃─]+|[\s╭╮╰╯│┃─]+$/g, "")).find(Boolean);
		label = header ?? "tool";
		detail = "";
	}
	let icon: string;
	if (info.status === "running") {
		state.lastRunningRowAt = performance.now();
		const frames = theme.spinnerFrames;
		icon = formatStatusIcon("running", theme, Math.floor(performance.now() / SPINNER_REPAINT_MS) % frames.length);
	} else {
		icon = formatStatusIcon(info.status === "error" ? "error" : "success", theme);
	}
	const earlier = card === run[run.length - 1] ? earlierSummary(run, card) : undefined;
	const detailText = detail ? theme.fg("muted", ` ${detail}`) : "";
	const earlierText = earlier ? theme.fg("dim", ` · earlier: ${earlier}`) : "";
	return [truncateToWidth(` ${icon} ${theme.fg("toolTitle", theme.bold(label))}${detailText}${earlierText}`, width)];
}

function candidatesAtRow(state: FoldState, row: number): string[] {
	const composer = state.composer;
	if (composer === undefined) return [];
	const viewport = composer.ui.getMutableViewport();
	const local = row - viewport.top;
	if (viewport.length === 0 || local < 0 || local >= viewport.length) return [];
	return composer.viewportClickCandidates(local);
}

function foldIdAt(state: FoldState, row: number): string | undefined {
	return candidatesAtRow(state, row).find(id => id.startsWith(CLICK_ID_PREFIX));
}

function handleMouse(state: FoldState, getIds: Getter, data: string): { consume?: boolean } | undefined {
	if (!data.startsWith("\x1b[<")) return undefined;
	// omp's own `tui.mouse` handler consumes mouse reports first when it is on.
	if (!state.enabled || !clickable(state)) return undefined;
	const composer = state.composer;
	if (composer === undefined || composer.ui.hasOverlay()) return undefined;
	const event = parseSgrMouse(data);
	if (event === null) return undefined;
	if (event.motion) {
		const id = foldIdAt(state, event.row);
		if (id !== state.hoveredId) {
			state.hoveredId = id;
			composer.setHoveredClickId(id);
			composer.ui.requestRender();
		}
	} else if (event.leftClick) {
		const id = foldIdAt(state, event.row);
		const target = id === undefined ? undefined : clickTargets.get(id)?.deref();
		if (target !== undefined) {
			const head = runOf(target, getIds)[0]!;
			if (expandedHeads.has(head)) expandedHeads.delete(head);
			else expandedHeads.add(head);
			state.epoch++;
			composer.ui.requestRender();
		}
	}
	// Reports are consumed while this extension owns mouse reporting, as omp does for `tui.mouse`.
	return { consume: true };
}

export default function toolFold(pi: ExtensionAPI) {
	pi.setLabel("tool-fold");
	let state = globals[STATE_KEY];
	if (state === undefined) {
		state = { enabled: true, epoch: 0, lastRunningRowAt: 0 };
		globals[STATE_KEY] = state;
		install(state);
	}
	const shared = state;
	shared.settings = pi.pi.settings;
	const getIds = shared.originalClickIds as Getter;
	
	pi.on("tool_execution_start", async event => {
		toolNameById.set(event.toolCallId, event.toolName);
		if (toolNameById.size > 5000) toolNameById.delete(toolNameById.keys().next().value as string);
		shared.epoch++;
	});

	pi.on("session_start", async (_event, ctx) => {
		if (!ctx.hasUI || ctx.agent.kind !== "main") return;
		shared.unsubscribeInput?.();
		shared.unsubscribeInput = ctx.ui.onTerminalInput(data => handleMouse(shared, getIds, data));
	});

	pi.registerCommand("fold", {
		description: "Toggle folding of consecutive tool calls",
		handler: async (_args, ctx) => {
			shared.enabled = !shared.enabled;
			shared.epoch++;
			shared.composer?.ui.requestRender(true);
			ctx.ui.notify(`Tool call folding ${shared.enabled ? "on" : "off"}`, "info");
		},
	});
}
