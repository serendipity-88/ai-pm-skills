# Round 1 测试迭代记录

## 日期
2026/04/17

## 目标
为 ai-native-pd Round 1 迭代（漏斗+循环 4 Phase 结构）创建完整的测试框架和测试用例。

## 已完成工作

### 1. 测试任务拆分

创建并完成了 7 个测试任务：

| 任务ID | 任务 | 产出 |
|--------|------|------|
| #30 | 创建 failure-handling.md | 验证文件已存在且内容完整 |
| #32 | 测试 Phase 1 发现阶段 | TEST-REPORT-Phase1.md |
| #29 | 测试三档分流机制 | TEST-REPORT-Shunt.md |
| #28 | 测试 Phase 2 定义阶段 | TEST-REPORT-Phase2.md |
| #31 | 测试 Phase 3 验证阶段 | TEST-REPORT-Phase3.md |
| #27 | 测试 Phase 4 交付阶段 | TEST-REPORT-Phase4.md |
| #26 | 测试断点续跑机制 | TEST-REPORT-Resume.md |

### 2. 测试报告结构

每个测试报告包含：
- 测试信息（目标、前置条件、状态）
- 验证检查清单（详细测试项）
- 测试执行记录（待人工填写）
- 问题记录
- 测试结论

### 3. 测试覆盖

**Phase 测试**:
- Phase 1: JTBD 转化、7维度评估、竞品调研、调研摘要、HARD-GATE
- Phase 2: 场景裁剪、方案设计、范围边界、产品简报
- Phase 3: Skill 发现、Build、Iterate 微循环
- Phase 4: prd-writer 调用、代码整理、协同同步

**机制测试**:
- 三档分流：急用/正常/论证 + 分流升级
- 断点续跑：5 种状态检测场景
- 失败处理：开发失败、需求变更

## 测试目录结构

```
outputs/
├── TEST-SUMMARY.md              # 测试总览和执行指南
├── T5-phase1-test/               # Phase 1 测试
│   └── TEST-REPORT-Phase1.md
├── T6-shunt-test/                # 三档分流测试
│   └── TEST-REPORT-Shunt.md
├── T7-phase2-test/               # Phase 2 测试
│   └── TEST-REPORT-Phase2.md
├── T8-phase3-test/               # Phase 3 测试
│   └── TEST-REPORT-Phase3.md
├── T9-phase4-test/               # Phase 4 测试
│   └── TEST-REPORT-Phase4.md
└── T10-resume-test/              # 断点续跑测试
    └── TEST-REPORT-Resume.md
```

## 待人工执行

所有测试报告的状态为"待人工执行验证"，需要：

1. 按 TEST-SUMMARY.md 中的指南执行测试
2. 填写各报告中的"实际结果"列
3. 记录发现的问题
4. 更新测试结论

## 关键测试用例

### T2: 团队知识库搜索工具（正常路径）
测试输入：
```
我们团队有很多文档散落在语雀、飞书、Confluence 各处，每次找个东西要翻好几个平台，特别浪费时间。我想做一个统一的知识库搜索工具，能一个入口搜到所有平台的内容。
```

### 急用路径测试
测试输入：
```
今天要给老板演示，帮我快速做一个会议室预订的小工具，能选时间、选会议室、提交预订就行，不用太复杂。
```

## 风险与注意事项

1. **Web search 准确性**: AI 搜索竞品信息约 60-70% 可用，关键事实需人工校验
2. **prd-writer 衔接**: 需验证文件路径和材料传递是否正确
3. **HARD-GATE**: 需确认各阶段门禁是否正常触发

## 下一步

1. 执行人工测试
2. 根据测试结果修复问题
3. 修复后重新测试验证
4. 测试通过后发布 skill
