# model-watch history

## 2026-10-01
**Part 1**: `smol` openai-codex/gpt-6-sol → gpt-6.1-sol (id found in pi-catalog 18.4.9 `openai-codex.kdl`). All other roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6-luna). No newer anthropic ids in catalog; announcements not cross-checked beyond catalog.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- SWE-bench Pro (benchlm.ai/benchmarks/swe-bench-pro): Claude Opus 5.5 89.9%, Sonnet 5.5 81.3%, Fable 5.1 81.2%. morphllm lists a different standardized set (Muse Spark 1.1 61.5% public) — different version, not comparable.
- Terminal-Bench 4.0 (codingfleet.com / morphllm.com): Opus 5.5 66.4%, GPT-6 Astra 57.9%, Fable 5.1 55.8%, Opus 5 52.3%.
- Terminal-Bench 2.1: GLM 5.3 listed as new entrant (https://codingfleet.com/blog/terminal-bench-leaderboard-2026/), score not verified.
- benchlm.ai overall: GPT-6 Astra 88.69, Opus 5.5 87.68, Sonnet 5.5 83.28.
- No candidate clearly stronger than current modelRoles.


## 2026-10-02
**Part 1**: no change. pi-catalog 18.4.12: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl (mythos-5-1 and gpt-5.6-* are other/older families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- SWE-bench Pro (https://benchlm.ai/benchmarks/swe-bench-pro): unchanged — Opus 5.5 89.9%, Sonnet 5.5 81.3%, Fable 5.1 81.2%.
- Terminal-Bench 2.1 (https://benchlm.ai/benchmarks/terminalbench21, as of 2026-09-30): SWE-2 92.8%, GPT-5.6 Sol 91.9%, DeepSeek V4.1 Flash 90.6%; near saturation. SWE-2 / DeepSeek V4.1 Flash are new names; not in omp catalog.
- Terminal-Bench 4.0 (https://benchlm.ai/benchmarks/terminal-bench-4): GPT-6 Astra leads at 58.18% in this snapshot (previous entry cited Opus 5.5 66.4% from other sources — sources disagree, not comparable).
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-03
**Part 1**: no change. pi-catalog 18.5.1: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- SWE-bench Pro (https://benchlm.ai/benchmarks/swe-bench-pro, Oct 2026): unchanged — Opus 5.5 89.9%, Sonnet 5.5 81.3%, Fable 5.1 81.2%.
- Terminal-Bench 2.1 (https://benchlm.ai/benchmarks/terminalbench21, as of 2026-09-30): unchanged — SWE-2 92.8%, GPT-5.6 Sol 91.9%, DeepSeek V4.1 Flash 90.6%. SWE-2 not in omp catalog.
- Terminal-Bench 4.0 (https://benchlm.ai/benchmarks/terminal-bench-4): no new data seen.
- DeepSWE v1.1 leaderboard exists (https://codingfleet.com/blog/deepswe-v11-leaderboard-2026/); scores not retrieved.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-04
**Part 1**: no change. pi-catalog 18.6.1: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- SWE-bench Pro (https://benchlm.ai/benchmarks/swe-bench-pro): unchanged — Opus 5.5 89.9%, Sonnet 5.5 81.3%, Fable 5.1 81.2%, Mythos 5 80.3%; Sakana Fugu-Ultra 73.7% (not in omp). benchlm notes ~30% of public tasks reportedly broken.
- Terminal-Bench 4.0 (https://benchlm.ai/benchmarks/terminal-bench-4, snapshot 2026-10-02): GPT-6 Astra 58.18% (max) narrowly ahead of Fable 5.1 57.88%; effectively tied.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-07
**Part 1**: no change. pi-catalog 18.8.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- SWE-bench Pro (https://benchlm.ai/benchmarks/swe-bench-pro): unchanged — Opus 5.5 89.9%, Sonnet 5.5 81.3%, Fable 5.1 81.2%, Mythos 5 80.3%; Sakana Fugu-Ultra 73.7% (not in omp).
- Terminal-Bench 4.0 (https://benchlm.ai/benchmarks/terminal-bench-4, snapshot 2026-10-06): Opus 5.5 64.85%, Sonnet 5.5 61.82% now lead; GPT-6 Astra / GPT-6.1 Sol 58.18%; Fable 5.1 57.88%. Changed vs 10-04 snapshot (where Astra led) — new Opus/Sonnet entries.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-08
**Part 1**: no change. pi-catalog 18.8.5: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- SWE-bench Pro (https://benchlm.ai/benchmarks/swe-bench-pro, snapshot 2026-10-08): unchanged — Opus 5.5 89.9%, Sonnet 5.5 81.3%, Fable 5.1 81.2%, Mythos 5 80.3%, Sakana Fugu-Ultra 73.7% (not in omp), Qwen3.8 Max 67.7%, Tencent Hy4 preview 65.7%.
- Terminal-Bench 4.0 (https://benchlm.ai/benchmarks/terminal-bench-4, snapshot 2026-10-07): unchanged vs 10-07 — Opus 5.5 64.85%, Sonnet 5.5 61.82%, GPT-6 Astra / GPT-6.1 Sol 58.18%, Fable 5.1 57.88%.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-10
**Part 1**: no change. pi-catalog 18.8.8: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- Search found no new October data. Latest DeepSWE v1.1 snapshot (https://codingfleet.com/blog/deepswe-v11-leaderboard-2026/, updated 2026-07-25): Opus 5 74.0%, GPT-5.6 Sol 72.7%, Fable 5 69.7%, Kimi K3 68.5%; older than the benchlm figures below.
- SWE-bench Pro / Terminal-Bench 4.0 (benchlm, last recorded 2026-10-08): unchanged — Opus 5.5 89.9% / 64.85%, Sonnet 5.5 81.3% / 61.82%.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-11
**Part 1**: no change. pi-catalog 18.9.1: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl (haiku-5-5 and mythos-5-1 exist but no role uses those families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No October model releases or re-scores found. Terminal-Bench 4.0 mirrors disagree by evaluator: Vals snapshot 2026-09-27 (https://benchlm.ai/benchmarks/vals-terminal-bench-4) Opus 5.5 61.62%, GPT-6 Astra 57.07%, Sonnet 5.5 53.03%; LLM Stats (https://llm-stats.com/benchmarks/terminal-bench-4.0) GPT-6 Astra 57.7%, Fable 5.1 55.8%. Not comparable across evaluators.
- SWE-bench Pro: no new data (last recorded 2026-10-08: Opus 5.5 89.9%).
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-12
**Part 1**: no change. pi-catalog 18.10.2: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl (haiku-5-5 and mythos-5-1 exist but no role uses those families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Latest recorded benchlm figures unchanged: SWE-bench Pro Opus 5.5 89.9% / Sonnet 5.5 81.3% (https://benchlm.ai/benchmarks/swe-bench-pro); Terminal-Bench 4.0 Opus 5.5 64.85% / Sonnet 5.5 61.82% (https://benchlm.ai/benchmarks/terminal-bench-4). Third-party blogs disagree on leaders (vendor-run vs Scale standardized), so no cross-source comparison.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-14
**Part 1**: no change. pi-catalog 18.10.4: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl (haiku-5-5 and mythos-5-1 exist but no role uses those families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Terminal-Bench 4.0 mirrors still disagree by evaluator/harness (Vals 2026-09-27 https://benchlm.ai/benchmarks/vals-terminal-bench-4: Opus 5.5 61.62%, GPT-6 Astra 57.07%; LLM Stats https://llm-stats.com/benchmarks/terminal-bench-4.0: GPT-6 Astra 57.7%, Fable 5.1 55.8%); not comparable across sources.
- SWE-bench Pro: no new data (last recorded 2026-10-08: Opus 5.5 89.9%).
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-15
**Part 1**: no change. pi-catalog 18.11.1: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases found. Blog figures unchanged: Terminal-Bench 4.0 (tbench.ai board, checked 2026-10-06) Opus 5.5 64.8%, Sonnet 5.5 61.8%, two GPT-6 variants 58.2% (https://codingfleet.com/blog/tag/Claude%20Sonnet%205.5/); SWE-bench Pro (provider-reported) Opus 5.5 89.9%, Sonnet 5.5 81.3% (https://codingfleet.com/blog/swe-bench-pro-leaderboard-2026/). Sources conflict on versions/leaders; not compared across.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-16
**Part 1**: no change. pi-catalog 18.11.2: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Unchanged: Terminal-Bench 4.0 (tbench.ai board via https://codingfleet.com/blog/tag/Claude%20Sonnet%205.5/, checked 2026-10-06) Opus 5.5 64.8%, Sonnet 5.5 61.8%; SWE-bench Pro (provider-reported, https://codingfleet.com/blog/swe-bench-pro-leaderboard-2026/) Opus 5.5 89.9%, Sonnet 5.5 81.3%. Terminal-Bench 2.1 is a different version (DeepSeek V4.1 Flash 90.6% there); not compared.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-17
**Part 1**: no change. pi-catalog 18.11.3: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Unchanged: Terminal-Bench 4.0 (tbench.ai board via https://codingfleet.com/blog/tag/Claude%20Sonnet%205.5/, checked 2026-10-06) Opus 5.5 64.8%, Sonnet 5.5 61.8%, GPT-6 Astra / GPT-6.1 Sol 58.2%; SWE-bench Pro (provider-reported, https://codingfleet.com/blog/swe-bench-pro-leaderboard-2026/) Opus 5.5 89.9%, Sonnet 5.5 81.3%. Sources still conflict on leaders (vendor-run vs standardized); not compared across.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-18
**Part 1**: no change. pi-catalog 18.12.1: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Unchanged: Terminal-Bench 4.0 (tbench.ai board via https://codingfleet.com/blog/tag/Claude%20Sonnet%205.5/, checked 2026-10-06) Opus 5.5 64.8%, Sonnet 5.5 61.8%; SWE-bench Pro (provider-reported, https://codingfleet.com/blog/swe-bench-pro-leaderboard-2026/) Opus 5.5 89.9%. Other search results cite older/different versions; not compared.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-19
**Part 1**: no change. pi-catalog 18.12.2: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Unchanged: Terminal-Bench 4.0 (tbench.ai board via https://codingfleet.com/blog/tag/Claude%20Sonnet%205.5/, checked 2026-10-06) Opus 5.5 64.8%, Sonnet 5.5 61.8%, GPT-6 Astra / GPT-6.1 Sol 58.2%; SWE-bench Pro (provider-reported, https://codingfleet.com/blog/swe-bench-pro-leaderboard-2026/) Opus 5.5 89.9%, Sonnet 5.5 81.3%. Other snapshots (Artificial Analysis Sep 10, BenchLM Aug 29) are older and differ; not compared.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-20
**Part 1**: no change. pi-catalog 18.12.3: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Unchanged: Terminal-Bench 4.0 (tbench.ai board via https://codingfleet.com/blog/tag/Claude%20Sonnet%205.5/, checked 2026-10-06) Opus 5.5 64.8%, GPT-6 Astra / GPT-6.1 Sol 58.2%; SWE-bench Pro (provider-reported, https://codingfleet.com/blog/swe-bench-pro-leaderboard-2026/) Opus 5.5 89.9%, Sonnet 5.5 81.3%. Terminal-Bench 2.1 is a different version; not compared.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-21
**Part 1**: no change. pi-catalog 18.12.5: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl (claude-haiku-5-5 and claude-mythos-5-1 exist but are not in modelRoles families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Unchanged: Terminal-Bench 4.0 (tbench.ai board via https://codingfleet.com/blog/tag/Claude%20Sonnet%205.5/) Opus 5.5 64.8%, Sonnet 5.5 61.8%, GPT-6 Astra / GPT-6.1 Sol 58.2%; SWE-bench Pro (provider-reported, https://codingfleet.com/blog/swe-bench-pro-leaderboard-2026/) Opus 5.5 89.9%, Sonnet 5.5 81.3%. Older roundups use different versions/model names; not compared.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-22
**Part 1**: no change. pi-catalog 18.12.6: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found since 2026-10-21. Latest search surfaced only older/other-version items (e.g. Cognition SWE-2 on Terminal-Bench 2.1, https://www.datalearner.com/en/ai-models/pretrained-models/swe-2; BenchLM Terminal-Bench 2 page https://www.benchlm.ai/benchmarks/terminal-bench-2); different versions from the 4.0 figures tracked above, not compared. SWE-2 is not in omp.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-23
**Part 1**: no change. pi-catalog 18.12.6: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Search surfaced only September snapshots (SWE-bench Pro leaderboard, https://www.morphllm.com/swe-benchmark; Cognition SWE-2 on Terminal-Bench 2.1, https://www.datalearner.com/en/ai-models/pretrained-models/swe-2; https://tbench.ai/news). Different versions from the Terminal-Bench 4.0 figures tracked above; not compared.
- No candidate available in omp that is clearly stronger than current modelRoles.
