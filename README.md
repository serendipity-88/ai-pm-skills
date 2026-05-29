# AI PM Skills

> AI 时代产品经理的 Agent CLI Skill 工具链——从模糊想法到结构化 PRD 的全流程覆盖。

## 三个 Skill

### 1. PD Deep Research — 早期决策研究

从模糊问题到可行动的产品决策依据。通过行业演变与竞争态势双视角，产出分层决策简报，直接服务于做不做、做什么、怎么赢、怎么赚、怎么避坑五类产品决策。

**适合**：新赛道探索、竞品深度分析、技术选型论证、市场进入策略、产品创新方向研究
**不适合**：简单事实查询、写公众号文章、已有明确需求只需写 PRD

**产出**：三层研究文档（决策简报 → 决策推理 → 研究数据），按消费场景裁剪交付

### 2. AI Native PD — 全流程产品工作方式

从模糊想法到可交互 Demo 的完整产品工作流：需求发现 → 市场研究 → 产品设计 → 原型验证 → PRD 输出。

**核心流程**：
- Phase 1：想法澄清 + 市场研究（检测到 PD Deep Research 时增强调研，否则轻量调研）
- Phase 2：产品设计 + 原型开发
- Phase 3：设计先行 + 代码开发（Design 步骤如检测到 ui-ux-pro-max 则调用，扫描发现其他 UI skill 时提示用户选择；缺失时使用轻量默认样式）
- Phase 4：PRD 输出（检测到 PRD Writer 时增强生成，否则简版 PRD）

### 3. PRD Writer — 结构化 PRD 生成

基于已有原型、Demo 或方案文档反向生成结构化 PRD。核心理念：先做东西，再写文档。

**特点**：
- 31 维度自动推断 + 5 阶段生成流程
- 图表规范：Mermaid/PlantUML 默认，Fireworks Tech Graph 可选增强
- 禁用 AI 套话，强制通过 so-what 测试

## Skill 调用链

```
PD Deep Research ← AI Native PD (Phase 1b 调用)
UI Skills        ← AI Native PD (Phase 3 Design 步骤调用)
AI Native PD     → PRD Writer (Phase 4 调用)
```

三个 Skill 可以独立使用，也可以串联完成从"我有个想法"到"可交付的 PRD"的全流程。

**Phase 3 UI Skill 联动**：Build 步骤拆为 Design → Code，Design 步骤如检测到 ui-ux-pro-max 则生成设计系统，扫描发现 huashu-design / alipay-design / frontend-design 时提示用户选择是否追加；未检测到相关 skill 时降级为轻量默认样式。

## 安装

每个 skill 目录下有 `publish.sh`，运行后会复制到指定 Agent CLI 的 skills 安装目录。默认发布到已知路径（Codex / Claude Code / CodeFuse）：

```bash
# 安装全部三个
bash pd-deep-research/publish.sh
bash ai-native-pd/publish.sh
bash prd-writer/publish.sh

# 或只安装需要的
bash pd-deep-research/publish.sh

# 只发布到某个 CLI
bash prd-writer/publish.sh codex
bash prd-writer/publish.sh claude
bash prd-writer/publish.sh codefuse

# 发布到自定义安装目录
bash prd-writer/publish.sh custom /path/to/skills/prd-writer
```

**手动安装**：将 `skill/` 子目录的内容复制到 skills 安装目录（注意是 `skill/` 不是项目根目录）：

```bash
# 例如安装 pd-deep-research 到 Codex
mkdir -p ~/.codex/skills/pd-deep-research
cp -r pd-deep-research/skill/* ~/.codex/skills/pd-deep-research/

# 例如安装 pd-deep-research 到 Claude Code
mkdir -p ~/.claude/skills/pd-deep-research
cp -r pd-deep-research/skill/* ~/.claude/skills/pd-deep-research/
```

**可选增强**：

UI Skill（Phase 3 Design 步骤调用，不安装则使用默认样式）：
- [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) — 设计系统生成（检测到时优先调用）
- [huashu-design](https://github.com/alchaincyf/huashu-design) — HTML 高保真原型 + 品牌规范
- frontend-design — distinctive 前端界面（Claude Code 内置 example skill，无需安装）
- alipay-design — 支付宝设计规范代码模板（仅做支付宝产品时使用）

MCP Server（不安装不影响核心功能）：
- [drawio](https://github.com/jgraph/drawio-mcp) — 流程图/架构图增强（官方 draw.io MCP server）
- [architecture-diagram](https://github.com/Cocoon-AI/architecture-diagram-generator) — 大型架构图
- [Fireworks Tech Graph](https://github.com/yizhiyanhua-ai/fireworks-tech-graph) — 高保真技术图表（SVG+PNG）

> MCP server 需要通过 `npm install` + 配置 `settings.json` 安装，不能直接复制到 skills 目录。详见各项目 README。

## 目录结构

```
ai-pm-skills/
├── pd-deep-research/
│   ├── skill/               # Skill 核心文件
│   │   ├── SKILL.md         # 主定义文件
│   │   ├── references/      # 写作标准、可信度框架
│   │   ├── templates/       # 产出模板
│   │   └── cases/           # 案例参考
│   ├── iterations/          # 迭代记录
│   └── publish.sh           # 发布脚本
├── ai-native-pd/
│   ├── skill/               # Skill 核心文件
│   ├── iterations/          # 迭代记录
│   ├── tests/               # 测试用例
│   └── publish.sh
├── prd-writer/
│   ├── skill/               # Skill 核心文件
│   ├── materials/           # 训练材料
│   ├── iterations/          # 迭代记录
│   ├── tests/               # 测试用例
│   └── publish.sh
└── README.md
```

## License

MIT License. See [LICENSE](LICENSE).
