# AI PM Skills

> 面向 AI 时代产品经理的 Agent CLI Skill 工具链，帮助 PM 从模糊想法出发，完成早期研究、产品验证和结构化 PRD 交付。

AI PM Skills 是一组产品经理工作流 Skill。它不是单个提示词集合，而是一套可被 Agent CLI 调用、组合和复用的产品工作方法。

这组 Skill 可以帮助你：

- 从一个模糊想法开始，澄清用户、场景、问题和产品机会
- 快速理解一个赛道、竞品、技术方向或市场变化
- 先做 Demo 验证，再反向沉淀结构化 PRD
- 在 Codex、Claude Code 等本地 Agent CLI 中复用产品工作流

当前包含四个核心 Skill：

| Skill | 解决的问题 | 典型输入 | 典型输出 |
|---|---|---|---|
| PD Deep Research | 早期产品决策研究 | 一个方向、竞品、技术或市场问题 | 分层研究文档、决策简报、风险与机会判断 |
| AI Native PD | 从想法到 Demo 的产品工作流 | “我有个想法””帮我验证这个需求” | 需求评估、产品简报、Demo、交付路径 |
| PRD Writer | 基于已有材料生成结构化 PRD | Demo、原型、方案文档或代码项目 | 结构化 PRD、图表、验收标准、范围说明 |
| PD Copywriter | 中文产品文案引擎 | “帮我写文案””文案诊断””这个文案怎么改” | UI 交互文案、营销推送文案、说明型文案 |

## 为什么做这组 Skill

AI 让产品经理的工作方式发生了变化：很多时候不再是先写一份完整 PRD，再交给设计和研发，而是先把想法变成可验证的东西，再从验证结果反向沉淀文档。

这组 Skill 的核心假设是：

- 研究的价值在于改变产品决策，而不只是收集信息
- Demo 是验证工具，不是最终产品
- PRD 应该服务于沟通、协作和交付，而不是为了“看起来完整”
- 好的 PM Skill 应该能独立运行，也能被其他 Skill 调用
- Skill 不应该强绑定单一 CLI，缺少增强能力时也应该能降级继续

## 三个 Skill

### 1. PD Deep Research

早期决策研究 Skill，用于把模糊问题变成可行动的产品决策依据。

它通过“行业演变”和“竞争态势”两个视角进行研究，最终回答五类 PM 决策问题：

- 做不做：方向是否值得投入
- 做什么：产品定位和 MVP 边界是什么
- 怎么赢：差异化和竞争策略是什么
- 怎么赚：商业模式和增长路径是什么
- 怎么避坑：关键风险和应对方式是什么

推荐使用场景：

- 新赛道探索
- 竞品深度分析
- 技术选型论证
- 市场进入策略
- 产品创新方向研究
- 需要把信息整理成产品决策依据的早期研究任务

### 2. AI Native PD

全流程产品工作方式 Skill，用于把一个模糊想法推进到可验证 Demo，再进入 PRD 交付。

核心流程：

- Phase 1：需求发现与问题定义
- Phase 1b：竞品与现状调研，检测到 PD Deep Research 时增强，否则轻量调研
- Phase 2：产品定义，收敛核心场景、方案边界和一页纸产品简报
- Phase 3：设计先行与 Demo 开发，检测到 UI Skill 时增强，否则使用轻量默认样式
- Phase 4：PRD 输出，检测到 PRD Writer 时增强，否则生成简版 PRD

推荐使用场景：

- 0 到 1 产品探索
- 内部工具和效率工具
- 小团队快速验证想法
- 先做 Demo、再补齐产品文档的项目
- 需要在 Agent CLI 中跑完整产品工作流的场景

### 3. PRD Writer

结构化 PRD 生成 Skill，用于基于已有原型、Demo、代码或方案文档，反向生成高质量产品需求文档。

核心理念是：先做东西，再写文档。

它会先读取项目材料，自动推断产品复杂度、用户角色、业务流程、状态机、数据与埋点、风险、验收标准等 31 个维度，再决定 PRD 的结构和深度。

特点：

