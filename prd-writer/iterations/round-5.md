# Round 5: chart-guide 工具定位回调 — Fireworks 从默认降为可选增强

**日期**: 2026-04-23

## 背景

Round 4 把 Fireworks Tech Graph 升为架构图默认工具，但 SKILL.md、prd-skeleton.md、image-placeholder-rules.md 等文件没有同步。排查发现 7 处不一致。

## 决策过程

用三个角色的 subagent 分别从不同视角辩论：

### 实用主义者
- 当前 Mermaid 出图对用户影响约等于零，不是正确性问题
- 7 处同步是治标，根因是同一规则散布在多个文件的 DRY 违规
- 如果要动，就让下游文件引用上游决策，不硬编码

### 架构师
- chart-guide.md 名义上是源头，但运行时优先级最低（按需加载）
- SKILL.md 衍生规则才是硬指令，应该由它定义"用什么"，chart-guide.md 只管"怎么用"
- 需要明确权威来源，消除优先级倒挂

### 怀疑论者（关键洞察）
- Fireworks 的集成管线（SVG→PNG→上传）在 PRD 生成流程中根本不存在
- Mermaid/PlantUML 在语雀原生渲染、可编辑；Fireworks 的 PNG 改个标签要重跑管线
- Round 4 是基于独立工具对比做的决定，没跑通端到端流程
- "没同步"的状态可能才是对的

### 最终结论
问题不是"7 处没同步"，而是 Round 4 把一个集成管线不存在的工具写成了默认。

## 改了什么

### 1. chart-guide.md 重写
- Mermaid 恢复为架构图默认工具（语雀原生渲染、可编辑、零管线成本）
- Fireworks 降为"增强路径"章节（用户明确要求高保真时使用）
- Fireworks 定位从"仅架构图可选"扩展为"所有图表类型的通用高保真可选项"（Fireworks 实际支持 14 种 UML 图，不只是架构图）
- 保留 Round 4 的 Fireworks 用法细节（拆图规则、布局约束、风格选择）
- 新增"权威来源说明"：明确 SKILL.md 衍生规则表是工具选择的权威，chart-guide.md 只提供用法细节
- 移除 drawio 作为 fallback 的独立决策分支（复杂图统一用拆图解决）

### 2. SKILL.md 更新
- L209: "drawio 配色" → "图表类型选择决策树、工具用法细节、Fireworks 可选增强路径"
- L291: 同步更新参考文件表
- Phase 3 框架输出新增第 5 点"图表风格确认"：当图表衍生规则触发时，主动询问用户是否使用 Fireworks 高保真图表

### 3. image-placeholder-rules.md 两处更新
- L9 能力表：加注 Fireworks 可选
- L125 区别表：加注 Fireworks 可选

### 4. prd-skeleton.md 模板 hint 增强
- 第三章顶部新增通用 hint：所有图表类型均可改用 Fireworks（用户要求高保真时）
- 第四章总 hint：加注时序图/状态机可用 Fireworks 增强
- 流程图 hint：区分单一流程 vs 多角色协作
- 状态机 hint：加注状态名用中文业务含义、转换条件写箭头上
- 链路说明：新增 PlantUML 时序图写法关键规范（颜色标注、步骤编号、activate、note）

## 确认不改的

- SKILL.md 衍生规则表（L105-112）：Mermaid/PlantUML 逻辑保持原样
- CLAUDE.md：已在 Round 4 正确更新，但架构图部分描述需要和本轮一致（Fireworks 降为可选后，CLAUDE.md 里"架构图用 Fireworks Tech Graph（>6 节点）"的说法需要后续评估是否调整）

## 改动文件清单

| 文件 | 改动 |
|------|------|
| `skill/references/chart-guide.md` | 全面重写：Mermaid 恢复默认，Fireworks 降为全图表类型的通用可选增强路径 |
| `skill/SKILL.md` | L209、L291 描述更新 |
| `skill/references/image-placeholder-rules.md` | L9、L125 加注 Fireworks 可选 |
| `skill/templates/prd-skeleton.md` | 第三章/第四章通用 Fireworks hint + 流程图/状态机/时序图 hint 增强 |
| `iterations/round-5.md` | 本文件 |
