# Round 0: 原始版本存档

**日期**: 2026-04-15

## 现状

从 `~/.claude/skills/ai-native-pd/` 复制原始 skill 到项目目录，作为迭代基线。

## 当前 Skill 结构

```
skill/
├── SKILL.md              ← 主文件（~523 行）
└── templates/
    ├── prd-template.html  ← PRD HTML 模板（带版本切换器）
    ├── prd-template.md    ← PRD Markdown 模板
    ├── formal-report.md   ← 正式汇报大纲模板
    ├── rapid-report.md    ← 快速模式 1 页纸大纲
    └── requirement-assessment.md ← 需求评估表
```

## 核心流程

```
入口判断（If-Then 决策树）
  ├→ 需求模糊 → brainstorming → Step 1
  ├→ 需求清晰 → Step 1
  ├→ 只要汇报 → 汇报大纲模式（P1-P6）
  ├→ 只要 Demo → Step 3
  └→ 时间紧迫 → 快速模式

完整流程：
Step 1: 快速需求结构化（7 维度评估）
Step 2: 创建项目骨架（目录结构）
Step 3: Code → Deploy（核心：AI Coding 出 Demo）
Step 4: 视觉增强（可选）
Step 5: 反向生成 PRD
Step 6: 协同同步（可选）
→ 迭代循环
```

## 已知问题（待迭代评估）

- SKILL.md 超过 500 行，远超建议的 5,000 tokens 上限
- 汇报大纲模式占了大量篇幅，可能需要拆成独立 skill
- 多处引用外部 skill（brainstorming, frontend-design, pptx 等），依赖关系复杂
- 快速模式 vs 完整模式的切换逻辑较粗
- Step 3 的开发部分描述偏泛，缺乏具体约束
- 缺少过程产出持久化（类似 prd-writer 的 .prd-cache）
