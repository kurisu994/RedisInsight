# RedisInsight AI 开发规则

此目录是 RedisInsight 中用于 AI 辅助开发规则与工作流的单一可信来源（Single Source of Truth）。这些规则被以下多款 AI 编码助手使用：

- **Cursor**（通过符号链接：`.cursor/rules/` 与 `.cursor/commands/`）
- **Augment**（通过符号链接：`.augment/`）
- **Windsurf**（通过符号链接：`.windsurfrules`）
- **GitHub Copilot**（通过文件：`.github/copilot-instructions.md`）

## MCP（模型上下文协议）设置

AI 工具可以通过 MCP 配置访问外部服务（JIRA、Confluence、GitHub）。

### 初始设置

1. 复制示例配置：

   ```bash
   cp env.mcp.example .env.mcp
   ```

2. 获取 Atlassian API Token：

   - 访问：https://id.atlassian.com/manage-profile/security/api-tokens
   - 点击第一个“Create Token”按钮创建经典令牌（Classic Token）
   - 复制生成的令牌

3. 用你的凭据编辑 `.env.mcp`

4. 验证配置：

   **针对 Cursor 用户：**

   - 重启 Cursor 以加载新的 MCP 配置
   - 向 AI 提问：“Can you list all available MCP tools and test them?”
   - AI 应该能够访问 JIRA、Confluence、GitHub 以及其他已配置的服务

   **针对 Augment 用户：**

   ```bash
   npx @augmentcode/auggie --mcp-config mcp.json "go over all my mcp tools and make sure they work as expected"
   ```

   **针对 GitHub Copilot 用户：**

   - 注意：GitHub Copilot 当前不支持 MCP 集成
   - 在 Copilot 中不会提供 MCP 服务（JIRA、Confluence 等）

### 可用的 MCP 服务

`mcp.json` 文件配置了以下服务：

- **github** —— GitHub 集成（问题、PR、仓库操作）
- **memory** —— 跨会话的持久化上下文存储
- **sequential-thinking** —— 面向复杂任务的增强推理能力
- **context-7** —— 高级上下文管理
- **atlassian** —— JIRA（RI-XXX 工单）与 Confluence 集成

## 目录结构

```
.ai/                                  # 🎯 单一可信来源
├── README.md                         # 概览与快速参考
├── rules/                            # 开发规范（模块化）
│   ├── code-quality.md               # Lint 与 TypeScript 规范
│   ├── frontend.md                   # React、Redux、UI 模式
│   ├── backend.md                    # NestJS、API 模式
│   ├── testing.md                    # 测试规范
│   ├── branches.md                   # 分支命名约定
│   ├── commits.md                    # 提交信息指南
│   └── pull-requests.md              # Pull Request 流程
└── commands/                         # AI 工作流命令
    ├── commit-message.md             # 提交信息生成
    └── pull-request-review.md        # PR 评审工作流

# 符号链接（所有 AI 工具均从 .ai/ 读取）
.cursor/
  ├── rules/ -> ../.ai/rules/         # Cursor AI（规则）
  └── commands/ -> ../.ai/commands/   # Cursor AI（命令）
.augment/ -> .ai/                     # Augment AI
.windsurfrules -> .ai/                # Windsurf AI
.github/copilot-instructions.md       # GitHub Copilot
```

## 项目概览

**RedisInsight** 是一个用于 Redis 数据库管理的桌面应用，构建于：

- **前端**：React 18、TypeScript、Redux Toolkit、Elastic UI、Monaco Editor、Vite
- **后端**：NestJS、TypeScript、Node.js
- **桌面**：Electron 跨平台发行
- **测试**：Jest、Testing Library、Playwright

**架构：**

```
redisinsight/
├── ui/          # React 前端（Vite + TypeScript）
├── api/         # NestJS 后端（TypeScript）
├── desktop/     # Electron 主进程
└── tests/       # 端到端测试（Playwright）
```

## 详细指南

所有详细的开发标准、编码实践与工作流均以模块化文件维护：

- **代码质量标准**：参见 `.ai/rules/code-quality.md`
- **前端模式**：参见 `.ai/rules/frontend.md`
- **后端模式**：参见 `.ai/rules/backend.md`
- **测试规范**：参见 `.ai/rules/testing.md`
- **分支命名**：参见 `.ai/rules/branches.md`
- **提交信息**：参见 `.ai/rules/commits.md`
- **Pull Request 流程**：参见 `.ai/rules/pull-requests.md`

## 更新这些规则

更新 AI 规则：

1. 仅编辑 `.ai/` 下的文件（请勿直接编辑符号链接所在的文件）
2. 变更会自动传播到所有 AI 工具
3. 将变更提交到版本控制

**请记住**：这些规则用于维护代码质量与一致性。遵循它们，同时结合良好的判断。
