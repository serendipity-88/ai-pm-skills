# Agent Council Restart Eval - 2026-07-01

## User Context

User restarted Claude Code via CodeFuse. The visible environment appears to expose both `cfuse` and `claude`, but CodeFuse's help output is Claude-Code-like and may wrap an embedded Claude Code runtime with another model/provider.

## What Was Tested

| Path | Command | Result | Verdict |
|---|---|---|---|
| Codex -> CodeFuse actor | `cfuse --bare -p` | returned `CFUSE_OK` | PASS |
| Codex -> CodeFuse via agent-council runner | `run_actor.sh ... codefuse` | returned structured reviewer output | PASS |
| Codex -> Claude Code actor | `claude -p` via healthcheck | `Not logged in · Please run /login` | FAIL |
| Codex -> Claude direct manual call | `claude -p` | hung in manual chained probe until interrupted | FAIL / unavailable |

## CodeFuse Actor Evidence

```text
1. ACTOR_OK: codefuse
2. VERDICT: PASS
3. RISK: 外部 actor 调用结果写入 trace 是合理设计，可提升可观测性与审计能力，但需注意对敏感输出做脱敏处理，避免凭据或 PII 泄露到 trace 存储中。
```

## Claude Code Actor Evidence

```text
unavailable
Not logged in · Please run /login
```

## QA Verdict

PASS for Codex -> CodeFuse external actor collaboration.

FAIL for Codex -> standalone Claude Code actor collaboration in the current shell environment. The blocker is authentication/session availability of `/Users/guannan/.npm-global/bin/claude`, not the agent-council routing logic.

## Product Interpretation

In Codex, `agent-council` can currently run multi-agent collaboration with CodeFuse as a real external actor. If the user says CodeFuse embeds Claude Code/DeepSeek V4, this path should be described as `Codex -> CodeFuse actor`, with model family recorded as `unknown` unless CodeFuse provides reliable metadata.

Do not claim `Codex -> Claude Code` is working until `claude -p` healthcheck returns healthy.
