// Claude Code's advisor for omp: an `advisor` tool the working model calls at
// decision points (before committing to an approach, when stuck, before
// declaring done). The call forwards the whole conversation to a stronger model
// and returns its guidance as the tool result.
//
// Not omp's own /advisor: that one is a watchdog reviewing every turn in the
// background and injecting notes on its own. This one runs only when the working
// model asks. Claude Code runs it server-side (the `advisor_20260301` API tool);
// omp's Anthropic transport does not keep that tool's blocks, so here the tool
// makes the call itself, rendering the transcript with omp's advisor renderer.
//
// Model: `modelRoles.consult` if set, else `modelRoles.advisor`.
import { type AssistantMessage, completeSimple, type Effort } from "@oh-my-pi/pi-ai";
import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";
import { buildSessionContext } from "@oh-my-pi/pi-coding-agent/session/session-context";
import { formatSessionHistoryMarkdown } from "@oh-my-pi/pi-coding-agent/session/session-history-format";
import { SessionManager } from "@oh-my-pi/pi-coding-agent/session/session-manager";

// omp's own advisor render options (`ADVISOR_RENDER_OPTIONS` in advisor/delta-split.ts,
// which the binary does not expose to extensions): tool intent, diffs and tool I/O expanded.
const RENDER_OPTIONS = {
	includeToolIntent: true,
	watchedRoles: true,
	expandPrimaryContext: true,
	expandEditDiffs: true,
	expandToolIO: true,
	includeThinking: true,
} as const;

// `Effort` is a const enum the binary does not export as a value; its members are these strings.
const HIGH_EFFORT = "high" as Effort;

// Claude Code 2.1.284 puts this section in its system prompt, not in the tool
// description; verbatim apart from the parameter note.
const PROMPT_SECTION = `# Advisor Tool
You have access to an \`advisor\` tool backed by a stronger reviewer model. It takes no arguments beyond your intent -- when you call advisor(), your entire conversation history is automatically forwarded. They see the task, every tool call you've made, every result you've seen.
Call advisor BEFORE substantive work -- before writing, before committing to an interpretation, before building on an assumption. If the task requires orientation first (finding files, fetching a source, seeing what's there), do that, then call advisor. Orientation is not substantive work. Writing, editing, and declaring an answer are.
Also call advisor:
- When you believe the task is complete. BEFORE this call, make your deliverable durable: write the file, save the result, commit the change. The advisor call takes time; if the session ends during it, a durable result persists and an unwritten one doesn't.
- When stuck -- errors recurring, approach not converging, results that don't fit.
- When considering a change of approach.
On tasks longer than a few steps, call advisor at least once before committing to an approach and once before declaring done. On short reactive tasks where the next action is dictated by tool output you just read, you don't need to keep calling -- the advisor adds most of its value on the first call, before the approach crystallizes.
Give the advice serious weight. If you follow a step and it fails empirically, or you have primary-source evidence that contradicts a specific claim (the file says X, the paper states Y), adapt. A passing self-test is not evidence the advice is wrong -- it's evidence your test doesn't check what the advice is checking.
If you've already retrieved data pointing one way and the advisor points another: don't silently switch. Surface the conflict in one more advisor call -- "I found X, you suggest Y, which constraint breaks the tie?" The advisor saw your evidence but may have underweighted it; a reconcile call is cheaper than committing to the wrong branch.`;

const DESCRIPTION =
	"Consult a stronger reviewer model. Your whole conversation is forwarded; its guidance comes back as the result. When to call it: see the Advisor Tool section of your instructions.";

const SYSTEM_PROMPT = `You are the advisor to a coding agent (the executor). The executor has paused mid-task to consult you and will act on your answer before continuing. You get the executor's own instructions and its full transcript as quoted context: the user's requests, its reasoning, every tool call and result. The transcript ends at the advisor call.

Read what the executor is working on and answer what it needs at this point:
- Before substantive work: the approach you would take, and the traps in the one it is leaning toward.
- When stuck: the likely root cause from the evidence in the transcript, and the next check that would confirm it.
- Before declaring done: whether the deliverable meets the request, and what is unverified, missing or wrong.
- If the executor's last message poses a question or a conflict, answer that first.

Be concrete: name files, symbols, commands, the claim you disagree with. Say what is wrong and what to do instead; skip praise and restating the task. If the executor is on track, say so in one line and name anything left to verify. You have no tools and cannot see anything beyond the transcript; say when a point depends on something the executor should check. Keep it under 300 words unless the situation needs a plan.`;

