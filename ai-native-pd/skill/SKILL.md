---
name: "ai-native-pd"
description: "AI 时代产品经理全流程工作方式——从模糊想法到需求发现、Demo 验证、产品交付。当用户说'我有个想法'、'帮我分析这个需求'、'做个 Demo 验证一下'时触发。"
---

# AI-Native PM Workflow

> 帮助产品经理从模糊想法出发，通过 AI 辅助的需求发现、竞品调研、快速验证，最终交付可运行产品和结构化文档。

> 适合：0→1 产品探索、内部工具、快速验证想法、小团队项目。不适合：多团队 B 端大项目、强合规行业。已有成熟产品迭代请直接用 prd-writer。

## FIRE 原则

- **F**irst runnable：先做出可运行的东西验证想法
- **I**terate：循环改进，每轮包含三步：
  - **改**：修改/增强产品
  - **验**：呈现变更，收集用户或目标受众的反馈（"符合预期吗？差在哪？"）
  - **决**：继续深化 / 调整方向 / **停止**（停止是正式选项——不是所有想法都值得做完）
- **R**everse-engineer docs：从实践反向生成文档（委托 prd-writer）
- **E**volve：持续演进

---

## 入口

### 项目状态检测

触发时先扫描当前项目目录：

| 检测到 | 说明 | 行动 |
|--------|------|------|
| `prd/` 下有 PRD 文件 | Phase 4 已完成 | "检测到 PRD 已生成，要迭代还是同步？" |
| 代码文件存在（.tsx/.vue/.py 等）且有 `assets/product-brief.md` | Phase 3 至少部分完成 | "检测到已有 Demo 代码，要继续迭代还是进入交付？" |
| `README.md` 中有部署链接（vercel.app / netlify.app / pages.dev 等部署平台 URL，或标注为 Demo/Preview/Live 的外部链接） | Phase 3 含部署已完成 | "检测到已有部署的 Demo，要继续迭代还是进入交付？" |
| `assets/product-brief.md` 存在但无代码文件 | Phase 2 已完成 | "检测到产品简报已完成，要开始做 Demo 吗？" |
| `assets/requirement-assessment.md` 存在但无 `assets/product-brief.md` | Phase 1 已完成 | "检测到需求评估已完成，要继续定义产品方案吗？" |
| 无上述文件 | 新项目 | 进入场景分流 |

用户确认后进入对应的下一阶段；用户说"跳过"则跳到再下一阶段；用户拒绝则询问想做什么。

### 场景分流

根据用户输入自动判断，进入对应路径：

| 用户意图 | 判断依据 | 路径 |
|---------|---------|------|
| **急用** | "今天要给老板看""快速做个 Demo""时间紧" | 仅确认痛点/目标/用户 3 个核心问题 → 直接 Phase 3 |
| **正常** | 描述了想法或需求，无特别时间压力 | Phase 1 → 2 → 3 → 4 完整流程 |
| **论证** | "要立项""帮我论证一下""要说服老板" | Phase 1 深度模式（扩展调研）→ 2 → 3 → 4。论证路径提供更深入的需求调研和竞品分析，但不替代专业立项报告（市场规模/技术可行性请另行准备） |
| **需求模糊** | 想法不成形，说不清楚要什么 | 如检测到 brainstorming skill，调用它理清思路；未检测到时用内置追问框架继续。基于用户选择重新进入分流（最多回流 1 次，若仍模糊则由用户指定路径） |
| **要汇报** | "给老板汇报""做个 PPT" | 引导到 pptx 或 internal-comms skill |

分流不锁死——过程中发现需要更深入分析时，可随时从急用升级到正常或论证。

**急用路径特殊规则**：1a 仅执行步骤 1-2（用户核心任务 + 需求分类），写入精简版 `requirement-assessment.md`（仅填 3 维度：背景/痛点、业务目标、用户与场景，其余标注"急用路径跳过"）；跳过 1b 和 Phase 2，直接进入 Phase 3。

