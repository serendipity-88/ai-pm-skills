# pd-deep-research 项目开发指令

## 项目结构

- `skill/` 是 skill 工作目录，可以随意修改试验
- 定稿后运行 `bash publish.sh` 发布到已知 Agent CLI skills 安装目录，或用 `bash publish.sh codex|claude|custom <path>` 指定目标
- 项目和 skill 安装是隔离的：项目里改不影响已安装的 skill，必须显式发布
- `iterations/` 记录每轮迭代的改动和决策

## 迭代规范

- 每轮迭代新建 `iterations/round-N.md`，记录：改了什么、为什么改、基于什么反馈
- 改完 SKILL.md 后需要验证核心流程（至少跑一个完整 Phase）
- `cases/` 中的案例展示各阶段产出效果，帮助理解"好的产出长什么样"

## 独立性原则

- 本 skill 完全独立，SKILL.md 中不引用任何其他 skill
- 可被其他 skill 调用（传入研究主题 + 输出目录），但调用逻辑在调用方一侧
- 产出文件使用通用格式，不针对任何特定调用方

## 写作风格约束

- 所有产出必须通过"so-what"测试：删掉这段后是否影响决策？不影响就删
- 第一层决策简报纯表格，零散文
- 第二层决策推理先叙事再表格提炼
- 所有洞察必须标注可信度 [高/中/待验证]
- 明确区分"已验证事实"和"待验证假设"
- 详细规范见 `skill/references/writing-quality-standards.md`

## 产出结构

- 生产侧：三阶段研究产出一份完整的 `research-report.md`（三个分层章节）
- 交付侧：Phase 3 完成后询问消费场景（快速决策/向上汇报/团队讨论/完整存档），按场景裁剪内容+选择格式（MD/HTML）
- 被其他 skill 调用时：不询问消费场景，直接产出完整 `research-report.md`