- 31 维度自动推断，三档模式自动判断（完整 / 轻量 / H5轻量）
- Mermaid / PlantUML 图表规则
- 禁用 AI 套话，强调可执行、可验收、可沟通
- 支持生成后发布到用户选择的文档平台或本地路径

推荐使用场景：

- 已有 Demo，需要补 PRD
- 已有原型或方案，需要结构化成文档
- 已有代码项目，需要反向梳理产品说明
- 用 AI 快速开发后，需要沉淀给团队协作
- 需要统一 PRD 结构、图表规范和验收标准的项目

## Skill 调用链

三个 Skill 可以独立使用，也可以组合成完整工作流：

```text
PD Deep Research ← AI Native PD Phase 1b
UI Skills        ← AI Native PD Phase 3 Design
PRD Writer       ← AI Native PD Phase 4
```

典型路径：

```text
我有个想法
  → AI Native PD 澄清需求
  → PD Deep Research 增强调研
  → AI Native PD 生成产品简报和 Demo
  → PRD Writer 反向生成 PRD
```

如果缺少某个增强 Skill，流程不会中断。AI Native PD 会向用户披露当前能力缺失，并使用轻量内置流程继续。

## 安装

每个 Skill 目录下都有 `publish.sh`，可以发布到常见 Agent CLI 的 skills 安装目录。

安装全部三个 Skill：

```bash
bash pd-deep-research/publish.sh
bash ai-native-pd/publish.sh
bash prd-writer/publish.sh
```

只安装某一个 Skill：

```bash
bash pd-deep-research/publish.sh
```

发布到指定 CLI：

```bash
bash prd-writer/publish.sh codex
bash prd-writer/publish.sh claude
```

发布到自定义路径：

```bash
bash prd-writer/publish.sh custom /path/to/skills/prd-writer
```

手动安装时，请复制每个项目下的 `skill/` 子目录内容，而不是复制整个项目目录。

例如安装到 Codex：

```bash
mkdir -p ~/.codex/skills/pd-deep-research
cp -r pd-deep-research/skill/* ~/.codex/skills/pd-deep-research/
```

例如安装到 Claude Code：

```bash
mkdir -p ~/.claude/skills/pd-deep-research
cp -r pd-deep-research/skill/* ~/.claude/skills/pd-deep-research/
```

## 可选增强

这组 Skill 可以独立运行，也可以和其他 Skill 或 MCP Server 组合使用。

UI Skill：

- [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)：设计系统生成，检测到时优先调用
- [huashu-design](https://github.com/alchaincyf/huashu-design)：HTML 高保真原型和品牌规范
- frontend-design：distinctive 前端界面，Claude Code 内置 example skill

MCP Server：

- [drawio](https://github.com/jgraph/drawio-mcp)：流程图和架构图增强
- [architecture-diagram](https://github.com/Cocoon-AI/architecture-diagram-generator)：大型架构图
- [Fireworks Tech Graph](https://github.com/yizhiyanhua-ai/fireworks-tech-graph)：高保真技术图表

MCP Server 需要通过对应项目说明安装和配置，不能直接复制到 skills 目录。

## 目录结构

```text
ai-pm-skills/
├── pd-deep-research/
│   ├── skill/
│   │   ├── SKILL.md
│   │   ├── references/
│   │   ├── templates/
│   │   └── cases/
│   ├── iterations/
│   └── publish.sh
├── ai-native-pd/
│   ├── skill/
│   ├── iterations/
│   ├── tests/
│   └── publish.sh
├── prd-writer/
│   ├── skill/
│   ├── materials/
│   ├── iterations/
│   ├── tests/
│   └── publish.sh
├── LICENSE
└── README.md
```

## 设计原则

- 独立可用：每个 Skill 都应该能单独完成一类任务
- 可组合：上游 Skill 的输出应该能被下游 Skill 读取
- 可降级：缺少增强 Skill 或 MCP Server 时，不应阻塞核心流程
- 可迁移：尽量支持不同 Agent CLI，而不是绑定单一工具
- 可沉淀：产出尽量写入项目文件，减少对对话上下文的依赖

## License

MIT License. See [LICENSE](LICENSE).
