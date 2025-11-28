---
alwaysApply: true
---

# 提交信息指南

遵循 **Conventional Commits** 格式：

```
<type>(<scope>): <subject>

<body>

<footer>
```

## 提交类型

- `feat` —— 新特性
- `fix` —— 缺陷修复
- `refactor` —— 代码重构
- `test` —— 添加或更新测试
- `docs` —— 文档变更
- `chore` —— 维护任务
- `style` —— 代码风格变更（格式化）
- `perf` —— 性能优化
- `ci` —— CI/CD 变更

## 示例

```bash
feat(ui): add user search functionality

Implements real-time search with debouncing.

References: #RI-123

---

fix(api): resolve memory leak in connection pool

Properly cleanup subscriptions on unmount.

Fixes #456

---

test(ui): add tests for data serialization

refactor(api): extract common validation logic

docs: update API endpoint documentation

chore: upgrade React to version 18.2
```

## 最佳实践

### ✅ 良好提交

- 主题行清晰且具描述性
- 原子性变更（每次提交仅包含一个逻辑变更）
- 在正文中引用问题/工单
- 解释**为什么**，而不仅是**做了什么**

```bash
feat(ui): add user profile editing

Allows users to update their profile information including
name, email, and avatar. Includes validation and error handling.

References: #RI-123
```

### ❌ 不良提交

```bash
# 过于含糊
fix stuff
WIP
update

# 过于宽泛
add feature, fix bugs, refactor code, update tests
```

## 问题引用

- **JIRA（内部）**：`References: #RI-123` 或 `Fixes #RI-123`
- **GitHub（开源）**：`Fixes #456` 或 `Closes #456`
- 在提交信息中使用 `#` 进行自动链接
