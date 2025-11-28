# 提交信息生成

生成简洁且有意义的提交信息，遵循 RedisInsight 的约定。

## 格式

```
<type>(<scope>): <description>

[optional body]

References: #RI-XXX
```

## 类型与范围

**类型**：`feat`、`fix`、`refactor`、`test`、`docs`、`chore`、`perf`、`ci`

**范围**：`api`、`ui`、`e2e`、`deps`

## 规则

**应该：**
- ✅ 始终包含范围：`feat(api):`、`fix(ui):`
- ✅ 使用祈使语气：使用 "add feature" 而不是 "added feature"
- ✅ 范围后正文首字母小写
- ✅ 主题不超过 250 字符
- ✅ 在生成前检查所有未提交文件

**不应该：**
- ❌ 省略范围
- ❌ 使用过去时
- ❌ 以句号结尾
- ❌ 使用多个范围（请拆分为独立提交）

## 示例

```bash
feat(ui): add user profile editing
fix(api): resolve memory leak in connection pool
refactor(api): extract validation logic
test(e2e): add authentication tests
chore(deps): upgrade React to 18.2
```

## 问题引用

**JIRA**：`References: #RI-123` 或 `Fixes #RI-123`
**GitHub**：`Fixes #123` 或 `Closes #123`

## 流程

1. 运行 `git status && git diff`
2. 确定范围：API → `api`，UI → `ui`，若两者均涉及 → 请拆分为独立提交
3. 确定类型：新增 → `feat`，缺陷 → `fix`，改进 → `refactor`
4. 撰写描述（更改了什么以及为何）
5. 在正文中添加问题引用

## 多个范围

拆分为多个提交：

```bash
# ✅ Good
git commit -m "feat(api): add user endpoint

References: #RI-123"

git commit -m "feat(ui): add user interface

References: #RI-123"

# ❌ Bad
git commit -m "feat(api,ui): add user feature"
```

## 输出格式

以可复制格式呈现：

```markdown
基于这些变更，这是你的提交信息：

\`\`\`
feat(api): add OAuth 2.0 authentication

Implements OAuth flow with token management
and refresh token support.

References: #RI-123
\`\`\`
```

如果涉及多个范围：

```markdown
变更涉及多个范围。我建议拆分为两个提交：

**提交 1：**
\`\`\`
feat(api): add OAuth endpoints

References: #RI-123
\`\`\`

**提交 2：**
\`\`\`
feat(ui): add OAuth login interface

References: #RI-123
\`\`\`
```
