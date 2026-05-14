# Round 4 迭代记录

**日期**：2026-05-11
**范围**：Phase 3 Build UI Skill 联动——设计先行再编码

---

## 改动动机

Phase 3 Build 写代码时，虽然用户安装了 ui-ux-pro-max、huashu-design、alipay-design 等 UI skill，但当前只是"扫描 → 推荐 → 注入约束"（注入机制未定义），实际写代码时这些 skill 从未被调用。用户确认要"设计先行再编码"：Phase 3 Build 前先调用 UI skill 生成设计系统/规范，再基于规范写代码。

## 改动清单

### 1. SKILL.md Phase 3 Build 重写

**之前**：扫描已安装 skill → 推荐 → 注入约束（无实际调用机制）

**之后**：Build = Design → Code 两步

- **Design 步骤**：根据项目上下文调用 UI skill 生成设计产出
  - 用户明确要求做支付宝产品 → 调用 alipay-design（替代 ui-ux-pro-max）
  - 其他所有项目 → 调用 ui-ux-pro-max + huashu-design
  - 设计产出写入 `assets/design-system/MASTER.md` 和 `assets/brand-spec.md`
- **Code 步骤**：基于 Design 步骤的设计产出写 Demo 代码
- 急用路径跳过 Design 步骤，直接 Code

### 2. SKILL.md 协作部分更新

- 新增 Phase 3 Build Design 步骤调用 UI skill 的说明
- 明确触发条件：alipay-design 仅用户明确要求时，默认走 ui-ux-pro-max + huashu-design

### 3. SKILL.md 产出文件表新增

- `assets/design-system/MASTER.md` — 设计系统（Design 步骤产出，ui-ux-pro-max，急用路径无）
- `assets/brand-spec.md` — 品牌规范（Design 步骤产出，huashu-design，急用路径无）

### 4. failure-handling.md 场景 1 更新

- 之前："如有设计类 skill 可用，生成高保真原型图替代"
- 之后：Design 步骤已产出设计规范，Code 失败时降级为基于设计产出生成静态原型

## 设计决策

| 决策 | 选择 | 理由 |
|------|------|------|
| alipay-design 触发条件 | 仅用户明确要求做支付宝产品 | 用户明确原则："只有当我要求做一个支付宝的产品时，才用 alipay-design" |
| 默认 UI skill | ui-ux-pro-max + huashu-design | ui-ux-pro-max 定设计规范，huashu-design 做视觉落地，两者配合 |
| 急用路径 | 跳过 Design 步骤 | 时间紧，设计先行会拖慢 |
| 不联动 frontend-design | 不调用 | 用户未选择 |

## 验证

- SKILL.md Phase 3 Build 有 Design 和 Code 两步 ✅
- UI skill 触发条件正确 ✅
- 产出文件表包含 `assets/design-system/` 和 `assets/brand-spec.md` ✅
- 急用路径明确跳过 Design 步骤 ✅
- publish.sh 同步到 3 个安装目录 ✅
- QA subagent 验证通过 ✅