/** Output cap per consultation, thinking included. */
const MAX_TOKENS = 16_384;
/** Rough bytes per token when fitting the transcript into the advisor's context. */
const BYTES_PER_TOKEN = 3;
/** Share of an over-long transcript kept from its start (the task); the rest comes from its end. */
const HEAD_SHARE = 0.2;

function fitTranscript(text: string, maxChars: number): string {
	if (text.length <= maxChars) return text;
	const head = Math.floor(maxChars * HEAD_SHARE);
	const tail = maxChars - head;
	return `${text.slice(0, head)}\n\n[… ${text.length - maxChars} characters of the middle of the transcript omitted …]\n\n${text.slice(-tail)}`;
}

function textOf(message: AssistantMessage): string {
	return message.content
		.filter(c => c.type === "text")
		.map(c => c.text)
		.join("")
		.trim();
}

export default function consultAdvisor(pi: ExtensionAPI) {
	pi.setLabel("consult-advisor");
	const params = pi.arktype({});

	// Appended every prompt with the same bytes, so the cached prefix is stable after the first request.
	pi.on("before_agent_start", async event => ({ systemPrompt: [...event.systemPrompt, PROMPT_SECTION] }));

	pi.registerTool<typeof params, { model: string; ms: number; usd: number }>({
		name: "advisor",
		label: "Advisor",
		description: DESCRIPTION,
		parameters: params,
		// Top level, not an `xd://` device: the model has to see it to reach for it.
		loadMode: "essential",
		async execute(_toolCallId, _params, signal, _onUpdate, ctx) {
			const model = ctx.models.resolve("@consult") ?? ctx.models.resolve("@advisor");
			if (!model) throw new Error("No advisor model: set modelRoles.consult or modelRoles.advisor");
			const sessionId = ctx.sessionManager.getSessionId();
			if (!(await ctx.modelRegistry.getApiKey(model, sessionId))) {
				throw new Error(`Advisor unavailable (no credentials for ${model.provider}/${model.id})`);
			}

			const sm = ctx.sessionManager;
			const { messages } = buildSessionContext(sm.getEntries(), sm.getLeafId());
			const transcript = formatSessionHistoryMarkdown(messages, RENDER_OPTIONS);
			const instructions = ctx.getSystemPrompt().join("\n\n");
			const budget = ((model.contextWindow ?? 200_000) - MAX_TOKENS) * BYTES_PER_TOKEN - SYSTEM_PROMPT.length;
			const quoted = fitTranscript(
				`<executor-instructions>\n${instructions}\n</executor-instructions>\n\n<transcript>\n${transcript}\n</transcript>`,
				Math.max(budget, 100_000),
			);

			const started = Date.now();
			const reply = await completeSimple(
				model,
				{
					systemPrompt: [SYSTEM_PROMPT],
					messages: [
						{
							role: "user",
							content: `${quoted}\n\nThe executor has called the advisor. Advise it now.`,
							timestamp: Date.now(),
						},
					],
				},
				{
					apiKey: ctx.modelRegistry.resolver(model, sessionId),
					sessionId,
					maxTokens: MAX_TOKENS,
					reasoning: HIGH_EFFORT,
					signal,
				},
			);
			const ms = Date.now() - started;

			// Book the advisor's tokens on the session, as omp books a cache-warm request,
			// so the status line and usage totals include them. `ctx.sessionManager` is
			// typed read-only; the live object is the session's SessionManager.
			if (reply.usage.totalTokens > 0 && sm instanceof SessionManager) {
				sm.appendModelUsage(
					{
						purpose: "consult-advisor",
						api: reply.api,
						provider: reply.provider,
						model: reply.model,
						usage: reply.usage,
						stopReason: reply.stopReason,
					},
					{ sessionId, parentId: sm.getLeafId() },
				);
			}

			if (reply.stopReason === "error" || reply.stopReason === "aborted") {
				throw new Error(`Advisor unavailable (${reply.errorMessage ?? reply.stopReason})`);
			}
			const advice = textOf(reply) || "Advisor declined to advise on this request.";
			// The first line is what the collapsed tool card shows: who advised, how long, what it cost.
			const header = `${model.name ?? model.id} · ${Math.round(ms / 1000)}s · $${reply.usage.cost.total.toFixed(2)}`;
			return {
				content: [{ type: "text", text: `${header}\n\n${advice}` }],
				details: { model: `${model.provider}/${model.id}`, ms, usd: reply.usage.cost.total },
			};
		},
	});
}
