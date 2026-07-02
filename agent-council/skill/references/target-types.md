# Target Types

`target_type` 决定评审视角，不决定协作方式。

| target_type | 关注点 | 默认角色 |
|---|---|---|
| `product` | 用户价值、场景闭环、优先级、业务约束、上线风险 | PM、用户/运营、技术负责人、director |
| `code` | 正确性、边界条件、测试、兼容性、维护成本、安全 | implementer、reviewer、test-writer、regression-checker |
| `skill` | 触发条件、流程可执行性、工具边界、递归风险、用户用法、上下文成本 | skill-author、actual-user、agent-executor、maintainer、QA |
| `architecture` | 模块边界、数据流、扩展性、失败模式、迁移成本 | architect、implementer、maintainer、redteam、QA |
| `eval` | 指标、样本、rubric、judge、可复现性、偏差 | evaluator、data/metric reviewer、redteam |
| `data` | 口径、粒度、过滤条件、异常值、可解释性 | data analyst、metric owner、QA |

用户指定角色优先。例如用户说“karpathy、Skill 使用者、总监老板”，保留这三个角色，并补充必要的 QA/regression reviewer。

