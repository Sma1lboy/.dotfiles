// Goal and loop as tools the model calls from what you say, the way Claude Code's
// ProposeGoal / CronCreate / ScheduleWakeup work, instead of /goal and /loop.
//  - goal: omp's own goal mode (re-prompts after every turn until the model
//    completes the goal), kept callable at all times instead of only after /goal.
//  - loop: re-runs a task after each run ends, after a delay, until a shell check
//    passes, a run cap is hit, the model stops it, or you press Esc.
import type { ExtensionAPI, ExtensionContext } from "@oh-my-pi/pi-coding-agent";

const GOAL_DESCRIPTION = `Goal mode: keep working across turns until an objective is verifiably done; omp re-prompts you after every turn while a goal is active.

Call \`create\` when the user describes an end state to reach or asks you to keep going until something holds ("keep going until the tests pass", "一直改到构建通过", "做完 X 再停"). Put their completion condition in \`objective\`, concrete and checkable; pass \`token_budget\` only when they gave one. Do not create a goal for an ordinary single request.

- \`create\`: starts goal mode. Requires \`objective\`; optional positive \`token_budget\`. Only when no goal is active or paused.
- \`get\`: current goal and remaining token budget.
- \`resume\`: re-activates a paused goal; a paused goal from \`get\` MUST be resumed before continuing work.
- \`complete\`: only when every deliverable is verified against current evidence. NEVER because the budget is low or the turn is ending.
- \`drop\`: when the user says to stop or abandon the goal.`;

const LOOP_DESCRIPTION = `Re-run a task on a schedule in this session. Call \`start\` when the user asks for something repeated or polled ("每 5 分钟看一下 CI", "check the deploy every few minutes", "keep retrying until the endpoint answers"). Do the first run now, in this turn; the loop sends \`prompt\` back as a new message \`delay_seconds\` after each run ends. Prefer this over sleeping inside a turn once the waits add up to more than a minute: the session stays free for the user between runs.

- \`start\`: replaces any running loop. \`prompt\` is the task as the user would type it. \`until\` is a shell command checked before each run; exit 0 ends the loop (e.g. \`gh run view 123 --json status -q .status | grep -qx completed\`). \`max_runs\` caps the scheduled runs, not counting the one you do now (default 20).
- \`stop\`: ends the loop. Call it when the task no longer needs repeating.
- \`status\`: the running loop, if any.

Pick \`delay_seconds\` from what you are waiting for, not round minutes. Iterating on work until it is done: 0. Polling CI, a deploy or a queue: how fast that state changes (an ~8-minute CI run deserves one ~480s wait, not eight 60s ones). Idle heartbeat: 1200–1800. The prompt cache lasts 5 minutes on API keys and 1 hour on Claude subscriptions; waking after it expires re-reads the whole context uncached, so on a 5-minute cache prefer 270 over 300, or commit to 1200+.

For polling where each check decides the next wait, use \`max_runs: 1\` and call \`start\` again at the end of each run with the new delay; not calling it ends the loop.`;

const DEFAULT_MAX_RUNS = 20;
const MAX_RUNS_CAP = 200;
const MAX_DELAY_S = 86_400;
const UNTIL_TIMEOUT_MS = 30_000;

type Loop = {
	prompt: string;
	delayMs: number;
	until: string | undefined;
	maxRuns: number;
	runs: number;
	nextAt: number | null;
};

function fmtDelay(ms: number): string {
	const s = Math.round(ms / 1000);
	if (s < 60) return `${s}s`;
	if (s < 3600) return s % 60 ? `${Math.floor(s / 60)}m${s % 60}s` : `${s / 60}m`;
	return `${Math.floor(s / 3600)}h${String(Math.floor((s % 3600) / 60)).padStart(2, "0")}`;
}

