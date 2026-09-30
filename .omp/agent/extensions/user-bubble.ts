// Reshapes omp's user message bubble toward Claude Code's prompt echo:
// - drops the blank padding rows above and below the text; the reaction / live-steer badge omp
//   draws in the top padding row moves to the right end of the first text row, and that row is
//   only kept when the text leaves no room;
// - draws each attached image inside the bubble, below the text, when the terminal speaks a
//   graphics protocol (Ghostty, kitty, …) and `terminal.showImages` is on.
//
// The bubble is omp's UserMessageComponent, which the binary does not export; it is found
// through the transcript as the only block implementing `setReaction`, and its prototype's
// `render` is wrapped. Image files come from the chips' OSC 8 `file://` links (omp's
// materialized blobs), so previews need hyperlinks enabled (`tui.hyperlinks`, auto by default).
import { fileURLToPath } from "node:url";
import { Composer, type ExtensionAPI } from "@oh-my-pi/pi-coding-agent";
import { lookup } from "@oh-my-pi/pi-coding-agent/config/registry";
import {
	applyBackgroundToLine,
	getCellDimensions,
	Image,
	padding,
	TERMINAL,
	type TUI,
	theme,
	truncateToWidth,
	visibleWidth,
} from "@oh-my-pi/pi-tui";
import { TranscriptContainer } from "@oh-my-pi/pi-tui/chrome";
import { resolveImageOptions } from "@oh-my-pi/pi-tui/render";
import { readImageMetadataSync } from "@oh-my-pi/pi-utils";

