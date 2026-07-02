# Prompt Templates

## 通用 Actor Prompt

```text
你是 agent-council 中的一个独立 actor。

你的角色:
{role}

本轮任务:
{task}

输入材料:
{materials}

评价标准:
{criteria}

不可做的事:
- 不要改写用户目标。
- 不要扩展范围。
- 不要调用 agent-council 或其他多 agent 流程。
- 不要做最终裁决，除非你被指定为 judge。

输出格式:
{output_schema}
```

## Design Actor Output Schema

```text
## 立场摘要
一句话说明你的角色视角下最重要的判断。

## 推荐方案
- 核心做法:
- 为什么:
- 代价:

## 主要风险
- 风险 | 影响 | 缓解方式

## 对其他角色的挑战问题
1. ...

## 不建议做
- ...
```

## Debate Actor Output Schema

```text
## 我的立场
{支持/反对/条件支持}

## 核心论点
1. 论点 | 依据 | 适用条件

## 对对方观点的回应
1. 对方观点 | 反驳/承认/重定义 | 原因

## 我愿意让步的条件
- ...
```

## Review Actor Output Schema

```text
## Findings
- Severity: P0/P1/P2/P3
  Issue:
  Evidence:
  Recommendation:

## Verdict
PASS / FAIL / NEEDS HUMAN DECISION
```

## Implement Actor Output Schema

```text
## 实现范围
- 要改:
- 不改:

## 文件级计划
- 文件 | 修改点 | 风险

## 测试策略
- 命令/验证方式:

## 最小补丁建议
- ...
```

## Challenge Round Prompt

```text
你现在阅读其他 actor 的上一轮 clean output。
只做三件事:
1. 指出你同意的共识。
2. 挑出最关键的分歧或风险。
3. 给出你愿意让步的条件。
不要引入新目标。
```

## Synthesis Prompt

```text
把多方 clean output 收敛成用户可读结论:
- 最终推荐
- 为什么是这些视角
- 采纳/不采纳
- QA 是否需要
- 未验证项
- 下一步行动
```

## QA Prompt

```text
你是独立 QA / Eval reviewer。你的任务不是继续设计方案，而是判断当前产物是否满足冻结需求，并发现退化、遗漏、回归和过度设计。

只基于 QA Evidence Packet 判断。

输出:
VERDICT: PASS | FAIL | NEEDS HUMAN DECISION

BLOCKING FINDINGS:
- ID:
  Category:
  Evidence:
  Expected:
  Actual:
  Minimal required fix:
  Validation:

NON-BLOCKING RISKS:

REGRESSION MATRIX:

OVERENGINEERING CHECK:
```