**升级规则**：用户主动要求更深入分析，或 AI 发现阶段性产出明显不足时，可触发升级。从当前阶段的下一步开始补充缺失阶段（如从急用 Phase 3 中升级，先补 1b 和 Phase 2 再继续），已确认的核心问题保留不重新询问。不支持降级。

---

## Phase 1: 发现

**目标**：把模糊想法变成结构化的需求理解。这是整个流程中最重要的阶段。

### 1a 问题定义

将用户描述转化为结构化需求，不要求用户按特定格式输入：

1. **用户核心任务**：将用户的自然语言描述转化为结构化表述——"当[场景]时，[用户]想要[动机]，以便[结果]"。如果用户描述中场景、动机、结果有缺失，从上下文推断后补全，拿回去确认："我的理解是……对吗？"
2. **需求分类**：标注这是哪类需求——痛点（现有方案有明确不满，用户在忍受）、痒点（没有也行但有了更好）、爽点（即时满足，用了就回不去）。分类影响后续优先级判断。
3. **7 维度快速评估**：基于 `templates/requirement-assessment.md` 的 7 个维度（背景/痛点、业务目标、用户与场景、核心用户旅程、现有方案、业务规则、参考/竞品），从用户描述中自动填充能推断的维度，仅追问**真正缺失且无法推断**的必要信息。
4. 将评估结果写入 `assets/requirement-assessment.md`

### 1b 竞品与现状调研

自动执行，不需要用户额外输入：

1. **调研执行**：如检测到 pd-deep-research skill，调用它并传入研究主题（从用户输入提取）+ `context`（1a 已收集的用户核心任务、7 维度摘要、已知约束、特别关注点）+ 输出目录（`assets/pd-deep-research/`）；未检测到时，向用户披露"未检测到深度调研 skill，将用轻量内置调研继续，置信度会弱一些"，并用同样输出结构生成轻量调研结论
2. **读取决策简报**：增强模式下，pd-deep-research 产出 `assets/pd-deep-research/research-report.md`（单文档三层结构）；轻量模式下，读取内置调研结论。本步骤读取第一层"决策简报"章节，提取：
   - 关键决策 → 填入需求评估的"现有方案"维度
   - 机会窗口 → 填入"参考/竞品"维度
   - 风险与待确认 → 风险填入"背景/痛点"维度，待确认项标记为待确认
   - 需求衔接 → 提取目标用户、产品定位、边界约束、成功指标方向、下一步行动
3. **生成调研摘要文件**：将第一步"决策简报"的提取结果写入 `assets/research-findings.md`，包含：关键决策表、机会窗口、风险与待确认、需求衔接（目标用户、产品定位、边界和约束、成功指标、下一步行动），保留 pd-deep-research 的置信度标签 [高/中/待验证]。此文件供后续 Phase 4 调用 prd-writer 时使用
4. **按需阅读完整分析**：如需更深入理解某个决策的推理链，读取同一文件的第二层"决策推理"章节

> 急用路径跳过此步。

> AI 搜索的竞品信息约 60-70% 可用。常见问题：混淆不同产品的功能、引用过时信息。pd-deep-research 的可信度标注系统可帮助识别高/中/待验证信息。

### 1c 调研摘要

汇总 1a + 1b 的结果，一次性向用户呈现：

```
## 需求理解
- 用户核心任务：当[场景]时，[用户]想要[动机]，以便[结果]
- 需求类型：痛点/痒点/爽点
- 7 维度评估中待确认的项（如有）

## 竞品现状（如做了 1b）
- [竞品1]：[一句话总结方案和差异]
- [竞品2]：...
- 核心差异点：[我们方案独特在哪]

## 风险提示（论证路径必选，引用 `templates/formal-report.md` 6.2 风险矩阵；其他路径如有）
- [具体风险和理由]

→ 你觉得这个方向值得继续推进吗？
```

