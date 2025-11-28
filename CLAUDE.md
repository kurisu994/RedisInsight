# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

**RedisInsight** 是一个用 Electron 构建的 Redis 数据库管理桌面应用程序，支持可视化 Redis 数据管理、性能监控和开发工具。

- **前端**: React 18, TypeScript, Redux Toolkit, Elastic UI, Monaco Editor, Vite
- **后端**: NestJS, TypeScript, Node.js
- **桌面**: Electron 跨平台分发
- **测试**: Jest, Testing Library, Playwright

## 常用开发命令

### 开发环境启动
```bash
# 启动前端开发服务器 (UI only)
yarn dev:ui

# 启动API开发服务器 (API only)
yarn dev:api

# 启动桌面应用 (包含UI和API)
yarn dev:desktop

# 分别启动桌面应用组件
yarn dev:electron:ui    # Electron中的UI
yarn dev:electron:api   # Electron中的API
yarn dev:electron       # Electron主进程
```

### 构建命令
```bash
# 构建前端生产版本
yarn build:ui

# 构建API生产版本
yarn build:api

# 构建桌面应用生产版本
yarn build:prod

# 构建开发版本
yarn build

# 构建预发布版本
yarn build:stage
```

### 测试命令
```bash
# 运行UI测试
yarn test

# 运行API测试
yarn test:api

# 运行API集成测试
yarn test:api:integration

# 运行测试覆盖率
yarn test:cov

# 监视模式运行测试
yarn test:watch
```

### 代码质量检查
```bash
# 运行ESLint
yarn lint

# 前端代码检查
yarn lint:ui

# API代码检查
yarn lint:api

# 桌面应用代码检查
yarn lint:desktop

# TypeScript类型检查
yarn type-check:ui
```

### 打包发布
```bash
# 开发版本打包
yarn package:dev

# 生产版本打包
yarn package:prod

# 平台特定打包
yarn package:win
yarn package:mac
yarn package:linux
```

## 项目架构

### 目录结构
```
redisinsight/
├── ui/          # React前端应用 (Vite + TypeScript)
├── api/         # NestJS后端 (TypeScript)
├── desktop/     # Electron主进程代码
├── tests/       # E2E测试 (Playwright)
├── configs/      # Webpack配置文件
└── .ai/         # AI开发规则和标准
```

### 模块别名
- `uiSrc/*` → `redisinsight/ui/src/*`
- `apiSrc/*` → `redisinsight/api/src/*`
- `desktopSrc/*` → `redisinsight/desktop/src/*`

### 前端架构 (ui/)
- **框架**: React 18 + TypeScript + Redux Toolkit
- **路由**: React Router v5
- **UI组件**: Elastic UI (通过 @redis-ui/components 包装器)
- **样式**: styled-components (SCSS已弃用)
- **编辑器**: Monaco Editor 用于CLI和脚本编辑
- **构建工具**: Vite
- **数据可视化**: D3.js, React Virtualized

### 后端架构 (api/)
- **框架**: NestJS + TypeScript
- **数据库**: TypeORM + SQLite
- **认证**: JWT + 自定义认证策略
- **文档**: Swagger OpenAPI
- **测试**: Jest + 超时测试工具
- **Redis客户端**: ioredis

### 桌面应用架构 (desktop/)
- **框架**: Electron + TypeScript
- **主进程**: 窗口管理、菜单、系统托盘
- **自动更新**: electron-updater
- **进程间通信**: IPC handlers
- **打包**: electron-builder

## 核心功能模块

### 数据库管理
- 连接管理 (单机、集群、哨兵、云数据库)
- SSL/TLS 支持
- SSH隧道连接
- 数据库配置和设置

### 数据浏览与操作
- Browser视图: 键值对树形浏览
- Tree视图: 结构化数据展示
- 支持所有Redis数据类型 (String, Hash, List, Set, Sorted Set, Stream, JSON)
- 批量操作 (删除、导出)

### 开发工具
- Workbench: CLI命令行界面，支持智能自动完成
- 查询结果可视化
- JSON数据结构支持和查询
- 原生模块支持 (RediSearch, RedisJSON, RedisTimeSeries, RedisBloom等)

### 性能分析
- Profiler: 实时命令分析
- SlowLog: 慢操作分析
- 内存使用分析
- 性能优化建议

### 高级功能
- Pub/Sub 支持
- AI聊天和分析功能
- 自定义可视化插件系统
- 数据导入导出

## 开发规范

### 代码质量标准
所有开发规则和指南都集中在 `.ai/` 目录中，作为单一真实来源：

- **代码质量**: `.ai/rules/code-quality.md` (ESLint, TypeScript, 导入组织)
- **前端开发**: `.ai/rules/frontend.md` (React模式, Redux, 组件结构)
- **后端开发**: `.ai/rules/backend.md` (NestJS模式, 服务层, DTOs)
- **测试标准**: `.ai/rules/testing.md` (Jest, Testing Library, Playwright)

### Git工作流
- **分支命名**: `.ai/rules/branches.md` (type/RI-XXX/title 或 type/XXX/title)
- **提交信息**: `.ai/rules/commits.md` (Conventional Commits格式)
- **PR流程**: `.ai/rules/pull-requests.md` (代码审查和检查清单)

### MCP集成
项目配置了Model Context Protocol，支持AI工具访问外部服务：
- GitHub集成 (issues, PRs, 仓库操作)
- Atlassian集成 (JIRA, Confluence)
- 内存上下文存储
- 增强推理功能

## 特殊注意事项

### 前端开发
- 不要直接从 @redis-ui 导入，使用内部包装器组件
- Elastic UI正在被Redis UI组件替换
- 使用 Redux Toolkit 进行状态管理
- 组件测试使用 renderComponent 辅助函数

### 后端开发
- 使用NestJS模块化架构
- 所有API端点需要适当的文档和验证
- 使用装饰器进行数据转换和验证
- 错误处理需要适当的异常类型

### 测试
- 组件测试优先使用Testing Library
- 后端测试使用Jest和适当的模拟
- E2E测试使用Playwright
- 避免固定超时，使用waitFor模式

### 构建和部署
- 前端使用Vite进行快速开发和构建
- 生产构建需要适当的优化和压缩
- 支持多平台打包 (Windows, macOS, Linux)
- Docker容器化部署支持