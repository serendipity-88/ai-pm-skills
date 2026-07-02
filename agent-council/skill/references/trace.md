# Trace

复杂或需审计任务在分配 actor 前默认写入；轻量问答可跳过但需说明。路径相对当前 workspace:

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

## job.json 最小字段

```json
{
  "skill_name": "agent-council",
  "legacy_alias": "cross",
  "ts": "...",
  "mode": "design|review|debate|implement|qa",
  "target_type": "product|code|skill|architecture|eval|data",
  "actors": [],
  "actor_matrix": [],
  "qa_gate": "not_required|required|done",
  "qa_verdict": "PASS|FAIL|NEEDS_HUMAN_DECISION|null",
  "status": "running|done|failed"
}
```

## Init

Use:

```bash
scripts/init_job.sh <mode> <target_type> <target>
```

The script creates `prompts/`, `outputs/`, `rounds/`, `decisions/`, `status/`, `job.json`, and a `result.md` skeleton.

## result.md 必含

- 最终结论
- 参与角色与 actor matrix
- 是否真正跨模型/跨 session
- 关键发现
- 采纳/不采纳建议
- QA 是否完成
- QA verdict
- 未验证项
- 下一步行动

## result.md 模板

```md
# Agent Council Result

## 最终结论

{推荐结论，用非技术用户也能理解的话说明}

## 这次评审靠不靠谱

- 独立视角: {数量和角色}
- 是否跨模型: 是/否/未知
- 是否有降级: 有/无
- 降级是否影响结论: {说明}

## 为什么是这些视角

- {角色}: {为什么需要}

## 参与评审

技术附录:

| Role | Actor | Backend | Model Family | Status | Used For |
|---|---|---|---|---|---|

## 是否强异构

- Verdict: strong-heterogeneous | weak-heterogeneous | same-model | unknown
- 说明: {原因}

## 关键发现

- {finding}

## 决策

### 采纳
- {建议 | 原因 | 行动}

### 不采纳 / 后置
- {建议 | 原因}

## QA Gate

- Required: yes/no
- Verdict: PASS/FAIL/NEEDS HUMAN DECISION/not run
- 给用户看的三句话:
  - QA 结论: {通过/不通过/需要你拍板}
  - 关键证据: {一句话证据}
  - 你下一步: {继续/先修/选择 A 或 B}

## 未验证项

- {item}

## 下一步行动

1. {action}
```
