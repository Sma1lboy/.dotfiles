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

## 2026-10-24
**Part 1**: no change. pi-catalog 18.12.6: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Search surfaced only Aug/Sep snapshots (SWE-bench Pro leaderboard, https://www.morphllm.com/swe-benchmark; Cognition SWE-2 on Terminal-Bench 2.1, https://www.datalearner.com/en/ai-models/pretrained-models/swe-2; https://benchlm.ai/benchmarks/terminalBench notes Terminal-Bench 4.0 is current). Different versions from the 4.0 figures tracked above; not compared.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-25
**Part 1**: no change. pi-catalog 18.12.6: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new releases or re-scores found. Unchanged: SWE-bench Pro (provider-reported, https://www.morphllm.com/swe-benchmark) Opus 5.5 89.9%, Sonnet 5.5 81.3%; Terminal-Bench 4.0 (https://codingfleet.com/blog/tag/Claude%20Sonnet%205.5/) Opus 5.5 64.8%, Sonnet 5.5 61.8%. Terminal-Bench 4.0 is scored per model+harness (https://www.tbench.ai/news/terminal-bench-4-0); one index lists Mythos 5.1 at 60.9% (unverified, https://benchlm.ai/benchmarks/terminalBench4). Terminal-Bench 2.1 items (Cognition SWE-2 92.8%, https://www.datalearner.com/en/ai-models/pretrained-models/swe-2) are a different version; not compared.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-26
**Part 1**: no change. pi-catalog 18.12.6: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- DeepSeek V4.1 Flash 1017 (minor Oct update): Terminal-Bench 4.0 31.2 → 42.3, measured via Claude Code harness, not DeepSeek's own (https://benchmarklist.com/models/deepseek-deepseek-v4.1-flash-1017/). Well below Opus 5.5 64.8% (4.0, tracked above); not in omp.
- Terminal-Bench 4.0 is scored per model+harness (https://www.datalearner.com/en/benchmarks/terminal-bench-4-0). No SWE-bench Pro changes found.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-27
**Part 1**: no change. pi-catalog 18.13.1: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). Catalog also lists haiku-5-5, mythos-5-1, gpt-6.1-terra (other families/not in roles); no newer ids in same families.

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found. Surfaced only older/other-version items (Cognition SWE-2, https://www.datalearner.com/en/ai-models/pretrained-models/swe-2; SWE-bench Pro, https://www.morphllm.com/swe-benchmark; Recursive Flint 40B reportedly 89.7% SWE-bench Pro v2 / 54.9% Terminal-Bench 2.1, unverified, version differs from tracked 4.0 figures; not compared).
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-28
**Part 1**: no change. pi-catalog 18.13.3: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found. Terminal-Bench 4.0 official leaderboard snapshot (Oct 1): GPT-6 Astra/Codex 58.18%, Fable 5.1/Claude Code 57.88%, statistically tied (https://presenc.ai/research/terminal-bench-leaderboard-2026; https://www.datalearner.com/en/benchmarks/terminal-bench-4-0). No SWE-bench Pro changes found.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-29
**Part 1**: no change. pi-catalog 18.13.3: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in models.json / kdl (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found. Terminal-Bench 4.0 (scored per model+harness) snapshots disagree: Vals run Opus 5.5 61.62% / GPT-6 Astra 57.07% / Sonnet 5.5 53.03% (https://benchlm.ai/benchmarks/vals-terminal-bench-4); AA version GPT-6 Astra 59.1% (https://artificialanalysis.ai/evaluations/terminalbench-v4-0). No SWE-bench Pro changes found. Unverified mention of Gemini 4 Argon limited rollout (https://tech-insider.org/terminal-bench-4-opus-5-5-gemini-argon-leaderboard-2026/); not in omp.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-30
**Part 1**: no change. pi-catalog 18.14.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found. Search returned only stale Terminal-Bench 4.0 snapshots (Aug/Sep): Opus 5 51.82% (https://benchlm.ai/benchmarks/terminalBench4), Mythos 5.1 60.9% (Sep 2, https://anotherwrapper.com/tools/llm-pricing/evals/terminal-bench-4-0); Snorkel leaderboard https://snorkel.ai/leaderboard/terminal-bench-4-0/. Sources disagree; no SWE-bench Pro scores found.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-10-31
**Part 1**: no change. pi-catalog 18.14.1: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found. Terminal-Bench 4.0 (Oct 1 official snapshot): GPT-6 Astra/Codex 58.18% vs Fable 5.1/Claude Code 57.88%, statistically tied (https://presenc.ai/research/terminal-bench-leaderboard-2026). Sep 2 snapshot Mythos 5.1 60.9% (https://anotherwrapper.com/tools/llm-pricing/evals/terminal-bench-4-0); sources disagree. Cognition SWE-2: 92.8 on TB 2.1 but 27.3 on TB 4.0 (https://www.datalearner.com/en/ai-models/pretrained-models/swe-2); versions not comparable. No Oct SWE-bench Pro results found.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-01
**Part 1**: no change. pi-catalog 18.15.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found. Terminal-Bench 4.0: tbench.ai board via Developers Digest (Oct 17) shows Opus 5.5 64.8% ±3.1 (https://www.developersdigest.tech/benchmarks/terminal-bench); Anthropic self-reports 66.4% (not on public board, https://presenc.ai/research/terminal-bench-leaderboard-2026). Older snapshots disagree (https://benchlm.ai/benchmarks/terminalBench4). No new SWE-bench Pro results.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-02
**Part 1**: no change. pi-catalog 18.15.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found; latest items are Sep 2026. SWE-bench Pro snapshot (Sep 8): Fable 5.1 81.2%, Fable 5/Mythos 5 80.3%, Opus 5 79.2% (https://codingfleet.com/blog/tag/coding%20benchmark/?page=3). Terminal-Bench 4.0 is current version, not comparable with 2.x/3.0 scores (https://benchlm.ai/benchmarks/terminalBench4).
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-03
**Part 1**: no change. pi-catalog 18.16.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found; newest items are Sep 2026. Terminal-Bench 4.0 snapshots still disagree by harness: Vals Opus 5.5 61.62% (https://benchlm.ai/benchmarks/vals-terminal-bench-4), AA GPT-6 Astra 59.1% (https://benchlm.ai/benchmarks/aaTerminalBench4). No new SWE-bench Pro results (https://www.datalearner.com/en/benchmarks/swe-bench-pro).
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-04
**Part 1**: no change. pi-catalog 18.16.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found; newest items are Sep 2026. Terminal-Bench 4.0 sources still disagree: AA GPT-6 Astra xhigh 59.6% / Fable 5.1 55.1% (https://artificialanalysis.ai/pt/evaluations/terminalbench-4-0), Mythos 5.1 60.9% (https://benchmarklist.com/benchmarks/terminal_bench_4/), BenchLM Opus 5 51.82% (https://benchlm.ai/benchmarks/terminalBench4). No SWE-bench Pro scores found.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-05
**Part 1**: no change. pi-catalog 18.16.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found; newest items still Sep 2026. Terminal-Bench 4.0 (66 tasks, Aug 2026) sources still disagree by harness: BenchLM Opus 5 51.82% (https://benchlm.ai/benchmarks/terminalBench4), AA GPT-6 Astra 59.1% (https://benchlm.ai/benchmarks/aaTerminalBench4), Fable 5.1 57.9% ±3.8 w/ Claude Code. Cognition SWE-2 weak on TB 4.0 (27.3) vs 92.8 on TB 2.1 – versions not comparable (https://benchmarklist.com/models/cognition-swe-2/). SWE-bench Pro has two versions, not comparable.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-06
**Part 1**: no change. pi-catalog 18.17.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases or re-scores found; newest items still Sep/Oct 2026. Terminal-Bench 4.0 (66 tasks, maintenance release) boards still disagree by harness/date: Opus 5.5 64.8% ±3.1 (https://www.developersdigest.tech/benchmarks/terminal-bench), BenchLM Opus 5 51.82% (https://benchlm.ai/benchmarks/terminalBench4). No SWE-bench Pro results from November.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-07
**Part 1**: no change. pi-catalog 18.18.0: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new vendor releases found. SWE-bench Pro (BenchLM, Nov 6): Opus 5.5 89.9% (vendor-reported), Sonnet 5.5 81.3%, Fable 5.1 81.2% (https://benchlm.ai/benchmarks/swe-bench-pro). Terminal-Bench 4.0: Vals Opus 5.5 65.15% (https://www.vals.ai/benchmarks/terminal-bench-4); AA re-runs Sonnet 5.5 63.6%, Opus 5.5 59.6%, GPT-6 Astra 59.1% (https://codingfleet.com/blog/terminal-bench-4-leaderboard-2026/). Harness-dependent; not comparable across boards.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-08
**Part 1**: no change. pi-catalog 18.18.1: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; aggregator figures, unverified against primary sources):
- No new November vendor releases found. Terminal-Bench 4.0 is a Aug 2026 maintenance release (66 tasks), Vals says methodology unchanged from 2.1 but boards are not comparable across versions (https://vals.ai/benchmarks/terminal-bench-4, https://snorkel.ai/leaderboard/terminal-bench/). Unverified: Qwen3.8-Max SWE-bench Pro 67.7 / TB 2.1 86.6 (https://tech-insider.org/best-ai-model-for-coding-2026/); GPT-6 Astra TB 4.0 57.7% (https://benchmarklist.com/models/openai-gpt-6-astra/).
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-09
**Part 1**: no change. pi-catalog 18.18.3: all roles already newest in family (fable-5-1, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No newer ids in catalog (gpt-6.1-terra, haiku-5-5, mythos-5-1 exist but are other families).

**Part 2** (report only; single tracker, self-reported, unverified):
- New: Moonshot Kimi K3.1 Pro (open weights, Nov 5), self-reported Terminal-Bench 4.0 65.7% (https://techpp.com/roundup/ai-model-launch-timeline/). No SWE-bench Pro score found. TB 4.0 (66 tasks) not comparable with 2.1 (https://vals.ai/benchmarks/terminal-bench-4). Not in omp catalog, so no suggestion.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-10
**Part 1**: CHANGED. pi-catalog 18.18.6 adds `claude-fable-5-2` (anthropic provider, same family): `slow` and `advisor` anthropic/claude-fable-5-1 → anthropic/claude-fable-5-2. Others already newest in family (opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). Web search found no announcement coverage of Fable 5.2 (only catalog + docs links in pi-catalog), so release is catalog-confirmed only.

**Part 2** (report only; aggregator figures, unverified):
- No new Fable 5.2 benchmark scores found. Latest Fable 5.1 figures: SWE-bench Pro 81.2% (https://benchlm.ai/models/claude-fable-5-1), Terminal-Bench 4.0 55.8% (https://datasciencedojo.com/blog/claude-fable-5-1-performance-and-safety/); harness-dependent, not comparable across versions/boards.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-11
**Part 1**: no change. pi-catalog 18.18.8: all roles already newest in family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). New id `claude-mythos-5-2` in catalog (mythos family, not used by any role); gpt-6.1-terra, haiku-5-5 still other families.

**Part 2** (report only; aggregator/self-reported figures, unverified):
- No public benchmark scores yet for Mythos 5.2 or Fable 5.2; BenchLM still lists Mythos 5 at SWE-bench Pro 80.3% / Terminal-Bench 2.0 88% (https://benchlm.ai/models/claude-mythos-5).
- November releases per roundup: SWE-2 Flash, GPT-6 Cyber, Ripple-65B Preview (TB 2.1 80.5% self-reported), Hy4, Kimi K3.1 Pro (TB 4.0 65.7% self-reported vs Opus 5.5 66.4 on same board) (https://thursdai.news/releases/2026-11). TB 4.0 vs 2.1 not comparable. None clearly stronger and in omp catalog.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-12
**Part 1**: no change. pi-catalog 18.19.0: all roles already newest in family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No new ids vs 18.18.8 (mythos-5-2, gpt-6.1-terra, haiku-5-5 are other families). Web: GPT-6.1 Astra reported shelved, no public id (https://aiidelist.com/blog/gpt-6-1-astra-update); no GPT-6.1 Luna.

**Part 2** (report only; third-party/vendor figures, unverified):
- Fable 5.2 / Mythos 5.2 officially announced Nov 9 (https://www.anthropic.com/news/claude-fable-and-mythos-5-2). Terminal-Bench-Science 0.1: Fable 5.2 74.6%, Mythos 5.2 75.3% (vendor). Terminal-Bench 4.0: Fable 5.2 ~60%, tied with Opus 5.5; Sonnet 5.5 ~4 pts higher (https://singularitymoments.com/content/fable-52-delivers-huge-math-gains-but-stumbles-on-daily-dev-work/). FrontierCode 2.0: Fable 5.2 49.1% vs Fable 5.1 32.4% (https://af.net/realtime/anthropic-unveils-claude-fable-and-mythos-5-2-with-49-1-coding-score/). No SWE-bench Pro score for 5.2 yet.
- No other new November releases beyond those already logged (Kimi K3.1 Pro TB 4.0 65.7% self-reported; https://thursdai.news/releases/2026-11).
- No candidate available in omp that is clearly stronger than current modelRoles. Note: on TB 4.0, Fable 5.2 (slow/advisor) does not beat Opus 5.5 / Sonnet 5.5 — no action, observation only.
