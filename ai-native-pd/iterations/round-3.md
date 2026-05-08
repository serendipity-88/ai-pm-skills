# Round 3 迭代记录

**日期**：2026-04-20
**范围**：Round 1 计划剩余项收尾 + T11-skill-onboarding 端到端测试

---

## 一、Round 1 计划剩余项完成

### #9 断点续跑补充

**改动**：入口项目状态检测表增加一行

| 检测到 | 说明 | 行动 |
|--------|------|------|
| `README.md` 中有 Demo/Vercel 链接 | Phase 3 含部署已完成 | "检测到已有部署的 Demo，要继续迭代还是进入交付？" |

**位置**：`skill/SKILL.md` 入口→项目状态检测表，第 3 行

**原因**：原检测表只检查代码文件+product-brief 的组合，遗漏了"代码已部署（README 中有链接）但无 product-brief"的情况。新增检测信号覆盖此场景。

### #12 prd-writer 适配

**状态**：已在之前会话中完成，本轮确认无需额外改动。

4 处改动均已存在于 `prd-writer/skill/SKILL.md`：
1. Phase 1 代码源降级规则（L44-47）✅
2. 触发前判断（L22）✅
3. 定位互相指路（L15）✅
4. Phase 4 写作视角约束（L204）✅

### #11 适用边界声明 + 互相指路

**状态**：ai-native-pd 侧已有适用边界（SKILL.md 第 10 行），prd-writer 侧互相指路已包含在 #12 中。完成。

### #13 failure-handling 拆出

**状态**：当前 SKILL.md 末尾已是引用方式（"遇到失败场景时参考 `references/failure-handling.md`"），无内联内容需要拆出。无需改动。

---

## 二、T11-skill-onboarding 端到端测试

使用 ai-native-pd 的完整 4 Phase 流程，以"Skill 首次激活引导"为真实业务案例进行测试。

### Phase 1 发现 ✅
- 1a 问题定义：JTBD 转化、需求分类（痛点）、7 维度评估
- 1b 竞品调研：7 个竞品（VS Code Copilot、Antigravity、Just-in-Time Skills、Windsurf、Raycast、Cursor、Aider），含 UX 流程、设计取舍、切换成本
- 1c 调研摘要：用户确认方向后进入 Phase 2

### Phase 2 定义 ✅
- 产品简报：3 个核心场景、核心机制、范围边界、假设验证计划
- HARD-GATE 通过

### Phase 3 验证 ✅
- Demo 产出：
  - `src/SKILL.md`（~395 行完整 skill-guide）
  - `src/skill-index.sh`（POSIX sh 兼容的索引构建脚本）
  - `src/quick-start-examples.md`（14 个 skill 的示例库）
- 用户反馈"要更细化"后大幅扩展

### Phase 4 交付 ✅
- prd-writer 5 Phase 全流程走通：
  - Phase 1：31 维度推断（完整模式 A+B）
  - Phase 2：成功指标 + 必问项确认
  - Phase 3：框架裁剪确认
  - Phase 4：完整 PRD 写入
  - Phase 5：质量检查 15 PASS / 5 FAIL / 2 WARN，5 个 FAIL 全部修复

### PRD 产出物

| 文件 | 说明 |
|------|------|
| `prd/PRD_Skill首次激活引导_v1.0.md` | 最终 PRD |
| `prd/.prd-cache/v1.0/dimensions.yaml` | 31 维度推断 |
| `prd/.prd-cache/v1.0/phase1-summary.md` | Phase 1 摘要 |
| `prd/.prd-cache/v1.0/phase3-framework.md` | Phase 3 框架 |
| `prd/.prd-cache/v1.0/phase5-review.md` | Phase 5 质量检查报告 |

### Phase 5 修复清单

| 优先级 | 问题 | 修复 |
|--------|------|------|
| P0 | 评分逻辑矛盾（专业性子项是取最高还是叠加） | 明确"取最高项得分，不叠加" |
| P1 | 动态内容占位符 `{}` 应为 `#{}` | 6 处全部修正 |
| P1 | "大量用户"模糊量词 | 改为"超半数用户（数据来源待补充）" |
| P1 | 3 个分析指标缺公式定义 | 补充公式 |
| P1 | 交互 5 要素缺失 | 补充被动/主动推荐默认状态、取消、降级；首次引导取消 |
| P2 | 目标值未用 X%→Y% 格式 | 增加（+15pt） |
| P2 | "显著更好"空洞修饰 | 改为带评分阈值的表述 |
| P2 | 频次控制参数缺可配标注 | 加"待确认是否可配" |
| P2 | 表格占比略低 | 三层匹配和不推荐情况转为表格 |

---

## 三、Round 1 计划完成状态

| # | 改造点 | 状态 |
|---|--------|------|
| 1 | 骨架重写 | ✅ Round 1 |
| 2 | Phase 1 发现阶段 | ✅ Round 1 |
| 3 | 删汇报模式 | ✅ Round 1 |
| 4 | 三档分流 | ✅ Round 1 |
| 5 | Phase 3 插件式 skill 发现 | ✅ Round 1 |
| 6 | 委托 prd-writer | ✅ Round 1 |
| 7 | FIRE Iterate 升级 | ✅ Round 1 |
| 8 | HARD-GATE 补齐 | ✅ Round 1 |
| 9 | 断点续跑 | ✅ Round 3（补充 README 检测行） |
| 10 | 过程产出持久化 | ✅ Round 1 |
| 11 | 适用边界声明 + 互相指路 | ✅ Round 1 + Round 3 确认 |
| 12 | prd-writer 适配 | ✅ 之前会话 + Round 3 确认 |
| 13 | failure-handling 拆出 | ✅ 已是引用方式，无需改动 |
| 14 | PM 警戒线 | ✅ Round 1 |

**Round 1 全部 14 项改造完成。**