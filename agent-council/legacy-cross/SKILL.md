---
name: cross
description: >
  Legacy alias for agent-council. 仅当用户明确使用旧入口 /cross、/cross review、/cross work、/cross argue、/cross qa、
  cross-review、cross-work、cross-argue、cross-qa 时触发。自然语言里的多 agent、sub-agent、交叉评估、互相挑战、
  QA/eval/regression 等需求应直接触发 agent-council，而不是先触发本 alias。
---

# Cross Legacy Alias

`cross` 已迁移为 `agent-council` 的兼容入口。本文件只保留旧命令兼容，不承接自然语言主入口。

## 兼容目标

旧 `cross` 的核心价值不是名字，而是这条真实链路:

```text
Claude Code 主会话 -> CodeFuse actor (`cfuse --bare -p`)
```

因此 `/cross review`、`/cross argue`、`/cross qa` 转交 `agent-council` 后，必须优先尝试 `codefuse` actor。若失败，必须明确告诉用户“CodeFuse 外部 actor 未跑通，本次已降级”，不能假装完成了跨模型评审。

## 触发边界

只在用户明确写出以下旧入口时使用本 skill:

- `/cross`
- `/cross review`
- `/cross work`
- `/cross argue`
- `/cross qa`
- `cross-review`
- `cross-work`
- `cross-argue`
- `cross-qa`

如果用户只是自然语言表达“找几个 agent/sub-agent 讨论”“多模型协作”“交叉评估”“互相挑战”“做 QA/eval/regression”，必须直接使用 `agent-council`，不要先使用 `cross`。

## 必须执行

1. 读取同入口下的 `agent-council/SKILL.md`；若找不到，再读取 `/Users/guannan/.codex/skills/agent-council/SKILL.md`。
2. 读取 `agent-council/references/actors.md`，保留 legacy cross 的 CodeFuse actor path。
3. 按 `agent-council` 的流程路由任务。
4. 将旧入口映射为新入口:

| legacy | canonical |
|---|---|
| `/cross` | `agent-council` natural-language routing, prefer `codefuse` for external review |
| `/cross review` / `cross-review` | `agent-council review`, prefer `codefuse` |
| `/cross work` / `cross-work` | `agent-council implement`, external actor optional by task split |
| `/cross argue` / `cross-argue` | `agent-council debate`, prefer `codefuse` as one side |
| `/cross qa` / `cross-qa` | `agent-council qa`, prefer `codefuse` evaluator |

## 禁止执行

- 不要执行旧版 `.cross/jobs` 协议。
- 不要写 `.cross/jobs`。
- 不要使用旧 cross actor 注册表作为 source of truth；source of truth 是 `agent-council/config/actors.tsv`。
- 不要因为自然语言里的“多 agent / 交叉评估 / 互相挑战 / QA”触发本 alias。

## 兼容说明

- 新留痕路径是 `.agent-council/jobs/...`，不是 `.cross/jobs/...`。
- 复杂或需审计任务先创建 trace job。
- 复杂任务默认进入 QA gate。
- 最终报告必须说明是否真的调用 CodeFuse/Claude/Codex CLI、是否跨模型/跨 session、是否降级、QA 是否通过。