export default function goalLoop(pi: ExtensionAPI) {
	pi.setLabel("goal-loop");
	const type = pi.arktype;

	let loop: Loop | null = null;
	let timer: Timer | undefined;

	function describe(l: Loop): string {
		const parts = [`"${l.prompt}"`, `every ${fmtDelay(l.delayMs)} after a run ends`, `run ${l.runs}/${l.maxRuns}`];
		if (l.until) parts.push(`until \`${l.until}\` exits 0`);
		if (l.nextAt !== null) parts.push(`next at ${new Date(l.nextAt).toLocaleTimeString()}`);
		return parts.join(", ");
	}

	function showStatus(ctx: ExtensionContext): void {
		if (!ctx.hasUI) return;
		if (!loop) {
			ctx.ui.setStatus("loop", undefined);
			return;
		}
		const next = loop.nextAt === null ? "" : ` · next ${new Date(loop.nextAt).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}`;
		ctx.ui.setStatus("loop", `loop ${loop.runs}/${loop.maxRuns}${next}`);
	}

	function endLoop(ctx: ExtensionContext, why: string | undefined): void {
		if (timer !== undefined) ctx.clearTimer(timer);
		timer = undefined;
		loop = null;
		showStatus(ctx);
		if (why && ctx.hasUI) ctx.ui.notify(why, "info");
	}

	async function fire(ctx: ExtensionContext): Promise<void> {
		timer = undefined;
		const l = loop;
		if (!l) return;
		l.nextAt = null;
		// You started something in the meantime; the loop rearms when that run ends.
		if (!ctx.isIdle()) return;
		if (l.until) {
			const r = await pi.exec("sh", ["-c", l.until], { cwd: ctx.cwd, timeout: UNTIL_TIMEOUT_MS });
			if (r.killed) {
				endLoop(ctx, `Loop stopped: \`${l.until}\` did not finish within ${UNTIL_TIMEOUT_MS / 1000}s`);
				return;
			}
			if (r.code === 0) {
				endLoop(ctx, `Loop done: \`${l.until}\` passed after ${l.runs} runs`);
				return;
			}
		}
		if (l.runs >= l.maxRuns) {
			endLoop(ctx, `Loop stopped after ${l.runs} runs (max_runs)`);
			return;
		}
		l.runs++;
		showStatus(ctx);
		pi.sendUserMessage(
			`${l.prompt}\n\n(loop run ${l.runs}/${l.maxRuns} — call loop with op "stop" once this no longer needs repeating)`,
		);
	}

	function arm(ctx: ExtensionContext): void {
		const l = loop;
		if (!l) return;
		if (timer !== undefined) ctx.clearTimer(timer);
		l.nextAt = Date.now() + l.delayMs;
		timer = ctx.setTimeout(() => void fire(ctx), l.delayMs);
		showStatus(ctx);
	}

	const goalParams = type({
		op: type("'create' | 'get' | 'complete' | 'resume' | 'drop'").describe("goal operation"),
		"objective?": type("string").describe("goal objective: the checkable end state"),
		"token_budget?": type("number.integer").describe("token budget"),
	});
	const loopParams = type({
		op: type("'start' | 'stop' | 'status'").describe("loop operation"),
		"prompt?": type("string").describe("task to re-run, as the user would type it"),
		"delay_seconds?": type("number").describe("wait after each run ends before the next (default 0)"),
		"until?": type("string").describe("shell command checked before each run; exit 0 ends the loop"),
		"max_runs?": type("number.integer").describe(`run cap (default ${DEFAULT_MAX_RUNS})`),
	});

	pi.registerTool<typeof goalParams>({
		name: "goal",
		label: "Goal",
		description: GOAL_DESCRIPTION,
		parameters: goalParams,
		// Top level, not an `xd://` device: the model has to see it to reach for it from plain words.
		loadMode: "essential",
		async execute(_toolCallId, params, signal, onUpdate, ctx) {
			// Delegates to omp's goal tool, so goal mode, its budget and its status indicator stay native.
			if (!ctx.invokeTool) throw new Error("omp goal mode is unavailable here (goal.enabled is off, or this is a subagent)");
			return ctx.invokeTool(params, { signal, onUpdate });
		},
	});

	pi.registerTool<typeof loopParams, { loop: Loop | null }>({
		name: "loop",
		label: "Loop",
		description: LOOP_DESCRIPTION,
		parameters: loopParams,
		loadMode: "essential",
		async execute(_toolCallId, params, _signal, _onUpdate, ctx) {
			const text = (t: string) => ({ content: [{ type: "text" as const, text: t }], details: { loop } });
			if (ctx.agent.kind !== "main") throw new Error("loop runs only in the main session");
			if (params.op === "stop") {
				const was = loop;
				endLoop(ctx, undefined);
				return text(was ? `Loop stopped after ${was.runs} runs.` : "No loop was running.");
			}
			if (params.op === "status") return text(loop ? `Loop: ${describe(loop)}` : "No loop is running.");
			const prompt = params.prompt?.trim();
			if (!prompt) throw new Error("prompt is required when op=start");
			const delay = Math.min(Math.max(0, params.delay_seconds ?? 0), MAX_DELAY_S);
			const maxRuns = Math.min(Math.max(1, params.max_runs ?? DEFAULT_MAX_RUNS), MAX_RUNS_CAP);
			if (timer !== undefined) ctx.clearTimer(timer);
			timer = undefined;
			loop = { prompt, delayMs: delay * 1000, until: params.until?.trim() || undefined, maxRuns, runs: 0, nextAt: null };
			// Armed when this run ends; starting from idle (no run to wait for) arms now.
			if (ctx.isIdle()) arm(ctx);
			else showStatus(ctx);
			return text(`Loop started: ${describe(loop)}. The first scheduled run follows this one.`);
		},
	});

	pi.on("agent_end", async (event, ctx) => {
		if (ctx.agent.kind !== "main" || event.willContinue || !loop) return;
		const last = event.messages.findLast(m => m.role === "assistant");
		if (last?.role === "assistant" && last.stopReason === "aborted") {
			endLoop(ctx, "Loop stopped: interrupted");
			return;
		}
		arm(ctx);
	});

	// A new or resumed session starts without the previous conversation's loop.
	pi.on("session_switch", async (_event, ctx) => {
		if (ctx.agent.kind === "main" && loop) endLoop(ctx, undefined);
	});
}
