# Agent Council

Multi-agent / A2A 协作议事 skill，用于产品方案、代码开发、skill 设计、技术架构、eval/QA 的多 agent 设计、审查、辩论、实现拆解和质量门禁。

## 能做什么

- 用自然语言触发多 agent 协作，不要求用户记住 mode 或角色
- 自动按产品、技术、架构、QA/eval 等视角分配角色
- 优先调用真实外部 actor，例如 CodeFuse / Claude Code / Codex CLI
- 外部 actor 不可用时显式降级，不伪造跨模型结果
- 对复杂任务自动加入 QA gate，检查遗漏、过度设计和回归风险
- 保留过程 trace，便于复盘 agent 是否真的参与

## 当前验证状态

| 能力 | 状态 |
|---|---|
| Codex 内部 subagent 多角色评审 | 已验证 |
| Codex -> CodeFuse actor (`cfuse --bare -p`) | 已验证 |
| 旧 `cross` 的 CodeFuse 调用能力 | 已恢复并验证 |
| Codex -> 独立 Claude Code actor (`claude -p`) | 当前未通过，登录态不可用 |
| CodeFuse 底层模型身份自动识别 | 当前未自证，需记录为 unknown 或 user-reported |

## 安装

安装正式 skill:

```bash
bash agent-council/publish.sh codex
bash agent-council/publish.sh claude
bash agent-council/publish.sh codefuse
```

同时安装 legacy `cross` 兼容入口:

```bash
bash agent-council/publish.sh codex --with-cross
```

## 目录

```text
agent-council/
├── skill/              # 正式 agent-council skill
├── legacy-cross/       # cross legacy alias，只兼容旧入口
├── eval/               # dogfood / QA 记录
└── publish.sh
```
