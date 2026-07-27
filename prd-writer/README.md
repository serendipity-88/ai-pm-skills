# prd-writer skill

基于项目已有材料（方案文档、Demo 代码、设计规范）反向生成结构化 PRD 的 Agent CLI skill。

## 项目定位

这不仅是一个可安装的 skill，也是一个完整的 **skill 创建方法论案例**：从痛点发现 → 素材收集 → SOP 提炼 → skill 创建 → 输出验证 → 迭代优化。

## 目录结构

```
prd-writer/
├── skill/              # Skill 安装产物（SKILL.md + 风格指南）
├── origins/            # 痛点与动机
├── materials/          # 素材：真实 PRD 片段、培训笔记
├── iterations/         # 迭代记录：每轮验证的反馈和改动
├── tests/              # 测试项目：验证 skill 效果
└── outputs/            # 产出物存档：每次生成的 PRD
```

## 发布

项目中的 `skill/` 是工作目录，可以随意修改、试验。定稿后运行：

```bash
bash publish.sh
```

会将 `skill/` 中的文件复制到指定 Agent CLI skills 安装目录。默认覆盖 Codex / Claude Code 的已知路径，也可以用 `bash publish.sh custom /path/to/skills/prd-writer` 指定目录。

## 迭代流程

```
收集反馈 → 记录到 iterations/round-N.md
         → 修改 skill/SKILL.md
         → 用 tests/ 中的项目跑 Phase 1-4
         → 产出存到 outputs/
         → 发布到语雀收集下一轮反馈
```

## 当前版本

- Skill: v1.1（32 个推断维度、4 种描述模式、PlantUML/Mermaid/Graphviz 图表支持）
- 已完成 1 轮输出验证（NFC会员识别）
