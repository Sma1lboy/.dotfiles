// Slash-command aliases, rewritten in the `input` hook (runs before omp parses slash commands).
//
// `/rewind` → `/checkpoint`: opens better-pi-rewind (restores files too) instead of omp's
// built-in conversation-only rewind. omp reserves built-in command names, so the plugin's
// own `/rewind` is skipped and only its `/checkpoint` alias registers.
//
// `/reload` and `/reload-plugins` → `/restart`: omp's `/reload-plugins` only rescans skills,
// file commands, agents and MCP; extension modules (npm plugins, extensions/*.ts) load once
// at startup and extensions have no API to unregister handlers. `/restart` relaunches omp with
// the same flags and resumes this session, which picks up everything. Both names are mapped
// because the composer autocompletes a bare `/reload` to `/reload-plugins` on Enter.
import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";

export default function slashAliases(pi: ExtensionAPI) {
	pi.setLabel("slash-aliases");
	pi.on("input", async event => {
		const text = event.text.trim();
		if (text === "/reload" || text === "/reload-plugins") return { text: "/restart" };
		const match = /^\/rewind(\s.*)?$/s.exec(text);
		if (match) return { text: `/checkpoint${match[1] ?? ""}` };
	});
}