**HARD-GATE**：用户必须明确确认方向后才能进入 Phase 2。不要默认"没说不行就是行"。

### 输出

- `assets/requirement-assessment.md`（基于 `templates/requirement-assessment.md`）
- `assets/research-findings.md`（1b 从 pd-deep-research 决策简报提取，急用路径无此文件）

---

## Phase 2: 定义

**目标**：将发现阶段的结论收敛为可执行的产品方案。

- 核心场景裁剪：从所有可能的场景中选出最多 3 个核心场景
- 方案设计：基于 Phase 1 调研结果设计解决方案
- 范围边界：明确"做什么"和"不做什么"
- 输出一页纸产品简报，写入 `assets/product-brief.md`

**HARD-GATE**：向用户展示产品简报摘要（核心场景、技术方向、做什么/不做什么），用户确认后才进入 Phase 3 开始 coding。这是回退成本最高的门禁——确认错了就白写代码。

> 急用路径跳过此阶段。

---

## Phase 3: 验证

**目标**：用可运行的 Demo 验证产品方案。Demo 是验证工具，不是最终产品。

### Build

**设计先行**：写代码前先确定设计方向和规范。

1. **Design**（设计步骤）：
   - 如检测到 **ui-ux-pro-max**，调用它并传入产品简报 + 技术栈偏好，产出 `assets/design-system/MASTER.md`（设计系统 + 技术栈实现指南）
   - 如未检测到 ui-ux-pro-max，向用户披露"未检测到设计增强 skill，将使用内置轻量设计约束继续"，不阻塞流程
   - 扫描其他已安装 UI skill，向用户提示发现：
     > 检测到你还安装了以下 UI skill，需要一起用吗？
     > | Skill | 能做什么 |
     > |-------|---------|
     > | huashu-design | HTML 高保真原型 + 品牌规范 |
     > | alipay-design | 支付宝设计规范代码模板 |
     > | frontend-design | distinctive 前端界面 |
     >
     > 输入 skill 名称追加，不需要则跳过。
   - 用户选择后调用对应 skill，产出写入项目目录：
     - huashu-design → `assets/brand-spec.md`（品牌规范）+ HTML 高保真原型
     - alipay-design → 符合支付宝规范的代码模板
     - frontend-design → 前端界面代码

2. **Code**（编码步骤）：
   - 基于 Design 步骤的设计产出写 Demo 代码
   - 未调用 UI skill 时（急用路径或 skill 不可用），使用默认样式
   - 开发原则：MVP 思维，先跑通核心流程
   - 部署方式根据用户条件选择（Vercel / 本地运行 + 截图）

> 急用路径跳过 Design 步骤，直接 Code。

### Iterate

每轮迭代包含三步：
1. **改**：修改/增强代码
2. **验**：呈现变更（截图或可运行链接），向用户提问："这个交互符合你的预期吗？和你想的有什么差距？"
3. **决**：用户决定——继续深化 / 调整方向 / 够了进入下一阶段

退出条件：用户确认当前 Demo 足够验证核心假设。

### 输出

- 可运行的 Demo（链接或本地）
- 关键界面截图（`prototype/screenshots/`）

**截图验收规则**：
- Demo Build 完成后，必须截取关键界面截图到 `prototype/screenshots/`
- 截图方式：如 Playwright 可用且 Demo 可访问（本地 HTML 或已部署），用 Playwright 截取各状态页面
- 降级条件：Playwright 不可用、Demo 需后端 API 未启动、或 Demo 需登录态 → 保留占位符并标注原因
- 截图至少覆盖：首屏 + 各核心交互状态（如多状态页面，每个状态各截一张）
- Phase 4 交付时，prd-writer Phase 1 检查 `prototype/screenshots/` 是否有内容，有截图则嵌入 PRD 替代占位符

---

## Phase 4: 交付

**目标**：将验证后的产品整理为可交付状态。

### PRD 生成

