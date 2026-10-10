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
