# Round 0: 项目初始化

**日期**: 2026-05-02
**类型**: 初始化

## 改动

从分散的 skill 安装目录（`.claude/skills/`、`.codefuse/engine/cc/skills/`、`.codefuse/fuse/skills/`）收拢到 ai-skills 项目目录作为唯一源。

### 以 `.codefuse/engine/cc/skills/deep-research/` 为基准（最新版）

包含：
- `skill/SKILL.md` — 含 Phase 4 速读总结格式、写作风格指导、模板文件引用
- `skill/templates/` — 4 个阶段模板（01-anchor-discovery, 02-deep-read-batch, 05-cross-validation, 06-synthesis）
- `skill/cases/碰一下小助理/` — 完整案例（5 个文件）

### 新增项目文件

- `CLAUDE.md` — 项目开发指令
- `publish.sh` — 三目录同步脚本
- `iterations/round-0.md` — 本文件

## 原因

三目录不同步问题：`.codefuse/engine/cc/` 有最新版（含 templates/、更新后的 SKILL.md 和 cases），但 `.claude/` 和 `.codefuse/fuse/` 还停在旧版。将项目源码放到 ai-skills 仓库，通过 publish.sh 统一发布，避免再出现此问题。

## 历史版本差异

| 内容 | .claude（旧） | .codefuse/engine/cc（新） | .codefuse/fuse（旧） |
|------|:---:|:---:|:---:|
| SKILL.md 速读总结格式 | ❌ | ✅ | ❌ |
| SKILL.md 写作风格指导 | ❌ | ✅ | ❌ |
| SKILL.md 模板文件说明 | ❌ | ✅ | ❌ |
| templates/ 目录 | ❌ | ✅ | ❌ |
| cases 更新 | 部分旧 | 最新 | 部分旧 |