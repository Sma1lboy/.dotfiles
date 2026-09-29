// Turn activity for omp, the way Claude Code shows it: while a run is going the
// working row reads what the agent is doing and for how long ("Thinking · 12s",
// "Reading config files · 1m 05s"), and every finished run leaves a dim
// "Worked for 1m 23s" line in the transcript.
import type { ExtensionAPI, ExtensionContext } from "@oh-my-pi/pi-coding-agent";

const TICK_MS = 1000;
/** The field omp's tools carry their intent in (`tools.intentTracing`). */
const INTENT_FIELD = "i";
const WAITING = "Waiting for model";

function fmtElapsed(ms: number): string {
	const s = Math.max(0, Math.floor(ms / 1000));
	if (s < 60) return `${s}s`;
	const m = Math.floor(s / 60);
	if (m < 60) return `${m}m ${String(s % 60).padStart(2, "0")}s`;
	return `${Math.floor(m / 60)}h ${String(m % 60).padStart(2, "0")}m`;
}

/** An intent as the working row shows it: trimmed, no trailing dots; empty when absent. */
function labelOf(intent: unknown): string {
	return typeof intent === "string" ? intent.trim().replace(/\s*\.+$/, "") : "";
}

export default function turnline(pi: ExtensionAPI) {
	pi.setLabel("turnline");
	let startedAt: number | null = null;
	let phase = WAITING;
	let timer: Timer | undefined;
	/** Tools executing right now, by call id: parallel calls fall back to the one still running. */
	const running = new Map<string, string>();

	function show(ctx: ExtensionContext): void {
		if (startedAt === null || !ctx.hasUI) return;
		ctx.ui.setWorkingMessage(`${phase} · ${fmtElapsed(Date.now() - startedAt)}`);
	}

	function setPhase(ctx: ExtensionContext, next: string): void {
		if (!next || next === phase) return;
		phase = next;
		show(ctx);
	}

	// Subagent sessions rerun this factory; only the main session owns the working row.
	pi.on("agent_start", async (_event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		// An automatic continuation (retry, queued follow-up) keeps the run's clock.
		startedAt ??= Date.now();
		phase = WAITING;
		running.clear();
		timer ??= ctx.setInterval(() => show(ctx), TICK_MS);
		show(ctx);
	});

	pi.on("turn_start", async (_event, ctx) => {
		if (ctx.agent.kind === "main" && running.size === 0) setPhase(ctx, WAITING);
	});

	pi.on("message_update", async (event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		switch (event.assistantMessageEvent.type) {
			case "thinking_start":
			case "thinking_delta":
				setPhase(ctx, "Thinking");
				return;
			case "text_start":
			case "text_delta":
				setPhase(ctx, "Writing");
				return;
			case "toolcall_start":
			case "toolcall_delta": {
				const msg = event.message;
				if (msg.role !== "assistant") return;
				const call = msg.content.findLast(c => c.type === "toolCall");
				if (!call || call.type !== "toolCall") return;
				setPhase(ctx, labelOf(call.arguments?.[INTENT_FIELD]) || `Calling ${call.name}`);
				return;
			}
		}
	});

	pi.on("tool_execution_start", async (event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		const label = labelOf(event.intent) || `Running ${event.toolName}`;
		running.set(event.toolCallId, label);
		setPhase(ctx, label);
	});

	pi.on("tool_execution_end", async (event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		running.delete(event.toolCallId);
		setPhase(ctx, [...running.values()].at(-1) ?? WAITING);
	});

	pi.on("agent_end", async (event, ctx) => {
		if (ctx.agent.kind !== "main" || event.willContinue || startedAt === null) return;
		const elapsed = fmtElapsed(Date.now() - startedAt);
		startedAt = null;
		running.clear();
		if (timer !== undefined) ctx.clearTimer(timer);
		timer = undefined;
		if (!ctx.hasUI) return;
		ctx.ui.setWorkingMessage();
		const last = event.messages.findLast(m => m.role === "assistant");
		const aborted = last?.role === "assistant" && last.stopReason === "aborted";
		ctx.ui.notify(aborted ? `Interrupted after ${elapsed}` : `Worked for ${elapsed}`, "info");
	});
}
