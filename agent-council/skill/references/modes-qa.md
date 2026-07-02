# Mode: QA

用于 eval、QA、regression 门禁。它不是继续设计方案，而是判断当前产物是否过关。

Profiles:

- `eval`: 是否符合 rubric，是否真的变好
- `qa`: 是否满足原始需求和验收标准
- `regression`: 是否修 A 坏 B、破坏既有能力

## QA Gate Policy

- `required`: 涉及 skill/架构/代码改动、多 agent 最终方案、上线前评审、用户担心遗漏/回归/越改越差。
- `recommended`: 方案有一定复杂度，但用户只是要建议。
- `skipped`: 轻量问答、用户明确不要多 agent/不要质检、无可评审产物。

如果跳过 QA，最终报告必须说明“未做 QA，因为...”

## QA Evidence Packet

主会话必须先构造冻结输入:

```text
1. 原始用户需求
2. 明确验收标准
3. 非目标 / 不做事项
4. 本次变更范围
5. 待评审内容
6. 基线行为
7. 已执行验证
8. 已作出的设计决定
```

可直接使用模板:

```text
【QA Evidence Packet】

【原始用户需求】
{original_request}

【明确验收标准】
{acceptance_criteria}

【非目标 / 不做事项】
{non_goals}

【本次变更范围】
{change_scope}

【待评审内容】
{artifact_or_diff}

【基线行为】
{baseline_behavior}

【已执行验证】
{verification_results}

【已作出的设计决定】
{decisions}
```

评审边界:

- 只能根据冻结输入判断。
- 不允许提出新产品方向、新架构目标或额外需求。
- 没有证据的问题只能列为 risk，不能作为 FAIL。
- 需求冲突或信息不足时输出 NEEDS HUMAN DECISION。

## Verdict

必须输出单一 verdict:

```text
PASS | FAIL | NEEDS HUMAN DECISION
```

规则:

- `PASS`: 没有 blocking finding，且核心验收标准有证据支持。
- `FAIL`: 有证据证明需求未满足、回归、错误行为或必要验证缺失。
- `NEEDS HUMAN DECISION`: 取舍、范围、口径或需求冲突无法由 agent 判断。

## Anti-overengineering

检查:

- 是否新增无直接需求关系的抽象、框架、配置层、状态机、协议或通用化能力
- 是否扩大文件/模块影响面
- 是否引入新依赖、数据模型或用户流程
- 是否存在更小改法
- 新增复杂度是否有明确收益和证据

偏好更简单不等于 FAIL。只有复杂度导致维护风险、行为风险、测试缺口或偏离需求时才可判 FAIL。

## 主会话 Triage

主会话不能把 QA 输出原样当行动清单。必须逐条判断:

- 是否在冻结需求范围内
- 是否有具体证据
- 是否影响验收、回归或正确性
- minimal fix 是否真的是最小修复

修复时只处理 accepted blockers，不借机重构。

## QA Triage Result 模板

```text
【QA TRIAGE RESULT】

Verdict received: {PASS|FAIL|NEEDS HUMAN DECISION}

Accepted blockers:
- {id}: 接受原因 | 修复动作 | 验证方式

Rejected / deferred findings:
- {id}: 不采纳原因: out of scope / no evidence / preference only / already covered

Human decisions:
- {id}: 需要用户决定的问题 | 可选项 | 推荐默认

Next action:
- PASS: 结束并汇报
- FAIL: 只修 accepted blockers，然后 rerun qa
- NEEDS HUMAN DECISION: 先问用户，不继续扩大实现
```

## 用户可读 QA 三句话

最终报告必须给用户三句话:

```text
QA 结论: 通过/不通过/需要你拍板。
关键证据: {用一句话说明为什么}
你下一步: {可以继续 / 先修哪些项 / 请在 A/B 中选择}
```

## Human Decision Card

```text
需要你拍板: {问题}
为什么 agent 不能决定: {原因}
选项 A: {影响}
选项 B: {影响}
推荐默认: {默认选项及理由}
你只需要回复: A 或 B
```
