---
name: agent-council
description: >
  Multi-agent / A2A 协作议事 skill。用于产品方案、代码开发、skill 设计、技术架构、eval/QA 的多 agent
  设计、审查、辩论、实现拆解和质量门禁。用户不需要记住 mode 或角色；当用户明确要求多个 agent/sub-agent/模型、
  不同角色一起讨论、互相挑战、交叉评估，或担心复杂方案越改越差并要求 QA/eval/regression 时触发。
  兼容 legacy 触发词: /cross、/cross review、/cross work、/cross argue、/cross qa、cross-review、cross-work、cross-argue、cross-qa。
---

# Agent Council

`agent-council` 是一个 AI 评审委员会。主会话负责组局、分角色、选择 actor、收敛和裁决；actor 负责按指定角色产出观点、方案、挑战或 QA 门禁结论。

## Quick Start

用户只要说自然语言即可:

```text
这个方案很复杂，找几个 agent 从产品、技术、运营角度一起讨论，最后给我完整方案。
```

主会话自动执行:

```text
理解目标 → 创建过程记录 → 分配几个合适视角 → 检查可用 agent → 组织讨论/评审 → 质检 → 给出结论
```

## 0. 使用心智

自然语言是主入口。用户不需要知道 `design/review/debate/implement/qa`、`target_type` 或 `actor_role`。

触发示例:

- “这个方案很复杂，找几个 Agent 从产品、运营、技术角度一起讨论，最后给我完整方案。”
- “找几个 sub-agent 作为架构师互相挑战，给我最稳妥的技术设计。”
- “找几个不同角色评估这个 skill: karpathy、Skill 的使用者、总监老板。”
- “我担心这轮越改越差，找一个 QA agent 做回归检查。”
- “帮我看看这个 PRD 有没有漏场景，最好从产品、技术、运营几个视角一起看。”
- “这两个方案哪个更稳？请安排反方检查和上线前质检。”

不触发示例:

- “解释一下这个概念。”
- “简单看一下这段文案。”
- “不用多 agent，直接给我一个建议。”
- “只修这个小 bug，不要扩展评审。”

高级 slash 入口:

- `/agent-council design`
- `/agent-council review`
- `/agent-council debate`
- `/agent-council implement`
- `/agent-council qa --profile eval|qa|regression`

Legacy alias: `/cross review|work|argue|qa` 和 `cross-review|cross-work|cross-argue|cross-qa`。内部统一映射到 `agent-council`。

## 1. 自动路由

从用户自然语言推断:

| 维护者字段 | 含义 |
|---|---|
| `mode` | 协作方式: `design` / `review` / `debate` / `implement` / `qa` |
| `target_type` | 目标类型: `product` / `code` / `skill` / `architecture` / `eval` / `data` |
| `actor_role` | 角色: 用户指定优先；未指定时按目标类型自动补齐 |
| `actor_backend` | actor 来源: 跨 CLI、跨 session、内置 subagent |
| `qa_profile` | QA 类型: `eval` / `qa` / `regression` |

需要详细路由规则时读取 [target-types.md](references/target-types.md)。

路由步骤:

1. 先提取用户目标、约束、角色、期望产物。
2. 如果用户指定角色，保留用户角色；缺少 QA 时自动补一个 QA/evaluator。
3. 如果用户没指定角色，按 `target_type` 自动补默认角色。
4. 如果是复杂/需审计任务，先运行 `scripts/init_job.sh` 创建 `.agent-council/jobs/...`；若无写权限，继续执行但说明未留痕。
5. 如果任务复杂或涉及已有产物，默认加 QA gate。
6. 如果用户只要简单回答，不启动 council；直接回答并说明未调用多 agent。

## 2. 默认模式

| mode | 何时使用 | 产物 |
|---|---|---|
| `design` | 用户要多个 agent 一起设计方案、架构、skill、产品方案 | 推荐方案、备选方案、取舍、风险、执行步骤 |
| `review` | 用户已有方案、代码、PRD、SKILL.md，希望交叉审查 | 问题清单、采纳建议、风险、验证方式 |
| `debate` | 用户要求互相挑战、辩论、辩护、比较路线 | 共识、分歧、决策矩阵、推荐路线 |
| `implement` | 用户需要落地拆解、实现计划、patch 草案、测试策略 | 文件计划、接口设计、步骤、验证命令 |
| `qa` | 用户担心遗漏、过度设计、越改越差、回归；复杂任务也自动触发 | PASS/FAIL/NEEDS HUMAN DECISION |

