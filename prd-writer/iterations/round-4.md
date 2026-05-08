# Round 4: 架构图工具升级 — Fireworks Tech Graph 替代 drawio

**日期**: 2026-04-22

## 改了什么

### 1. Fireworks Tech Graph 升为架构图默认工具
chart-guide.md 中，架构图推荐工具从 drawio 改为 Fireworks Tech Graph。原因：语义化形状（六边形=Gateway、柱体=DB、管道=Kafka）+ 4 色箭头语义 + 40+ 产品品牌色，视觉信息密度远高于 drawio 的纯矩形+颜色方案。

### 2. drawio 降为 fallback
仅在节点 >15 且连线密集、Fireworks 出图连线错位时使用。移除了 drawio 绘图约束整节（配色方案、布局要求等），因为不再是默认路径。

### 3. 移除 architecture-diagram
该 skill 只有暗色主题 HTML 输出，语雀不兼容，且功能被 Fireworks 的 Dark Terminal 风格完全覆盖。

### 4. 新增拆图规则
单张图节点上限 12 个，超过按层/按域/总分结构拆分。这是规避 Fireworks 手动 SVG 坐标在复杂图中连线错位的根本解法。

### 5. 新增 Fireworks 布局约束
6 条强制规则：同层≤4 节点、正交路由、8px 网格对齐、80px 间距、箭头错开、标签白底背景。

### 6. 新增风格选择指引
PRD 默认 Flat Icon（白底，适合语雀），另列 Dark Terminal、Blueprint、Notion Clean 的适用场景。

### 7. 新增 AI/Agent 架构场景
场景对照表和决策树新增 AI/Agent 架构分支，Fireworks 是唯一选择（语义形状 + 专项模式）。

### 8. CLAUDE.md 图表规则同步更新
从"流程图用 Mermaid，时序图/状态机用 PlantUML，关系图用 Graphviz DOT"扩展为包含 Fireworks 和 drawio fallback 的完整规则。

## 为什么改

基于三个画图 skill（Fireworks Tech Graph、architecture-diagram、drawio MCP）的对比评估：
- 同一场景（支付系统架构图）分别用 Fireworks 和 drawio 出图
- Fireworks 在语义表达、品牌色精准度、风格一致性上明显优于 drawio
- drawio 唯一优势是自动布局引擎处理密集连线更稳定，但通过拆图规则可以规避
- 用户确认：PRD 评审后不存在非技术人员二次编辑图表的场景，也不需要本地归档 .drawio 文件

## 确认不做的

### drawio 完全移除
保留为 fallback。极端复杂图（>15 节点密集连线）Fireworks 的手动坐标确实可能出问题，留一个安全网。

## 反馈记录

- 用户明确"PRD 评审后不存在非技术人员二次编辑图表"→ drawio 的可编辑性优势不成立
- 用户明确"图片放语雀文档里，不需要本地管理 .drawio 文件"→ 归档场景不成立
- 用户关注"能不能通过提示词优化避免连线错位"→ 拆图规则 + 布局约束是回应

## 改动文件清单

| 文件 | 改动 |
|------|------|
| `skill/references/chart-guide.md` | 全面重写工具推荐、决策树、场景对照表、新增拆图规则和布局约束 |
| `CLAUDE.md` | 第20行图表规则同步更新 |
