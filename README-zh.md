[![Release](https://img.shields.io/github/v/release/RedisInsight/RedisInsight.svg?sort=semver)](https://github.com/RedisInsight/RedisInsight/releases)

# <img src="https://github.com/RedisInsight/RedisInsight/blob/main/resources/icon.png" alt="logo" width="25"/> Redis Insight - Redis 开发者 GUI 工具

[![Forum](https://img.shields.io/badge/Forum-RedisInsight-red)](https://forum.redis.com/c/redisinsight/65)
[![Discord](https://img.shields.io/discord/697882427875393627?style=flat-square)](https://discord.gg/QUkjSsk)

Redis Insight 是一个可视化工具，为您的 Redis 应用程序提供设计、开发和优化功能。
查询、分析与您的 Redis 数据进行交互。[点击此处下载](https://redis.io/insight/#insight-form)！

![Redis Insight Browser 截图](/.github/redisinsight_browser.png)

使用 [Electron](https://www.electronjs.org/)、[Monaco Editor](https://microsoft.github.io/monaco-editor/) 和 NodeJS 精心构建。

## 概述

Redis Insight 是一个直观且高效的 Redis GUI 工具，允许您与数据库交互并管理数据——内置对 Redis 模块的支持。

### Redis Insight 亮点功能：

- 浏览、过滤和可视化您的键值 Redis 数据结构，并以不同格式查看键值（包括 JSON、Hex、ASCII 等）
- 支持列表、哈希、字符串、集合、有序集合和流的 CRUD 操作
- 支持 [JSON](https://redis.io/json/) 数据结构的 CRUD 操作
- 交互式教程，轻松学习如何利用原生 JSON 数据结构支持结构化查询和全文搜索，包括 AI 用例的向量相似性搜索
- 根据您与数据库的交互，提供优化性能和内存使用的上下文相关建议
- 性能分析器 - 实时分析发送到 Redis 的每个命令
- 慢查询日志 - 基于 [Slowlog](https://github.com/RedisInsight/RedisInsight/releases#:~:text=results%20of%20the-,Slowlog,-command%20to%20analyze) 命令分析 Redis 实例中的慢操作
- 发布/订阅 - 支持 [Redis pub/sub](https://redis.io/docs/latest/develop/interact/pubsub/)，支持订阅频道和向频道发布消息
- 批量操作 - 根据浏览器或树视图中设置的过滤器批量删除键
- 工作台 - 具有智能命令自动完成、复杂数据可视化和原始模式支持的高级命令行界面
- 支持 [搜索和查询](https://redis.io/search/) 功能、[JSON](https://redis.io/json/) 和 [时间序列](https://redis.io/timeseries/) 数据结构的命令自动完成
- 可视化您的 [搜索和查询](https://redis.io/search/) 索引和结果
- 能够构建[您自己的数据可视化插件](https://github.com/RedisInsight/Packages)
- 官方支持 Redis 开源版、[Redis Cloud](https://redis.io/cloud/)。兼容 Microsoft Azure Cache for Redis

查看[发布说明](https://github.com/RedisInsight/RedisInsight/releases)。

## Redis Insight 入门

此存储库包含 Redis Insight 的代码。查看[博客文章](https://redis.com/blog/introducing-redisinsight-2/)了解详情。

### 可安装版本

Redis Insight 可在 [redis.io](https://redis.io/insight/#insight-form) 免费下载。
您还可以在 Microsoft Store、Apple App Store、Snapcraft、Flathub 和 [Docker 镜像](https://hub.docker.com/r/redis/redisinsight) 中找到它。

此外，您可以使用 [Redis for VS Code](https://github.com/RedisInsight/Redis-for-VS-Code)，我们的官方 Visual Studio Code 扩展。

### 从源代码构建

您也可以从源代码构建。请参阅我们的 wiki 获取说明。

- [如何构建](https://github.com/RedisInsight/RedisInsight/wiki/How-to-build-and-contribute)

## 如何调试

如果在 Redis Insight 中遇到任何问题，您可以按照以下步骤获取更多错误信息并找到根本原因。

- [如何调试](https://github.com/RedisInsight/RedisInsight/wiki/How-to-debug)

## Redis Insight API（仅限 Docker）

如果您正在从 [Docker](https://hub.docker.com/r/redis/redisinsight) 运行 Redis Insight，您可以从 `http://localhost:5540/api/docs` 访问 API。

## 反馈

- 请求新[功能](https://github.com/RedisInsight/RedisInsight/issues/new?assignees=&labels=&template=feature_request.md&title=%5BFeature+Request%5D%3A)
- 投票[热门功能请求](https://github.com/RedisInsight/RedisInsight/issues?q=is%3Aopen+is%3Aissue+label%3Afeature+sort%3Areactions-%2B1-desc)
- 提交[错误报告](https://github.com/RedisInsight/RedisInsight/issues/new?assignees=&labels=&template=bug_report.md&title=%5BBug%5D%3A)

## Redis Insight 插件

现在您还可以通过构建自己的数据可视化来扩展 Redis Insight 的核心功能。请参阅我们的 wiki 获取更多信息。

- [插件文档](https://github.com/RedisInsight/RedisInsight/wiki/Plugin-Documentation)

## 贡献

如果您想为代码库做贡献或修复问题，请参阅 wiki。

- [如何构建和贡献](https://github.com/RedisInsight/RedisInsight/wiki/How-to-build-and-contribute)

## API 文档

如果您使用的是 Redis Insight 的 Docker 镜像，请打开此 URL 查看 API 列表：
http://localhost:5530/api/docs

## 遥测数据

Redis Insight 包含一个可选的遥测系统，用于帮助改进应用程序内的开发者体验（DX）。我们重视您的隐私，请放心，所有收集的数据都是匿名的。

## 许可证

Redis Insight 采用 [SSPL](/LICENSE) 许可证。