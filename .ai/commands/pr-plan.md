---
description: 分析 JIRA 工单并创建详细的实现计划
argument-hint: <ticket-id 或 ticket-url>
---

为 JIRA 工单创建一份全面的实现计划。

## 1. 获取 JIRA 工单

**如果未将工单 ID 作为参数提供，请提示用户提供。**

获取该工单的所有信息、评论、关联文档以及父工单。

使用 `jira` 工具获取工单详情。

## 4. 创建实现计划

使用 `sequential-thinking` 工具进行复杂分析。将问题拆解为思考步骤：

### 思考 1-5：需求分析

- 将验收标准解析为具体任务
- 识别功能性需求
- 识别非功能性需求（性能、安全、成本）
- 将需求映射到系统组件
- 识别依赖与阻塞项

### 思考 6-10：架构规划

- 判定受影响的服务
- 识别需要新增的组件
- 识别需要修改的现有组件
- 规划数据流与交互
- 考虑错误处理与边界情况

### 思考 16-20：实现拆分

- 将工作拆分为逻辑阶段
- 识别阶段之间的依赖
- 为每个阶段考虑测试策略
- 规划增量交付

### 思考 21-25：测试策略

- 从验收标准中提取测试场景
- 规划单元测试（基于行为，而非实现）
- 规划集成测试
- 考虑边界与错误场景
- 规划测试数据需求

### 思考 26-30：风险评估

- 识别技术风险
- 识别集成风险
- 识别时间线风险
- 识别知识缺口
- 制定缓解策略

## 5. 生成实现计划文档

**重要：必须创建并保存计划文档。这不是可选项。**

创建一份完整的 Markdown 文档，并使用 `write` 工具保存到 `docs/pr-plan-{ticket-id}-{brief-description}.md`。

**文档结构必须包含下列所有部分：**

```markdown
# 实施计划：[工单标题]

**JIRA 工单：** [MOD-XXXXX](https://redislabs.atlassian.net/browse/MOD-XXXXX)
**史诗：** [EPIC-XXX](link)（如适用）
**父项：** [PARENT-XXX](link)（如适用）
**计划日期：** [Date]
**规划者：** Augment Agent

---

## 摘要

**受影响的组件：**

- [component name]

**关键风险：**

1. [Risk with mitigation]
2. [Risk with mitigation]
3. [Risk with mitigation]

---

## 1. 需求摘要

**故事（为什么）：**
[Quote or summarize the story from the ticket]

**验收标准（做什么）：**

1. [AC1]
2. [AC2]
3. [AC3]

**功能性需求：**

- [Requirement 1]
- [Requirement 2]

**非功能性需求：**

- [NFR 1 - e.g., Performance: <100ms response time]
- [NFR 2 - e.g., Security: Requires authentication]

**提供的资源：**

- [Link 1: Description]
- [Link 2: Description]

## 2. 现状分析

### 前端变更

**需要修改的组件：**

- [Component 1]: [What changes are needed]
- [Component 2]: [What changes are needed]

**需要创建的组件：**

- [Component 1]: [Why it's needed]
- [Component 2]: [Why it's needed]

**可复用的组件：**

- [Component 1]: [How it will be used]
- [Component 2]: [How it will be used]

### 后端变更

**需要修改的服务：**

- [Service 1]: [What changes are needed]
- [Service 2]: [What changes are needed]

**需要创建的服务：**

- [Service 1]: [Why it's needed]
- [Service 2]: [Why it's needed]

**需要修改的 API：**

- [API 1]: [What's changing]
- [API 2]: [What's changing]

**需要创建的 API：**

- [API 1]: [Why it's needed]
- [API 2]: [Why it's needed]

**数据模型：**

- [Model 1]: [Description and whether it needs extension]
- [Model 2]: [Description and whether it needs extension]

**仓库（Repository）：**

- [Repo 1]: [Description and whether it can be reused]

---

## 3. 实现计划

### 阶段 1：[阶段名称]

**目标：** [该阶段达成的目标]

**任务：**

1. [ ] [Task 1 - specific, actionable]
   - 文件：[需要创建/修改的文件列表]
   - 验收：[如何验证此任务完成]
2. [ ] [Task 2]
   - Files: [List of files]
   - Acceptance: [Verification criteria]

**交付物：**

- [Deliverable 1]
- [Deliverable 2]

**测试：**

- [Test scenario 1]
- [Test scenario 2]

### 阶段 2：[阶段名称]

[结构同阶段 1]

### 阶段 3：[阶段名称]

[结构同阶段 1]

---

## 5. 测试策略

### 来自验收标准的测试场景

**AC1：[验收标准]**

- 测试场景：[Given-When-Then]
- 测试类型：Unit/Integration
- 测试位置：[文件路径]

**AC2：[验收标准]**

- 测试场景：[Given-When-Then]
- 测试类型：Unit/Integration
- 测试位置：[文件路径]

### 边界与错误场景

1. **[Edge Case 1]**

   - 场景：[描述]
   - 期望行为：[应该发生什么]
   - 测试：[如何测试]

2. **[Error Scenario 1]**
   - 场景：[描述]
   - 期望错误：[错误类型/代码]
   - 测试：[如何测试]

### 测试数据需求

- [Test data 1]: [Description]
- [Test data 2]: [Description]

---

## 6. 风险评估与缓解

### 技术风险

| 风险     | 可能性          | 影响            | 缓解措施               |
| -------- | --------------- | --------------- | --------------------- |
| [风险 1] | 高/中/低        | 高/中/低        | [缓解策略]            |
| [风险 2] | 高/中/低        | 高/中/低        | [缓解策略]            |

### 集成风险

| 风险     | 可能性          | 影响            | 缓解措施               |
| -------- | --------------- | --------------- | --------------------- |
| [风险 1] | 高/中/低        | 高/中/低        | [缓解策略]            |

### 时间线风险

| 风险     | 可能性          | 影响            | 缓解措施               |
| -------- | --------------- | --------------- | --------------------- |
| [风险 1] | 高/中/低        | 高/中/低        | [缓解策略]            |

### 知识缺口

- [缺口 1]：[我们未知的内容以及如何获取]
- [缺口 2]：[我们未知的内容以及如何获取]
```

