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

## 2026-11-13
**Part 1**: no change. pi-catalog 18.20.0 (models.json format changed: `providers` is now a compact list, ids at `entry[2][i][0]`): all roles already newest in family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No new anthropic/openai-codex ids vs 18.19.0 (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families).

**Part 2** (report only; aggregator/self-reported figures, unverified):
- Terminal-Bench 4.1 released Nov 9 (verifier fixes; 4.0 trials re-graded, ~1% of rewards changed, scores within prior CIs; 23 configs, top 65.8%) (https://snorkel.ai/?p=20114). Reported 4.1 board: Opus 5.5 65.8%, Sonnet 5.5 63.9%, GPT-6.1 Sol 60.9% (https://local-ai-zone.github.io/blog/November_2026_AI_Model_Updates.html). Do not mix with 4.0 numbers.
- New: Google Gemini 4 family (argon/carbon/hydrogen; hydrogen launched Nov 12, now in catalog under google/vertex/openrouter). AA Terminal-Bench 4.0: Gemini 4 Carbon (High) 65.2%, Kimi K3.1 Pro 67.2% (https://artificialanalysis.ai/evaluations/terminalbench-v4-0); Argon TB 4.0 ~57% (https://computingforgeeks.com/gemini-4-argon-released-features-benchmarks/). No Hydrogen scores found.
- New: Alibaba Qwen 4 (API Nov 11, open weights promised by Dec 20), self-reported TB 4.0 64.1% (https://local-ai-zone.github.io/blog/November_2026_AI_Model_Updates.html); not in omp catalog.
- Fable 5.2: BenchLM shows "93" for SWE-bench Pro but appears to be a percentile, not a score (https://benchlm.ai/models/claude-fable-5-2). SWE-bench Pro leader still Opus 5.5 89.9% (https://benchlm.ai/benchmarks/swe-bench-pro).
- Candidates: Kimi K3.1 Pro (AA TB 4.0 67.2%) and Gemini 4 Carbon (65.2%) are near/slightly above Opus 5.5 on one board, but within harness variance and no SWE-bench Pro scores, and `enabledProviders` is claude-only — not clearly stronger. No suggestion.

## 2026-11-14
**Part 1**: no change. pi-catalog 18.20.0 (same as yesterday): all roles already newest in family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No new anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families). No new OpenAI/Anthropic announcements found.

**Part 2** (report only; aggregator/vendor figures, unverified):
- SWE-bench Pro: Fable 5.2 now shown as 93% (fixes yesterday's "percentile?" doubt), citing Anthropic's Nov 9 system card; Opus 5.5 89.9%, Sonnet 5.5 81.3% (https://benchlm.ai/benchmarks/swe-bench-pro, https://llmlearner.com/rankings/swe-bench-pro). Scale's standardized public set is a different setup with a different leader: Muse Spark 1.1 61.5% (https://www.morphllm.com/swe-bench-pro). Don't compare across the two.
- Gemini 4 Hydrogen (GA Nov 12): Terminal-Bench 4.1 57.0% (Google mini-swe-agent harness, 5 attempts; flagged as not board-comparable) (https://www.benchlm.ai/benchmarks/terminal-bench-2). No SWE-bench score.
- Other Nov 13 releases (HeyGen Decision 1, Hark Handoff 2) are not coding models (https://af.net/realtime/ai-model-releases-november-2026/).
- No candidate available in omp that is clearly stronger than current modelRoles. Current Fable 5.2 (slow/advisor) leads vendor-reported SWE-bench Pro.

## 2026-11-15
**Part 1**: no change. pi-catalog 18.20.2: all roles already newest in family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `gpt-daybreak-{blue,red}-latest` are gated cyber-program aliases, skipped per rules — https://openai.com/index/expanding-daybreak-as-the-cyber-defense-window-narrows/).

**Part 2** (report only; aggregator figures, unverified):
- No new coding-model releases found for Nov 14–15 (latest still Gemini 4 Hydrogen Nov 12, HeyGen Decision 1 Nov 13; https://benchlm.ai/models/swe-2).
- Terminal-Bench 4.0 (Vals, as of Nov 11, mini-swe-agent): Fable 5.2 and Opus 5.5 tied at 65.15%, Sonnet 5.5 64.14% (https://www.vals.ai/benchmarks/terminal-bench-4). Corrects the earlier third-party "~60%" Fable 5.2 figure on that board.
- Terminal-Bench 2.1 (BenchLM, vendor-reported): SWE-2 92.8%, GPT-5.6 Sol 91.9% (https://benchlm.ai/benchmarks/terminalbench21). Different version, not comparable with 4.x.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-16
**Part 1**: no change. pi-catalog 18.21.0: all roles already newest in family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `gpt-daybreak-*-latest` skipped). No new OpenAI/Anthropic announcements found.

**Part 2** (report only; vendor/third-party figures, unverified):
- New (Nov 15, single low-quality source): Agnes AI "Agnes 2.5 Pro Theta" open weights (~188B, Apache 2.0), model card claims SWE-bench Pro 64.1 (https://newstodayworld.org/breaking-news/2026/11/16/prince-mario-max-schaumburg-lippe-agnes-ai-posts-188b-open-model-on-hugging-face/). Not in omp catalog.
- Gemini 4 Hydrogen: independent Terminal-Bench 4.0 54% vs Google's TB 4.1 57% (different versions/harnesses) (https://the-decoder.com/googles-gemini-4-hydrogen-outscores-the-bigger-argon-just-four-weeks-after-its-launch/).
- DeepSeek V4.1 Flash (1017 update): DeepSWE v1.1 77.0 (mini-SWE-v2), Terminal-Bench 4.0 42.3 (Claude Code harness) (https://www.morphllm.com/deepseek-v4-1-flash). Baidu ERNIE 5.5 Flash Preview (Nov 11): TB 4.0 46.5 (https://www.orcarouter.ai/blog/ernie-5-5-flash-preview-launch-post-benchmarks).
- No candidate available in omp that is clearly stronger than current modelRoles (Vals TB 4.0: Fable 5.2 / Opus 5.5 65.15%, Sonnet 5.5 64.14%, unchanged).

## 2026-11-17
**Part 1**: no change. pi-catalog 18.22.0: all roles already newest in family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6-astra, gpt-6.1-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `-wm` skipped). No new OpenAI/Anthropic announcements found.

**Part 2** (report only; vendor/aggregator figures, unverified):
- New (Nov 17): Alibaba Qwen4-Max. Alibaba reports ~62% lower avg task cost on its internal Work360 eval. Coding results are mixed: roughly level on one coding-agent benchmark but behind elsewhere, and an independent aggregate ranks it below the top US models and Kimi K3.1 Pro (https://venturebeat.com/technology/alibabas-qwen4-max-cuts-ai-task-costs-but-benchmarks-show-an-uneven-challenge-to-frontier-rivals). BenchLM shows its TB 2.1 / coding scores as "coming soon" (https://benchlm.ai/md/compare/qwen4-max-vs-swe-2.md). Not in omp catalog.
- LLM Stats coding index (Nov 2026): Fable 5.2 #1 (49.8), ahead of Opus 5.5 and Sonnet 5.5 (https://llm-stats.com/leaderboards/best-ai-for-coding).
- OpenCode usage (7d to Nov 17): DeepSeek V4.1 Flash leads usage (https://opencode.ai/data/). This is a usage ranking, not a benchmark.
- No candidate available in omp that is clearly stronger than current modelRoles.

## 2026-11-18
**Part 1**: bumped 2 roles. pi-catalog 18.22.2 adds `gpt-6.2-astra` and `gpt-6.2-sol` (in openai-codex models.json and .kdl). OpenAI launched them Nov 17 (https://the-decoder.com/openai-launches-gpt-6-2-astra-and-sol-with-lower-api-prices-and-some-benchmark-gains/).
- plan: `gpt-6-astra` → `gpt-6.2-astra`
- smol: `gpt-6.1-sol` → `gpt-6.2-sol`
- Unchanged: fable-5-2, opus-5-5, sonnet-5-5, gpt-6-luna (no newer luna; mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `-wm` skipped).

**Part 2** (report only; vendor/third-party figures, unverified):
- GPT-6.2 Astra: Terminal-Bench-Science 0.1 is 77.1% per OpenAI, +9 pts over GPT-6 Astra at <1/3 cost per task. GPT-6.2 Sol scores 68.0% on the same benchmark. API price $8/$40 per MTok. Vals Terminal-Bench 4 reportedly ranks Astra #5 and Sol #7, below Opus 5.5 / Fable 5.2 (https://the-decoder.com/openai-launches-gpt-6-2-astra-and-sol-with-lower-api-prices-and-some-benchmark-gains/, https://www.vals.ai/benchmarks/terminal-bench-4). TB-Science 0.1 is not comparable with TB 4.x.
- Reception: VentureBeat reports negative power-user reception ("essentially unusable"). Artificial Analysis ties Sol's coding-agent decline mostly to a 14-pt drop on SWE-Atlas-QnA-AA (https://venturebeat.com/technology/essentially-unusable-openai-launches-gpt-6-2-astra-and-sol-to-negative-reception-from-ai-power-users). Watch smol/plan quality after this bump.
- No official SWE-bench score for GPT-6.2. The only figure (Verified 79.4%) comes from a "leak" blog and is unreliable (https://apivale.com/blog/gpt-6-2-astra-leaks-benchmarks/).
- No other new coding-model releases found for Nov 17–18. No candidate available in omp is clearly stronger than current modelRoles.

## 2026-11-19
**Part 1**: no change. pi-catalog 19.0.0 (new major version; models.json `openai-codex` list no longer includes `gpt-6.2-*`, but `openai-codex.kdl` still lists `gpt-6.2-astra` / `gpt-6.2-sol`, so the union is the same). All roles are already the newest in their family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6.2-astra, gpt-6.2-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `-wm` / `gpt-daybreak-*-latest` skipped). No new OpenAI/Anthropic announcements found.

**Part 2** (report only; vendor/secondary figures, unverified):
- New (Nov 18): Google Gemini 4 Neon, which sits between Carbon and Hydrogen. Pricing is $3/$15 per MTok. AA Intelligence Index 61 vs Carbon 60. Reported AA coding index is 58.6 or 59 (sources differ). Google claims coding is at Opus 5.5 level (https://9to5google.com/2026/11/18/gemini-4-neon-announcement/, https://oodaloop.com/briefs/technology/google-launches-gemini-4-neon-with-claude-opus-5-5-level-coding-performance-at-25-lower-api-token-prices/). No SWE-bench / TB 4.x score found. Not in pi-catalog 19.0.0.
- New (Nov 17): Microsoft MAI Code 2 / MAI Code 2 Flash. Microsoft uses DeepSWE 1.1 instead of SWE-bench. Average pass rate 63.2% (Flash 61.0%) across DeepSWE 1.1, TB 2.1, SWE Atlas and FrontierCode v1.1. On Terminal-Bench 2.1, MAI Code 2 scores 84.6% vs GPT-6.1 Sol 85.0% and Opus 5.5 78.7% (Microsoft chart). On SWE Atlas it scores 43.1%, 14.4 pts below Opus 5.5 (https://thenewstack.io/microsoft-mai-code-2/, https://www.unite.ai/?p=522546). TB 2.1 is not comparable with 4.x. Not in pi-catalog.
- Vals index (Nov 18) reports a model in the Sol family at #1 on SWE-bench Verified (96.20%) and TB 2.1 (85.77%), per search summary, unverified (https://www.vals.ai/home).
- No candidate available in omp is clearly stronger than current modelRoles.

## 2026-11-20
**Part 1**: no change. pi-catalog 19.0.1 changes the models.json format to a compact `providers` list, so ids are now read from there plus the `.kdl` files. All roles are already the newest in their family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6.2-astra, gpt-6.2-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `-wm` / `gpt-daybreak-*-latest` skipped). No new OpenAI/Anthropic announcements found.

**Part 2** (report only; vendor/secondary figures, unverified):
- Gemini 4 Neon (Nov 18) is now in pi-catalog 19.0.1 (`gemini-4-neon`). Google's table (via https://officechai.com/ai/gemini-4-neon-benchmarks/) shows:
  - Terminal-Bench 4.1 (cheating-adjusted): Neon 65.2% vs Opus 5.5 65.8% vs GPT-6.2 Sol 61.5%.
  - FrontierCode 2.0: Neon 46.2% / Opus 5.5 47.3% / Sol 43.8%.
  - AutomationBench (version not given): Neon 56.3% vs Opus 5.5 42.5% (Anthropic's own figure is 40.0%) vs Sol 41.3%.
  - "SWE-sweep" (a new benchmark, not SWE-bench): Neon 39.0% (provider harness) / 12.8% (mini-SWE).
  - AA Intelligence Index: Neon 61 vs Opus 5.5 (Max) 59 (https://artificialanalysis.ai/models/comparisons/gemini-4-neon-vs-claude-opus-5-5).
  - No SWE-bench Verified/Pro or DeepSWE score.
- Cloudflare Clairic / Clairic-flash (Nov 18) has no benchmark scores (https://af.net/realtime/ai-model-releases-november-2026/). No other coding-model releases found for Nov 19–20.
- Candidate: Gemini 4 Neon is clearly stronger only on AutomationBench, roughly level with Opus 5.5 on coding (TB 4.1, FrontierCode). `enabledProviders` is claude-only. No role change suggested. If browser/automation agent work matters, try it ad hoc.

## 2026-11-21
**Part 1**: no change. pi-catalog 19.1.0: all roles are already the newest in their family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6.2-astra, gpt-6.2-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `gpt-6-luna-decisions` is a variant, not a newer version; `-fast`/effort suffixes skipped). No new OpenAI/Anthropic announcements found.

**Part 2** (report only; aggregator/blog figures, unverified):
- No new coding-model releases found for Nov 20–21. The most recent are still Gemini 4 Neon and MAI Code 2 / Flash (Nov 18) (https://af.net/realtime/ai-model-releases-november-2026/, https://local-ai-zone.github.io/blog/November_2026_AI_Model_Updates.html).
- Kimi K3.1 Pro: one blog reports Terminal-Bench 4.0 at 65.7%, vs GPT-6 Astra 58.2% (https://iotdigitaltwinplm.com/ai-coding-model-leaderboard-november-2026-swe-bench-verified-terminal-bench-aider-polyglot-scores-an/). Single source, harness not stated. Not directly comparable with Vals TB 4.0 (Fable 5.2 / Opus 5.5 65.15%).
- Terminal-Bench 4.1 was released Nov 9. The same leaderboard says SWE-bench Verified and Aider Polyglot have stopped taking new frontier submissions (same source as above).
- DeepSeek V4.1 Flash DeepSWE v1.1 is 74.2 (own harness, https://www.morphllm.com/best-open-source-llm) vs 77.0 (mini-SWE-v2, 11-16 entry). The two figures use different harnesses.
- No candidate available in omp is clearly stronger than current modelRoles.

## 2026-11-22
**Part 1**: no change. pi-catalog is still 19.1.0, the same as yesterday. All roles are already the newest in their family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6.2-astra, gpt-6.2-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `-wm` / `-pro` / `gpt-daybreak-*-latest` skipped). No new OpenAI/Anthropic announcements found.

**Part 2** (report only; vendor/aggregator figures, unverified):
- New (Nov 20): RadixArk DaisyRose-27B. It is an Apache 2.0 open-weight agentic coding model built on Qwen3.8-27B and trained with RL only. Terminal-Bench 4.1 is 12.0, reported as more than doubling the base model (https://www.marktechpost.com/2026/11/20/radixark-daisyrose-27b-agentic-model/). Small model, far below the frontier. Not in pi-catalog.
- New (Nov 20, lab-reported, aggregator summary): Thinking Machines Inkling 2 Mini. DeepSWE v1.1 is 48.2% and SWE-bench Verified is 79.2% (bash only) (https://fourweekmba.com/ai-model-benchmarks/). pi-catalog only has `inkling-2-small`, not Mini.
- AA Coding Agent Index: sources disagree on the leader. One says Gemini 4 Neon is #1 at 59 (as of Nov 20). Another snapshot (Nov 19) says Claude Code + Fable 5.2 (Xhigh) leads at 58.5% (https://benchlm.ai/benchmarks/aacodingagents, https://geotoolbox.ai/blog/best-ai-model). Treat these as roughly level.
- Official Terminal-Bench re-grade (Nov 9; TB 4.1 runs 5 trials per task): Opus 5.5 + Claude Code 65.8%, Sonnet 5.5 63.9% (https://www.benchleader.com/benchmarks/coding). Matches the Google table in the 11-20 entry.
- No candidate available in omp is clearly stronger than current modelRoles.

## 2026-11-23
**Part 1**: no change. pi-catalog 19.1.1: all roles are already the newest in their family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6.2-astra, gpt-6.2-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `-wm` / `-fast` / effort suffixes / `gpt-daybreak-*-latest` skipped). No new OpenAI/Anthropic announcements found (no "GPT-6.3" or newer Claude).

**Part 2** (report only; vendor/aggregator figures, unverified):
- No new coding-model releases found for Nov 21–23. One tracker lists "Kimi K3.1 Pro Prime" (Nov 20), but no other source confirms the name; it may be a mix-up with K3.1 Pro / Highspeed (https://llmgateway.io/timeline).
- Terminal-Bench 4.1: GitHub Copilot Fusion Max (multi-model orchestration of Anthropic + OpenAI models, not a single model) at 71.2%, +5.4 pts over Claude Code + Opus 5.5 / Fable 5.2 (65.8%); Codex + GPT-6.2 Sol 61.5% (https://github.blog/changelog/2026-11-17-github-copilot-fusion-updates-more-availability-benchmarks-and-models, https://www.morphllm.com/best-ai-coding-agents-2026). It is a Copilot product mode, not available in omp. A Snorkel TB 4.1 page shows a very different scale (top ~20%), so scores across leaderboards are not comparable (https://snorkel.ai/leaderboard/terminal-bench/).
- DeepSWE 1.1 (llm-stats, updated Nov 22, 59 models): Meta Muse Wonder Full leads at 0.790; Muse Wonder 0.788 (self-reported, mini-SWE-agent harness), reported ahead of Opus 5.5 (https://llm-stats.com/benchmarks/deepswe-1.1, https://benchmarklist.com/models/meta-muse-wonder/). Muse Wonder (Oct 12) appears in pi-catalog compat rules (`muse-wonder`); Full is Muse Code-only. The older llm-stats DeepSWE (v1) page has Kimi K3.1 Pro on top at 0.755 (https://llm-stats.com/benchmarks/deepswe), which is a different version.
- No candidate available in omp is clearly stronger than current modelRoles. Muse Wonder is only marginally ahead on DeepSWE 1.1 by self-report; `enabledProviders` is claude-only, so no role change suggested.

## 2026-11-24
**Part 1**: no change. pi-catalog is still 19.1.1, the same as yesterday. All roles are already the newest in their family (fable-5-2, opus-5-5, sonnet-5-5, gpt-6.2-astra, gpt-6.2-sol, gpt-6-luna). No new same-family anthropic/openai-codex ids (no `gpt-6.3-*` or newer claude ids; mythos-5-2, haiku-5-5, gpt-6.1-terra are other families; `-wm` / `-pro` / `-fast` / effort suffixes skipped). No new OpenAI/Anthropic announcements found.

**Part 2** (report only; aggregator figures, unverified):
- One tracker lists Z.AI GLM-5.4 as released Nov 23 (https://benchlm.ai/benchmarks/terminal-bench). This is unconfirmed: a CometAPI page calls "GLM-5.4" a community label for a rumored successor with no spec sheet (https://www.cometapi.com/id/glm-5-4-coming-soon/). No benchmark scores. Not in pi-catalog.
- Snorkel's Terminal-Bench 4.1 board ranks Copilot Fusion (max) at 71.2% ±2.9, then Fable 5.2 at 65.8%, GPT-6.2 Astra 62.1%, GPT-6.2 Sol 61.5% and Gemini 4 Neon 61.2% (https://snorkel.ai/leaderboard/terminal-bench/). Neon is below Google's own 65.2% figure on the same version.
- No other new coding-model releases or DeepSWE / SWE-bench re-scores found for Nov 23–24.
- No candidate available in omp is clearly stronger than current modelRoles.
