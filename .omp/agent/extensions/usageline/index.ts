// usageline for omp: a line under the editor with the context size, output speed, the prompt
// cache's time left, the last run's cache hit rate, why a request rewrote the cache, and what
// this project has cost today across every session; /usageline prints the ledger.
// Port of the claude-mods usageline mod (~/i/claude-mods/usageline).
import * as fs from "node:fs/promises";
import * as path from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@oh-my-pi/pi-coding-agent";
import {
	type CacheTokens,
	dayOf,
	fmtCountdown,
	fmtPct,
	fmtTokens,
	fmtUsd,
	hitRate,
	missReason,
	parseLines,
	type Rec,
	report,
} from "./ledger";

const WIDGET_KEY = "usageline";
/** Day files kept in the ledger directory. */
const KEEP_DAYS = 90;
const REPORT_DAYS = 7;
const TICK_MS = 1000;
/** Ticks between ledger flushes and rereads of today's file. */
const FLUSH_TICKS = 5;
/** Lifetimes by retention tier when the model catalog declares none (Anthropic's 5m and 1h). */
const FALLBACK_TTL_S = { short: 300, long: 3600 } as const;

type Tier = "short" | "long";
type Stats = { input: number; output: number; cacheRead: number; cacheWrite: number; cost: number };

export default function usageline(pi: ExtensionAPI) {
	pi.setLabel("usageline");
	const dir = path.join(pi.pi.getAgentDir(), "usageline");
	const fileOf = (day: string) => path.join(dir, `${day}.jsonl`);

	/** The context of the latest event: the tick reads the session through it. */
	let live: ExtensionContext | undefined;
	let project = "";
	let model = "";
	/** Session totals already written to the ledger. */
	let baseline: Stats | undefined;
	/** Main-agent responses since the last ledger line. */
	let pendingReqs = 0;
	/** cacheRead + cacheWrite as last seen by the tick: growth while idle is a warm refresh. */
	let seenCacheTokens = 0;
	let working = false;
	let requestStartMs: number | null = null;
	let lastTouchMs: number | null = null;
	let prevModel: string | null = null;
	let tier: Tier | undefined;
	let compactedSince = false;
	/** Cache tokens of the running (or last) agent run's main-agent responses. */
	let run: CacheTokens | null = null;
	let miss: { reason: string; written: number } | null = null;
	/** This project's spend in today's day file, read incrementally from `offset`. */
	let today = { day: "", offset: 0, usd: 0 };
	/** Main-branch output tokens and request time, for ccstatusline's session-wide output-speed. */
	let speed = { out: 0, ms: 0 };
	let reading = false;
	let ticks = 0;
	let drawn = "";

	function statsOf(ctx: ExtensionContext): Stats {
		const s = ctx.sessionManager.getUsageStatistics();
		return { input: s.input, output: s.output, cacheRead: s.cacheRead, cacheWrite: s.cacheWrite, cost: s.cost };
	}

	/** Starts the ledger from the session's current totals without recording them. */
	function rebaseline(ctx: ExtensionContext): void {
		baseline = statsOf(ctx);
		seenCacheTokens = baseline.cacheRead + baseline.cacheWrite;
		pendingReqs = 0;
	}

	/** Appends what the session's totals grew by since the last line. */
	async function flush(ctx: ExtensionContext): Promise<void> {
		const now = statsOf(ctx);
		const b = baseline;
		// A new, resumed or reloaded session restarts its totals: nothing to attribute.
		if (!b || now.input < b.input || now.output < b.output || now.cost < b.cost - 1e-9) {
			rebaseline(ctx);
			return;
		}
		const rec: Rec = {
			t: Date.now(),
			p: project,
			m: model || ctx.model?.id || "",
			n: pendingReqs,
			i: now.input - b.input,
			o: now.output - b.output,
			cr: now.cacheRead - b.cacheRead,
			cw: now.cacheWrite - b.cacheWrite,
			usd: now.cost - b.cost,
		};
		if (rec.n === 0 && rec.i + rec.o + rec.cr + rec.cw === 0 && rec.usd <= 0) return;
		baseline = now;
		pendingReqs = 0;
		try {
			await fs.mkdir(dir, { recursive: true });
			// One short line per append: O_APPEND keeps concurrent sessions' lines whole.
			await fs.appendFile(fileOf(dayOf(rec.t)), `${JSON.stringify(rec)}\n`);
		} catch (error) {
			pi.logger.warn("usageline: ledger append failed", { error: String(error) });
		}
	}

	/** Adds the lines other sessions (and this one) appended to today's file since the last read. */
	async function readToday(): Promise<void> {
		if (reading) return;
		reading = true;
		try {
			const day = dayOf(Date.now());
			if (today.day !== day) today = { day, offset: 0, usd: 0 };
			const file = Bun.file(fileOf(day));
			const size = file.size;
			if (size <= today.offset) return;
			const chunk = await file.slice(today.offset, size).arrayBuffer();
			const text = new TextDecoder().decode(chunk);
			const end = text.lastIndexOf("\n") + 1;
			if (end === 0) return;
			today.offset += Buffer.byteLength(text.slice(0, end));
			for (const r of parseLines(text.slice(0, end))) if (r.p === project) today.usd += r.usd;
		} catch {
			// no file yet
		} finally {
			reading = false;
		}
	}

	async function readRecent(days: number): Promise<Rec[]> {
		const recs: Rec[] = [];
		const now = Date.now();
		for (let d = 0; d < days; d++) {
			try {
				recs.push(...parseLines(await Bun.file(fileOf(dayOf(now - d * 86_400_000))).text()));
			} catch {
				// no usage that day
			}
		}
		return recs;
	}

	async function prune(): Promise<void> {
		const oldest = dayOf(Date.now() - KEEP_DAYS * 86_400_000);
		try {
			for (const name of await fs.readdir(dir)) {
				if (/^\d{4}-\d{2}-\d{2}\.jsonl$/.test(name) && name.slice(0, 10) < oldest) await fs.rm(path.join(dir, name));
			}
		} catch {
			// no ledger yet
		}
	}

	/** The git repository's main root, so every worktree of a repo books to one project; else the cwd. */
	async function projectOf(cwd: string): Promise<string> {
		try {
			const r = await pi.exec("git", ["rev-parse", "--path-format=absolute", "--git-common-dir"], { cwd, timeout: 3000 });
			const common = r.stdout.trim();
			if (r.code === 0 && common.endsWith("/.git")) return path.dirname(common);
			const top = await pi.exec("git", ["rev-parse", "--show-toplevel"], { cwd, timeout: 3000 });
			if (top.code === 0 && top.stdout.trim()) return top.stdout.trim();
		} catch {
			// not a repository
		}
		return cwd;
	}

	/** Lifetime of the cache entry last written; undefined for models that declare no prompt cache. */
	function ttlMs(ctx: ExtensionContext): number | undefined {
		const declared = ctx.model?.promptCache;
		const t: Tier = tier ?? "short";
		const seconds = declared?.[t] ?? (tier ? FALLBACK_TTL_S[t] : undefined);
		return seconds === undefined ? undefined : seconds * 1000;
	}

	function fmtCtxTokens(n: number): string {
		return n >= 999_950 ? `${(n / 1e6).toFixed(1)}M` : n >= 1000 ? `${(n / 1000).toFixed(1)}k` : String(n);
	}

	function speedOf(ctx: ExtensionContext): { out: number; ms: number } {
		const acc = { out: 0, ms: 0 };
		for (const entry of ctx.sessionManager.getBranch()) {
			if (entry.type !== "message" || entry.message.role !== "assistant") continue;
			const { usage, duration } = entry.message;
			if (!usage || !duration || duration <= 0) continue;
			acc.out += usage.output;
			acc.ms += duration;
		}
		return acc;
	}

	function lineOf(ctx: ExtensionContext): string {
		const th = ctx.ui.theme;
		const parts: string[] = [];
		const ttl = ttlMs(ctx);
		// ccstatusline's context-length widget: the last request's prompt size, gray, one decimal on k/M.
		const ctxTokens = ctx.getContextUsage()?.tokens;
		if (typeof ctxTokens === "number" && ctxTokens > 0) parts.push(th.fg("dim", `Ctx: ${fmtCtxTokens(ctxTokens)}`));
		if (speed.ms > 0 && speed.out > 0) {
			const tps = (speed.out * 1000) / speed.ms;
			parts.push(th.fg("accent", `Out: ${tps >= 1000 ? `${(tps / 1000).toFixed(1)}k` : tps.toFixed(1)} t/s`));
		}
		if (working) parts.push(`${th.fg("dim", "cache")} ${th.fg("success", "live")}`);
		else if (lastTouchMs !== null && ttl !== undefined) {
			const left = ttl - (Date.now() - lastTouchMs);
			const color = left <= 0 ? "error" : left / ttl > 0.5 ? "success" : left / ttl > 0.2 ? "warning" : "error";
			parts.push(`${th.fg("dim", "cache")} ${th.fg(color, left <= 0 ? "cold" : fmtCountdown(left))}`);
		}
		const rate = run ? hitRate(run) : null;
		if (rate !== null) parts.push(`${th.fg("dim", "hit")} ${th.fg("text", fmtPct(rate))}`);
		if (miss) parts.push(`${th.fg("dim", "miss")} ${th.fg("warning", `${miss.reason}, +${fmtTokens(miss.written)} rewritten`)}`);
		if (today.usd > 0) parts.push(`${th.fg("dim", "today")} ${th.fg("text", fmtUsd(today.usd))}`);
		return parts.join(th.fg("dim", " · "));
	}

	function draw(ctx: ExtensionContext): void {
		if (!ctx.hasUI) return;
		const line = lineOf(ctx);
		if (line === drawn) return;
		drawn = line;
		ctx.ui.setWidget(WIDGET_KEY, line ? [line] : undefined, { placement: "belowEditor" });
	}

	async function tick(): Promise<void> {
		const ctx = live;
		if (!ctx) return;
		// Cache tokens that grew with no run active came from a warm refresh or another
		// request on this session's cache, which restarted the entry's lifetime.
		const s = statsOf(ctx);
		const cacheTokens = s.cacheRead + s.cacheWrite;
		if (cacheTokens > seenCacheTokens && !working && lastTouchMs !== null) lastTouchMs = Date.now();
		seenCacheTokens = cacheTokens;
		if (++ticks % FLUSH_TICKS === 0) {
			await flush(ctx);
			await readToday();
		}
		draw(ctx);
	}

	/**
	 * Rebuilds the cache state from the session's own history, so a resumed or reloaded
	 * session shows the timer and hit rate of its last run instead of nothing.
	 */
	function restore(ctx: ExtensionContext): void {
		lastTouchMs = null;
		prevModel = null;
		compactedSince = false;
		run = null;
		for (const entry of ctx.sessionManager.getBranch()) {
			if (entry.type === "compaction") compactedSince = true;
			if (entry.type !== "message") continue;
			const msg = entry.message;
			if (msg.role === "user") run = null;
			if (msg.role !== "assistant" || !msg.usage) continue;
			const u = msg.usage;
			if (u.input + u.cacheRead + u.cacheWrite === 0) continue;
			if ((u.cttl?.ephemeral1h ?? 0) > 0) tier = "long";
			else if ((u.cttl?.ephemeral5m ?? 0) > 0) tier = "short";
			run ??= { input: 0, cacheRead: 0, cacheWrite: 0 };
			run.input += u.input;
			run.cacheRead += u.cacheRead;
			run.cacheWrite += u.cacheWrite;
			lastTouchMs = msg.timestamp;
			prevModel = msg.model;
			compactedSince = false;
		}
	}

	/** Takes over the cache state of the session being opened, not the previous one. */
	async function startSession(ctx: ExtensionContext): Promise<void> {
		live = ctx;
		const next = await projectOf(ctx.cwd);
		if (next !== project) {
			project = next;
			today = { day: "", offset: 0, usd: 0 };
		}
		rebaseline(ctx);
		model = ctx.model?.id ?? "";
		requestStartMs = null;
		restore(ctx);
		speed = speedOf(ctx);
		miss = null;
		await readToday();
		draw(ctx);
	}

	// Subagent sessions rerun this factory; their spend reaches the parent's totals
	// through the task result, so only the main session books and draws.
	pi.on("session_start", async (_event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		await startSession(ctx);
		await prune();
		ctx.setInterval(() => tick(), TICK_MS);
	});

	pi.on("session_before_switch", async (_event, ctx) => {
		if (ctx.agent.kind === "main") await flush(ctx);
	});

	pi.on("session_switch", async (_event, ctx) => {
		if (ctx.agent.kind === "main") await startSession(ctx);
	});

	// A branch rewrites the session file; its totals are not new spend.
	pi.on("session_before_branch", async (_event, ctx) => {
		if (ctx.agent.kind === "main") await flush(ctx);
	});

	pi.on("session_branch", async (_event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		rebaseline(ctx);
		speed = speedOf(ctx);
	});

	pi.on("agent_start", async (_event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		live = ctx;
		working = true;
		run = { input: 0, cacheRead: 0, cacheWrite: 0 };
		miss = null;
		draw(ctx);
	});

	pi.on("turn_start", async (_event, ctx) => {
		if (ctx.agent.kind === "main") requestStartMs = Date.now();
	});

	pi.on("message_end", async (event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		const msg = event.message;
		if (msg.role !== "assistant" || !msg.usage) return;
		if (msg.duration && msg.duration > 0) {
			speed.out += msg.usage.output;
			speed.ms += msg.duration;
		}
		live = ctx;
		const u = msg.usage;
		if (u.input + u.cacheRead + u.cacheWrite === 0) return;
		const now = Date.now();
		if ((u.cttl?.ephemeral1h ?? 0) > 0) tier = "long";
		else if ((u.cttl?.ephemeral5m ?? 0) > 0) tier = "short";
		const reason = missReason(u, {
			prevTouchMs: lastTouchMs,
			startMs: requestStartMs ?? now,
			prevModel,
			model: msg.model,
			compactedSince,
			ttlMs: ttlMs(ctx),
		});
		if (reason && !miss) miss = { reason, written: u.cacheWrite };
		if (run) {
			run.input += u.input;
			run.cacheRead += u.cacheRead;
			run.cacheWrite += u.cacheWrite;
		}
		lastTouchMs = now;
		prevModel = msg.model;
		model = msg.model;
		compactedSince = false;
		pendingReqs++;
		await flush(ctx);
		await readToday();
		draw(ctx);
	});

	pi.on("agent_end", async (event, ctx) => {
		if (ctx.agent.kind !== "main" || event.willContinue) return;
		working = false;
		draw(ctx);
	});

	pi.on("session_compact", async (_event, ctx) => {
		if (ctx.agent.kind === "main") compactedSince = true;
	});

	pi.on("session_shutdown", async (_event, ctx) => {
		if (ctx.agent.kind === "main") await flush(ctx);
	});

	pi.registerCommand("usageline", {
		description: "This project's token and cost ledger, by day",
		handler: async (_args, ctx) => {
			if (ctx.agent.kind === "main") await flush(ctx);
			const recs = await readRecent(REPORT_DAYS);
			ctx.ui.notify(report(recs, project || ctx.cwd, dayOf(Date.now()), REPORT_DAYS), "info");
		},
	});
}