const ZONE_START = "\x1b]133;A\x07";
const ZONE_CLOSE = "\x1b]133;B\x07\x1b]133;C\x07\x1b]133;D;0\x07";
const FILE_LINK_RE = /\x1b\]8;[^;]*;(file:\/\/[^\x1b\x07]+)/g;
/** Row that pi-tui's Image reserves for a direct placement's height. */
const RESERVED_IMAGE_ROW = "\x1b[0m";
/** pi-tui's direct placement line (parsed by the renderer, anchored at both ends); placeholder rows start with `a=p,U=1` instead. */
const DIRECT_PLACEMENT_RE = /^(?:\x1b7(?:\x1b\[\d+A)?)?\x1b_Ga=p,q=2,C=1,/;
const PREVIEW_MAX_ROWS = 12;
/** Wider sources are downscaled before the one-time Kitty transmit. */
const PREVIEW_MAX_PX = 1600;

type Method = (this: object, ...args: never[]) => unknown;
type Proto = Record<string, Method | undefined>;

interface State {
	patched: boolean;
	ui?: TUI;
	settings?: unknown;
}

interface Preview {
	path: string;
	widthPx: number;
	heightPx: number;
	options: { maxWidthCells: number; maxHeightCells: number };
	image?: Image;
	loading: boolean;
	failed: boolean;
}

const STATE_KEY = Symbol.for("omp.user-bubble.state");
const globals = globalThis as { [STATE_KEY]?: State };

// Memoized per component so an unchanged bubble keeps returning the same array reference.
const trimmed = new WeakMap<object, { source: readonly string[]; rows: readonly string[] }>();
const framed = new WeakMap<object, { base: readonly string[]; width: number; parts: unknown[]; rows: string[] }>();
const previews = new WeakMap<object, Preview[]>();

function isBlank(row: string): boolean {
	return Bun.stripANSI(row).trim().length === 0;
}

function trim(rows: readonly string[], width: number): readonly string[] {
	const last = rows.length - 1;
	if (last < 2 || !rows[0]!.startsWith(ZONE_START) || !rows[last]!.endsWith(ZONE_CLOSE)) return rows;
	if (!isBlank(rows[last]!)) return rows;
	const body = rows.slice(1, last);
	const top = Bun.stripANSI(rows[0]!).trim();
	if (top.length > 0) {
		const emoji = top.replace(/^\*/, "").trim();
		const badge = [top.startsWith("*") ? theme.fg("accent", "*") : "", emoji].filter(Boolean).join(" ");
		const text = Bun.stripANSI(body[0]!).trimEnd();
		const textWidth = visibleWidth(text);
		const gap = width - textWidth - visibleWidth(badge) - 1;
		if (gap < 1) return [...rows.slice(0, last - 1), rows[last - 1]! + ZONE_CLOSE];
		const head = truncateToWidth(body[0]!, textWidth, "");
		body[0] = applyBackgroundToLine(`${head}${padding(gap)}${badge} `, width, value =>
			theme.bg("userMessageBg", value),
		);
	}
	body[0] = ZONE_START + body[0];
	body[body.length - 1] += ZONE_CLOSE;
	return body;
}

function previewsOf(bubble: object, source: readonly string[]): Preview[] {
	let list = previews.get(bubble);
	if (list !== undefined) return list;
	list = [];
	const seen = new Set<string>();
	const resolved = resolveImageOptions();
	for (const row of source) {
		for (const match of row.matchAll(FILE_LINK_RE)) {
			let path: string;
			try {
				path = fileURLToPath(match[1]!);
			} catch {
				continue;
			}
			if (seen.has(path)) continue;
			seen.add(path);
			// Skill chips link SKILL.md; only files with an image header become previews.
			const meta = readImageMetadataSync(path);
			if (!meta?.width || !meta.height) continue;
			list.push({
				path,
				widthPx: meta.width,
				heightPx: meta.height,
				options: {
					maxWidthCells: resolved.maxWidthCells,
					maxHeightCells: Math.min(PREVIEW_MAX_ROWS, resolved.maxHeightCells ?? PREVIEW_MAX_ROWS),
				},
				loading: false,
				failed: false,
			});
		}
	}
	previews.set(bubble, list);
	return list;
}

/** Rows the Image will occupy at `width`; mirrors pi-tui's calculateImageFit so the reserved height never changes. */
function fitRows(p: Preview, width: number): number {
	const cell = getCellDimensions();
	const cap = p.options.maxWidthCells;
	const maxCols = Math.max(1, cap > 0 ? Math.min(width - 2, cap) : width - 2);
	const maxRows = p.options.maxHeightCells;
	const scale = Math.min((maxCols * cell.widthPx) / p.widthPx, (maxRows * cell.heightPx) / p.heightPx);
	return Math.min(maxRows, Math.max(1, Math.ceil((p.heightPx * scale) / cell.heightPx)));
}

// Kitty graphics take PNG only and omp stores pasted images as webp, so the conversion runs once, off the render path.
async function load(p: Preview, ui: TUI): Promise<void> {
	p.loading = true;
	try {
		let source = new Bun.Image(await Bun.file(p.path).bytes());
		const widthPx = Math.min(p.widthPx, PREVIEW_MAX_PX);
		if (widthPx < p.widthPx) source = source.resize(widthPx);
		const data = await source.png().toBase64();
		p.image = new Image(
			data,
			"image/png",
			{ fallbackColor: text => theme.fg("dim", text) },
			{ ...p.options, budget: ui.imageBudget, imageKey: `user-bubble:${p.path}` },
			{ widthPx, heightPx: Math.round((p.heightPx * widthPx) / p.widthPx) },
		);
	} catch {
		p.failed = true;
	}
	ui.requestRender();
}

function boxed(line: string, width: number, fill: string): string {
	if (line === RESERVED_IMAGE_ROW) return fill;
	// A direct placement line must stay verbatim: the renderer re-parses it to clip at the viewport top.
	if (DIRECT_PLACEMENT_RE.test(line)) return line;
	const bg = theme.getBgAnsi("userMessageBg");
	return `${bg} ${line}${bg}${padding(Math.max(0, width - 1 - visibleWidth(line)))}\x1b[49m`;
}

function patchBubble(proto: Proto, state: State): void {
	const render = proto.render;
	if (render === undefined) return;
	const showImages = lookup("terminal.showImages");
	proto.render = function (this: object, ...args: never[]) {
		const width = args[0] as number;
		const source = render.apply(this, args) as readonly string[];
		let hit = trimmed.get(this);
		if (hit?.source !== source) {
			hit = { source, rows: trim(source, width) };
			trimmed.set(this, hit);
		}
		const enabled =
			TERMINAL.imageProtocol != null &&
			state.ui !== undefined &&
			(showImages === undefined || state.settings === undefined || showImages.get(state.settings as never) !== false);
		const list = enabled ? previewsOf(this, source) : [];
		if (list.length === 0) return hit.rows;

		// Image.render must run on every pass so the shared budget keeps its display order.
		const parts: unknown[] = [];
		for (const p of list) {
			if (p.failed) continue;
			if (p.image === undefined && !p.loading) void load(p, state.ui!);
			parts.push(p.image?.render(width - 1), fitRows(p, width - 1));
		}
		const last = framed.get(this);
		if (
			last?.base === hit.rows &&
			last.width === width &&
			last.parts.length === parts.length &&
			last.parts.every((part, i) => part === parts[i])
		) {
			return last.rows;
		}
		const fill = applyBackgroundToLine("", width, value => theme.bg("userMessageBg", value));
		const rows = [...hit.rows];
		for (let i = 0; i < parts.length; i += 2) {
			const lines = (parts[i] as readonly string[] | undefined) ?? [];
			for (const line of lines) rows.push(boxed(line, width, fill));
			for (let n = lines.length; n < (parts[i + 1] as number); n++) rows.push(fill);
		}
		framed.set(this, { base: hit.rows, width, parts, rows });
		return rows;
	};
}

function install(state: State): void {
	const findBubble = (children: readonly object[]): void => {
		for (const child of children) {
			if (!("setReaction" in child) || typeof child.setReaction !== "function") continue;
			patchBubble(Object.getPrototypeOf(child) as Proto, state);
			state.patched = true;
			return;
		}
	};
	const containerProto = TranscriptContainer.prototype as unknown as Proto;
	// Replayed sessions may move blocks in without addChild, so render paths scan too until found.
	for (const name of ["addChild", "render", "renderViewport", "renderTail", "beginFrame"]) {
		const orig = containerProto[name];
		if (orig === undefined) continue;
		containerProto[name] = function (this: TranscriptContainer, ...args: never[]) {
			if (!state.patched) findBubble(name === "addChild" ? (args as unknown as object[]) : this.children);
			return orig.apply(this, args);
		};
	}
	// The composer is the only handle to the TUI, whose image budget keeps one graphics id per preview.
	const composerProto = Composer.prototype as unknown as Proto;
	const renderFrame = composerProto.renderFrame;
	if (renderFrame !== undefined) {
		composerProto.renderFrame = function (this: Composer, ...args: never[]) {
			state.ui = this.ui;
			return renderFrame.apply(this, args);
		};
	}
}

export default function userBubble(pi: ExtensionAPI) {
	pi.setLabel("user-bubble");
	let state = globals[STATE_KEY];
	if (state === undefined) {
		state = { patched: false };
		globals[STATE_KEY] = state;
		install(state);
	}
	state.settings = pi.pi.settings;
}
