# omp model-watch (cloud routine)

Runs daily as a Claude Code cloud routine against this repo (`Sma1lboy/.dotfiles`). Goal: keep
`.omp/agent/config.yml` → `modelRoles` on the newest model of each family, and track coding/agent
benchmarks. The local machine pulls `modelRoles` from `origin/main` on every `omp` launch
(`.omp/sync-model-roles.sh`), so pushing to `main` is how changes land. Report in Chinese.

## Part 1 — Anthropic / OpenAI same-family upgrades (highest priority)

1. Find the model ids the newest omp knows about (the local launcher runs `omp update` after a
   sync, so ids from the latest catalog are usable locally):
   ```bash
   mkdir -p /tmp/pc && cd /tmp/pc && curl -sL "$(npm view @oh-my-pi/pi-catalog dist.tarball)" | tar -xz
   ```
   - `openai-codex` ids = keys of `package/src/models.json["openai-codex"]` ∪ ids in
     `models "..."` lines of `package/src/compat/rules/providers/openai-codex.kdl`
     (Codex models are discovered at runtime, so new ones often appear only in the `.kdl`).
   - `anthropic` ids = keys of `package/src/models.json["anthropic"]` ∪ ids in
     `package/src/compat/rules/providers/anthropic.kdl`.
   - Cross-check announcements on openai.com / anthropic.com news for anything released but not
     yet in the catalog; mention those in the report but do not use them yet.
2. For each role in `modelRoles`, upgrade within the same provider and family only, never
   downgrade:
   - family = series name without version: `gpt-*-astra`, `gpt-*-sol`, `gpt-*-luna`,
     `claude-opus-*`, `claude-sonnet-*`, `claude-fable-*`, `claude-mythos-*`, `claude-haiku-*`…
     e.g. `gpt-6-sol` → `gpt-6.1-sol`, `claude-opus-5-5` → a newer `claude-opus-*`.
   - Skip `-pro`, `-wm`, `:batch`, dated snapshots (`-20250929`), and `*-latest` aliases unless the
     role already uses that variant.
   - Never switch provider or family.
3. If anything changes: edit only those lines under `modelRoles` (leave every other line in the
   file byte-identical), commit `omp: bump modelRoles (<old> → <new>, …)` and push directly to
   `main`. Pull/rebase first if `main` moved. No change → no commit.

## Part 2 — Benchmark watch (report only, never edit config from this)

Benchmarks of interest: SWE-bench (Verified/Pro), DeepSWE, Terminal-Bench (all versions), and
agentic suites (AutomationBench, OSWorld, Agents' Last Exam, BrowseComp…).
Sources: benchlm.ai, artificialanalysis.ai, vals.ai, tbench.ai, swebench.com, vendor launch posts.

- List models released or re-scored since the previous entry in `HISTORY.md` (any vendor:
  Google, xAI, Moonshot, Zhipu, DeepSeek, Qwen, …).
- Compare against the models currently in `modelRoles`; flag any candidate clearly stronger on the
  benchmarks above and available in omp, with a suggested role. Suggestion only.
- Cite the source URL and benchmark version for every score; never compare across versions.

## Record & report

Append a dated entry to `.omp/model-watch/HISTORY.md` (Part 1 changes or "no change", Part 2
highlights with links) and include it in the same push. Final message: conclusion first — Part 1
old → new, then the 3–5 most notable Part 2 items.
