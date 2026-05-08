# prd-writer 项目开发指令

## 项目结构

- `skill/` 是 skill 工作目录，可以随意修改试验
- 定稿后运行 `bash publish.sh` 发布到所有 Claude Code skills 安装目录
- 项目和 skill 安装是隔离的：项目里改不影响已安装的 skill，必须显式发布
- `materials/` 中的真实 PRD 片段已脱敏，可安全提交 git

## 迭代规范

- 每轮迭代新建 `iterations/round-N.md`，记录：改了什么、为什么改、基于什么反馈
- 测试产出物存到 `outputs/{test-name}/prd_vX.Y.md`，不覆盖历史版本
- 改完 SKILL.md 后必须用 tests/ 中的项目跑一遍验证

## 写作约束

- skill 文件中的示例必须来自真实 PRD（脱敏），不用虚构示例
- 禁用表达列表（AI 套话、视觉参数、空洞修饰）必须严格执行
- 图表规则：流程图用 Mermaid，时序图/状态机用 PlantUML，架构图用 Fireworks Tech Graph（>6 节点）或 Mermaid（≤6 节点），关系图用 Graphviz DOT，drawio 仅作超复杂图 fallback
