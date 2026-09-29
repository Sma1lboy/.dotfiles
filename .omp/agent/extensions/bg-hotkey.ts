// Ctrl+B Ctrl+B moves the foreground bash/eval command to the background, like Claude Code.
//
// omp has no direct "background this" API for extensions. It does background an
// auto-background candidate when a steering message is queued mid-batch (the agent
// loop raises `toolCall.steeringSignal`, bash/eval see it and return a job id).
// So the second press queues a short steering note; the command keeps running and
// its result is delivered later as a background job.
//
// Only works where omp itself can background: `bash.autoBackground.enabled` (or
// `eval.autoBackground.enabled`), no `pty`, not a named service, `interruptMode: immediate`.
// Overrides the editor's Ctrl+B (cursor left); the Left arrow still moves the cursor.
import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";
import { lookup } from "@oh-my-pi/pi-coding-agent/config/registry";

const KEY = "ctrl+b";
const DOUBLE_PRESS_MS = 800;
const STEER_TEXT =
	"[Ctrl+B] The user moved the running command to the background. It keeps running and its result will be delivered automatically. Continue with other work; do not wait for or poll it.";

export default function bgHotkey(pi: ExtensionAPI) {
	pi.setLabel("bg-hotkey");
	/** Foreground calls omp can background, by call id → tool name. */
	const candidates = new Map<string, string>();
	let armedAt = 0;
	/** One steer per batch: a second one would only add noise to the transcript. */
	let steered = false;

	function isCandidate(toolName: string, args: unknown): boolean {
		const a = (args ?? {}) as Record<string, unknown>;
		if (toolName === "bash") {
			const on = lookup("bash.autoBackground.enabled")?.get(pi.pi.settings) === true;
			return on && a.pty !== true && !a.name && a.async !== true;
		}
		if (toolName === "eval") return lookup("eval.autoBackground.enabled")?.get(pi.pi.settings) === true;
		return false;
	}

	pi.on("tool_execution_start", async (event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		if (isCandidate(event.toolName, event.args)) candidates.set(event.toolCallId, event.toolName);
	});

	pi.on("tool_execution_end", async (event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		candidates.delete(event.toolCallId);
		if (candidates.size === 0) steered = false;
	});

	pi.on("agent_end", async (_event, ctx) => {
		if (ctx.agent.kind !== "main") return;
		candidates.clear();
		steered = false;
		armedAt = 0;
	});

	pi.registerShortcut(KEY, {
		description: "Press twice: move the running bash/eval command to the background",
		handler(ctx) {
			if (candidates.size === 0 || ctx.isIdle()) {
				armedAt = 0;
				return;
			}
			if (steered) {
				ctx.ui.notify("Already moving to background…", "info");
				return;
			}
			const now = Date.now();
			if (now - armedAt > DOUBLE_PRESS_MS) {
				armedAt = now;
				ctx.ui.notify("Press Ctrl+B again to move the command to the background", "info");
				return;
			}
			armedAt = 0;
			steered = true;
			pi.sendMessage(
				{ customType: "bg-hotkey", content: STEER_TEXT, display: false, attribution: "user" },
				{ deliverAs: "steer" },
			);
			ctx.ui.notify(`Moving ${[...new Set(candidates.values())].join("/")} to the background`, "info");
		},
	});
}
