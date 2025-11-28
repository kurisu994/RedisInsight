---
alwaysApply: true
---

# 分支命名约定

使用小写的 kebab-case，带类型前缀与问题/工单标识。**分支名称必须符合 GitHub Actions 工作流规则**（参见 `.github/workflows/enforce-branch-name-rules.yml`）。

```bash
# 模式：<type>/<issue-ref>/<short-title>

# 内部（JIRA - RI-XXX）
feature/RI-123/add-user-profile
bugfix/RI-789/memory-leak
fe/feature/RI-567/add-dark-mode
be/bugfix/RI-345/fix-redis-connection
docs/RI-333/update-docs
test/RI-444/add-unit-tests
e2e/RI-555/add-integration-tests

# 开源（GitHub - XXX）
feature/123/add-export-feature
bugfix/789/fix-connection-timeout

# 特殊分支
release/v2.0.0
ric/RI-666/custom-prefix
```

## 允许的分支类型（由 GitHub Actions 强制）

- `feature/` —— 新特性与重构
- `bugfix/` —— 缺陷修复
- `fe/feature/` —— 仅前端特性
- `fe/bugfix/` —— 仅前端缺陷修复
- `be/feature/` —— 仅后端特性
- `be/bugfix/` —— 仅后端缺陷修复
- `docs/` —— 文档变更
- `test/` —— 与测试相关的变更
- `e2e/` —— 端到端测试变更
- `release/` —— 发布分支
- `ric/` —— 特殊场景的自定义前缀

## 问题引用

- **内部**：`RI-XXX`（JIRA 工单）
- **开源**：`XXX`（GitHub Issue 编号）
- `#` 仅用于提交信息，不用于分支名
