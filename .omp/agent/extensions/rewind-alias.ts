// `/rewind` opens better-pi-rewind (restores files too) instead of omp's built-in
// conversation-only rewind. omp reserves built-in command names, so the plugin's own
// `/rewind` is skipped and only its `/checkpoint` alias registers; the `input` hook runs
// before slash-command parsing, so rewriting the text here reroutes it.
import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";

export default function rewindAlias(pi: ExtensionAPI) {
	pi.setLabel("rewind-alias");
	pi.on("input", async event => {
		const match = /^\/rewind(\s.*)?$/s.exec(event.text.trim());
		if (!match) return;
		return { text: `/checkpoint${match[1] ?? ""}` };
	});
}
