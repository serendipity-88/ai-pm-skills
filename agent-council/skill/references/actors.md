# Actors

## Non-Negotiable Compatibility

`agent-council` replaces `cross`, but it must not regress the old useful path:

```text
Claude Code orchestrator -> CodeFuse actor (`cfuse --bare -p`)
```

When the orchestrator is Claude Code and the task is review/debate/QA, `codefuse` is the preferred first actor unless the user explicitly asks for another actor. This is the known practical value of the old `cross` skill: get a real second opinion from another CLI/model family instead of simulating multiple roles in the same model.

If this healthcheck fails, the result must say the strong cross-CLI path failed and name the fallback. Do not claim cross-model review happened.

## Actor Backend

| backend | 示例 | 价值 |
|---|---|---|
| `cli_actor` | CodeFuse、Claude Code、Codex CLI | 跨 CLI、跨模型 |
| `codex_subagent` | 当前 Codex 内置 subagent | 快速并行、上下文隔离；不是强异构 |
| `codex_thread` | 独立 Codex thread/session | 跨 session；不一定异构 |
| `claude_session` | Claude Code 独立 session | 同 CLI 跨 session |
| `cfuse_session` | CodeFuse 独立 session | 同 CLI 跨 session |

## Actor Matrix

每次任务必须记录:

```md
| Actor | Backend | CLI/Session | Model Family | Status | Used For |
|---|---|---|---|---|---|
```

`Model Family` 可为 `GPT`、`Claude`、`GLM`、`unknown`。异构判断基于 model family，不只看 actor 名。

## Actor Registry

`config/actors.tsv` 是机器可读注册表。`actors.md` 中的表是说明，不代表一定可用。每次都必须 healthcheck。

| actor | backend | command/session | model_family | notes |
|---|---|---|---|---|
| `codefuse` | `cli_actor` | `cfuse --bare -p` | GLM/unknown | 旧 cross 的核心可用 actor；Claude Code 编排时默认优先 |
| `claude-code` | `cli_actor` | `claude -p` | Claude | Codex/CodeFuse 编排时可作为异构 actor；不同版本参数不同 |
| `codex-cli` | `cli_actor` | `cfuse --cx exec` 或本机 Codex CLI | GPT | 需确认命令和登录态 |
| `codex-subagent` | `codex_subagent` | 内置 subagent 工具 | GPT | 快速、稳定；不一定异构 |
| `codex-thread` | `codex_thread` | 独立 Codex thread | GPT | 跨 session；不一定异构 |

## Actor Selection

优先级:

1. 用户显式点名的 actor。
2. 已知可用的跨 CLI + 不同 `model_family` actor。
3. Legacy-compatible path: Claude Code orchestrator 优先 `codefuse`。
4. Codex orchestrator 优先尝试 `claude-code` 或 `codefuse`，谁 healthcheck 通过用谁；都可用时至少保留一个非 GPT actor。
5. CodeFuse orchestrator 优先尝试 `claude-code` 或 `codex-cli`。
6. 外部 actor 不可用时，降级到跨 session / subagent / 同模型多角色。

选择前先判断 orchestrator 的 model family。若无法确认，记录为 `unknown`，不要声称强异构。

## Controlled Runner

脚本默认不接受用户拼接的任意 shell command。使用 actor id 从 `config/actors.tsv` 读取命令:

```bash
scripts/actor_healthcheck.sh config/actors.tsv codefuse
scripts/run_actor.sh config/actors.tsv codefuse prompts/round-1.txt outputs/round-1-raw.txt status/codefuse-round-1.json
```

旧 cross 的直接命令等价于:

```bash
cat prompts/round-1.txt | cfuse --bare -p > outputs/round-1-raw.txt
```

`agent-council` 的 `run_actor.sh` 必须保持这个 stdin 调用语义。

## Healthcheck

调用 actor 前必须做短 healthcheck:

- command 是否存在
- timeout 内是否返回期望内容
- 输出是否非空
- 是否出现登录、权限、确认、交互提示

状态:

- `unknown`: 尚未检查
- `healthy`: timeout 内返回期望内容
- `degraded`: 可启动但慢、输出异常或偶发失败
- `unavailable`: 超时、空输出、认证卡住、权限卡住、非 0 退出

## 降级规则

1. 首选跨 CLI + 跨模型 actor。
2. 首选不可用时，尝试其他异构 actor。
3. 无异构 actor 时，可降级到跨 session。
4. 仍不可用时，可降级到同模型多角色，但 result 必须标注“本次不是强异构评审”。
5. review/debate/qa 的降级需要明确记录；不能伪造异构结果。

降级文案必须进入 `result.md`:

```text
原计划调用 {actor}，但本机当前不可用。原因见附录: {reason}。
本次改用 {fallback actor/backend}，因此结论属于 {same-model/cross-session/unknown} 评审，不是强跨模型评审。
```

## Known Working Path To Preserve

Before declaring the skill ready after actor-related changes, run at least this smoke test in a trusted local environment:

```bash
printf '只回复: OK\n' | cfuse --bare -p
```

Expected: output contains `OK`. If it does, Claude Code can use CodeFuse as the external actor using the same stdin mechanism.