如检测到 prd-writer skill，调用它生成 PRD；它会自动扫描项目目录下的所有材料并推断 31 维度，无需指定文件名。调用前确保以下 Phase 1-3 产出文件已写入项目目录（prd-writer 会从中提取信息）：
- `assets/requirement-assessment.md` — 需求评估（Phase 1 产出）
- `assets/research-findings.md` — 调研发现摘要（Phase 1 产出，从 pd-deep-research 决策简报提取）
- `assets/product-brief.md` — 产品简报（Phase 2 产出）
- `src/` 或项目代码 — Demo 代码（Phase 3 产出）

如未检测到 prd-writer，向用户披露"未检测到 PRD 增强 skill，将使用内置简版 PRD 流程继续，质量检查和章节裁剪会更轻量"，并基于 `assets/requirement-assessment.md`、`assets/research-findings.md`、`assets/product-brief.md`、Demo 代码生成 Markdown PRD。

### 代码整理

- 更新 README.md：补充项目说明、Demo 链接、PRD 链接
- 确保代码可独立运行

### 协同同步（可选）

同步到语雀/钉钉等平台前，必须向用户确认同步目标和内容——同步后无法撤回。

> 急用路径：不调用 prd-writer，直接基于 Demo 代码和 `requirement-assessment.md` 填充 `templates/rapid-report.md`，生成简版 PRD（1000-1500 字）。

---

## 过程产出

每个 Phase 完成后立即将产出写入项目目录，不依赖对话上下文：

| Phase | 产出文件 | 说明 |
|-------|---------|------|
| Phase 1 | `assets/requirement-assessment.md` | 7 维度需求评估 |
| Phase 1 | `assets/research-findings.md` | 调研发现摘要（从 pd-deep-research 决策简报提取，急用路径无） |
| Phase 1 | `assets/pd-deep-research/research-report.md` | 深度研究完整报告（急用路径无） |
| Phase 2 | `assets/product-brief.md` | 一页纸产品简报（急用路径无） |
| Phase 3 | `assets/design-system/MASTER.md` | 设计系统（Design 步骤产出，ui-ux-pro-max，急用路径无） |
| Phase 3 | `assets/brand-spec.md` | 品牌规范（Design 步骤产出，huashu-design，急用路径无） |
| Phase 3 | `prototype/screenshots/` | Demo 关键界面截图 |
| Phase 3 | `src/` 或项目代码目录 | Demo 代码 |
| Phase 4 | `prd/PRD_{项目名}_v1.0.md` | PRD（由 prd-writer 生成，文件名含项目名） |

迭代时新建版本（`PRD_{项目名}_v1.1.md`），不覆盖历史文件。目录按需创建，不预建空文件夹。

---

## 约束

1. **能推断就别问**：能从用户描述和项目材料中推断的信息直接推断，只追问真正缺失且必须明确的内容
2. **不生成用户不要的东西**：目录和文件按需创建，不预建空文件夹，不输出用户没要求的文档
3. **永远允许跳步骤**：用户说"跳过"就跳过，不劝阻不对抗

---

## 协作

- 需求模糊时如检测到 brainstorming skill，可调用它理清思路；未检测到时用内置追问框架继续
- Phase 1b 如检测到 pd-deep-research skill，调用它做竞品与现状调研；未检测到时用轻量内置调研流程继续，并向用户说明置信度会弱一些
- Phase 3 Build Design 步骤如检测到 ui-ux-pro-max，可调用它；扫描发现其他已安装 UI skill（huashu-design、alipay-design、frontend-design）时提示用户选择；都未检测到时使用默认样式继续
- Phase 4 如检测到 prd-writer skill，调用它生成 PRD；未检测到时使用内置简版 PRD 流程继续
- 图表生成：drawio（流程图、对比图、ER 图）、architecture-diagram（大型架构图、系统拓扑图）
- 遇到失败场景（开发失败、需求变更、部署受限）时参考 `references/failure-handling.md`