读取对应 reference:

- [modes-design.md](references/modes-design.md)
- [modes-review.md](references/modes-review.md)
- [modes-debate.md](references/modes-debate.md)
- [modes-implement.md](references/modes-implement.md)
- [modes-qa.md](references/modes-qa.md)

## 3. 自动 QA Gate

QA gate 分三档:

- `required`: skill/架构/代码改动、多 agent 最终方案、用户明确担心遗漏/越改越差/上线风险。
- `recommended`: 中等复杂方案评估，但用户未明确要求快答。
- `skipped`: 简单解释、轻量建议、用户明确要求不要多 agent 或不要质检。

满足任一条件时必须自动安排 QA/evaluator actor:

- 涉及 skill 设计或修改
- 涉及技术架构
- 涉及代码实现方案或代码改动
- 多 agent 讨论后要给最终方案
- 用户说“复杂、稳妥、严谨、不要遗漏、互相挑战、交叉评估”，且任务不是轻量建议
- 已发生多轮修改，用户担心越改越差

QA actor 不参与方案共创，只判断:

- 是否满足原始需求
- 是否遗漏关键场景
- 是否过度设计
- 是否可执行
- 是否有回归风险

QA 必须输出 `PASS` / `FAIL` / `NEEDS HUMAN DECISION`。详见 [modes-qa.md](references/modes-qa.md)。

## 4. Actor 选择

优先选择真正异构 actor:

1. 跨 CLI + 跨模型: Codex / Claude Code / CodeFuse
2. 同 CLI 不同 session: Codex thread/subagent、Claude session、CodeFuse session
3. 同模型不同角色: 最后降级

每次调用 actor 前必须 healthcheck。Actor 不可用时不能假装已参与；必须降级并写入结果。

需要 actor 注册、healthcheck、降级规则时读取 [actors.md](references/actors.md)。

如果当前环境无法调用跨 CLI actor，可使用内置 subagent 或独立 Codex thread 作为降级 actor，但最终报告必须标注模型同构/异构状态。

## 5. 核心原则

1. **自然语言优先**: 不要求用户记住 mode、角色或参数。
2. **编排不伪造 actor 输出**: 没调用外部/子 actor，就不能说“另一个模型认为”。
3. **主会话负责收敛**: actor 不做最终裁决；主会话必须给采纳/不采纳理由。
4. **下游只吃 clean output**: raw log 只用于审计，不喂给下一轮 actor。
5. **复杂任务自动 QA**: 不能等用户懂 QA/eval/regression 才做门禁。
6. **优先异构，显式降级**: 记录 actor、CLI/session、model family、healthcheck、是否降级。
7. **避免越改越大**: QA/implement 模式只允许围绕原始需求和验收标准做最小必要动作。
8. **禁止递归组局**: council 运行中不再触发新的 council；actor 要求“再找几个 agent”时由主会话 triage，不自动递归执行。

## 6. 留痕

复杂或需审计任务在分配 actor 前先写入 `.agent-council/jobs/<ts>-<mode>/`。普通用户不用看这个目录；它只用于追溯过程。无写权限或用户只要即时回答时，可以不落盘，但必须说明未留痕。默认 standard trace:

```text
.agent-council/jobs/<ts>-<mode>/
  job.json
  prompts/
  outputs/
    round-N-raw.txt
    round-N-clean.txt
  decisions/
  result.md
```

`result.md` 必须面向用户，而不是日志转述。详见 [trace.md](references/trace.md)。

初始化命令:

```bash
scripts/init_job.sh review skill /path/to/target
```

## 7. 最终报告

每次交付都应包含:

- 最终结论
- 为什么选择这些视角
- 本次用了几个独立视角，是否真的跨模型，有无降级，降级是否影响结论
- 关键发现
- 采纳和不采纳的建议
- QA 给用户看的三句话: 是否通过、关键证据、用户下一步要不要拍板
- 未验证项
- 下一步行动