---

## 6. 保存计划文档

**重要：必须使用 `write` 工具保存计划文档。**

1. **生成完整的计划文档**（遵循第 5 节的结构）
2. **保存到** `docs/pr-plan-{ticket-id}-{brief-description}.md`（使用 `write` 工具）
3. **验证文件已创建**（确认写入工具成功）

**示例文件名：** `docs/pr-plan-MOD-11280-dp-services-clean-architecture.md`

---

## 7. 后续动作

保存计划文档后：

1. **确认文档已保存** —— 将文件路径展示给用户
2. **为用户总结关键结论**：
   - 关键风险
   - 推荐方案
   - **确认计划文档已保存**（文件路径）
3. **询问用户是否需要：**
   - 查看计划文档
   - 进入实现阶段

---

## 注意事项

- **始终保存计划文档** —— 使用 `write` 工具保存到 `docs/pr-plan-{ticket-id}-{brief-description}.md`
- **以 main 分支为基线** —— 所有分析应基于当前 main
- **具体且可执行** —— 每项任务需清晰且可验证
- **考虑 PR 堆叠** —— 规划小而易评审的 PR（参见 `.ai/rules/pull-requests.md`），将实现拆分为一组 PR
- **遵循项目所有标准** —— 参考 `.ai/rules/` 中的规则
- **记录假设** —— 如有不明确之处，记录所做的假设
- **尽早识别阻塞** —— 提前暴露依赖与知识缺口

## 执行顺序摘要

**正确的操作顺序为：**

1. ✅ 获取 JIRA 工单
2. ✅ 分析当前代码库状态
3. ✅ 使用 sequential-thinking 创建实现计划
4. ✅ 生成实现计划文档内容
5. ✅ **将计划文档保存到 `docs/pr-plan-{ticket-id}-{brief-description}.md`**（重要——使用 write 工具）
6. ✅ 向用户展示结果并确认文档位置

**不要跳过第 5 步——这是强制要求，且必须在命令执行期间完成。**

**第 5 步为强制要求：** 必须使用 `write` 工具保存计划文档。不要只向用户展示计划而不保存。
