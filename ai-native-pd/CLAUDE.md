# ai-native-pd 项目开发指令

## 项目结构

- `skill/` 是 skill 工作目录，可以随意修改试验
- 定稿后运行 `bash publish.sh` 发布到已知 Agent CLI skills 安装目录，或用 `bash publish.sh codex|claude|custom <path>` 指定目标
- `iterations/` 记录每轮迭代的改动和决策
- `outputs/` 存放测试产出物

## 迭代规范

- 每轮迭代新建 `iterations/round-N.md`，记录：改了什么、为什么改、基于什么反馈
- 测试产出物存到 `outputs/{test-name}/`，不覆盖历史版本
- 改完 SKILL.md 后需要验证核心流程

## 与 prd-writer 的分工

- **ai-native-pd**：从模糊想法到可运行 Demo 再到 PRD 的全流程（"先做东西，再写文档"）
- **prd-writer**：已有原型/Demo/方案文档后，反向生成结构化 PRD（专注文档质量）
- ai-native-pd 的 Step 5 可调用 prd-writer 补充 PRD 细节
