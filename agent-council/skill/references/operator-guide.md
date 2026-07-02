# Operator Guide

Use this when running a full council rather than a quick answer.

## Steps

1. Clarify goal, target artifact, non-goals, and desired output.
2. Decide whether council is needed. If the user asks for quick advice, skip council.
3. Pick roles from user-provided roles first; add QA/evaluator when required.
4. Detect orchestrator if possible: Codex / Claude Code / CodeFuse / unknown.
5. Select actors from `config/actors.tsv`; healthcheck before use.
6. Preserve legacy cross value: when running inside Claude Code, review/debate/QA should try `codefuse` first.
7. Create a trace job for complex or auditable tasks.
8. Dispatch round 1 prompts through `scripts/run_actor.sh` or the platform subagent/thread tool.
9. Clean outputs.
10. Optional challenge round: actors respond to each other.
11. Synthesize findings into a user-readable result.
12. Run QA gate when required.
13. Write `result.md`.

## Actor Truthfulness

The final answer must distinguish these cases:

- `cross-model`: at least one external actor from a different model family actually returned usable output.
- `cross-cli`: at least one external CLI actor actually returned usable output.
- `cross-session`: a separate session/thread returned usable output, but model family may be the same.
- `same-model-roleplay`: only same-model roles/subagents were used.
- `failed-external-actor`: external actor was attempted but unavailable.

Never describe a same-model subagent review as Claude Code / CodeFuse review.

## Stop Conditions

- Enough evidence to recommend a path.
- Actors repeat the same arguments.
- QA returns FAIL with accepted blockers.
- Human decision is required.

## Failure Handling

- Actor unavailable: record degradation and choose fallback.
- Empty output: retry once, then mark unavailable.
- Timeout: kill actor, record timeout, do not treat partial output as clean unless reviewed.
- No write permission: continue without trace and disclose.
