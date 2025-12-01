# Redis Insight 安装指南（macOS）

欢迎使用 Redis Insight！本指南将帮助您在 macOS 上安装 Redis Insight。

## 系统要求

- macOS 10.15 (Catalina) 或更高版本
- **M1/M2/M3 Mac**：请下载 ARM64 版本
- **Intel Mac**：请下载 x64 版本

## 安装步骤

### 步骤 1: 下载 DMG 文件

根据您的 Mac 类型下载对应版本：

- `Redis-Insight-mac-arm64.dmg` - 适用于 M1/M2/M3 芯片的 Mac
- `Redis-Insight-mac-x64.dmg` - 适用于 Intel 芯片的 Mac

> 💡 **如何判断我的 Mac 是哪种芯片？**
>
> 点击 Apple 菜单 → "关于本机"，查看"芯片"或"处理器"信息：
>
> - 显示"Apple M1/M2/M3"：下载 ARM64 版本
> - 显示"Intel Core"：下载 x64 版本

### 步骤 2: 打开 DMG 文件

双击下载的 DMG 文件，系统会自动挂载磁盘映像。

![安装窗口示意图]

### 步骤 3: 拖拽到 Applications 文件夹

将 "Redis Insight" 图标拖拽到 "Applications" 文件夹图标上。

![拖拽示意图]

### 步骤 4: 首次打开（重要！）

⚠️ **重要提示**：由于此应用未经过 Apple 公证，首次打开时需要执行特殊步骤。

**请勿**直接双击应用，否则会显示"无法打开"的错误。

请按照以下步骤操作：

#### 方法 1：右键打开（推荐）

1. 打开 **Finder** → **应用程序** 文件夹
2. 找到 **Redis Insight**
3. **右键点击**（或按住 Control 键点击）
4. 在菜单中选择 **"打开"**
5. 在弹出的对话框中点击 **"打开"** 按钮

![右键打开示意图]

#### 方法 2：系统设置允许

如果已经尝试双击打开（并失败）：

1. 打开 **系统设置**
2. 进入 **隐私与安全性**
3. 在底部找到关于 "Redis Insight" 的提示
4. 点击 **"仍要打开"**
5. 再次尝试打开应用

![系统设置示意图]

### 步骤 5: 后续使用

✅ 完成首次打开后，以后就可以正常双击启动应用了！

## 安全说明

### 为什么会出现安全提示？

此应用未经过 Apple 公证，这是因为我们没有支付 Apple Developer 年费（$99/年）并进行代码签名。

**这并不意味着应用不安全！**

- Redis Insight 是开源项目，源代码完全公开
- 您可以在 GitHub 上查看和审查所有代码
- 数千名开发者正在使用这个应用

### 什么是 Gatekeeper？

macOS 的 Gatekeeper 功能会检查应用是否经过 Apple 公证。未经公证的应用需要用户手动确认才能打开，这是正常的安全机制。

## 卸载

如需卸载 Redis Insight：

1. 打开 **Finder** → **应用程序**
2. 找到 **Redis Insight**
3. 将其拖拽到废纸篓
4. 清空废纸篓

如需完全清除数据：

```bash
# 删除应用数据（可选）
rm -rf ~/Library/Application\ Support/Redis\ Insight
rm -rf ~/Library/Preferences/org.RedisLabs.RedisInsight-V2.plist
```

## 常见问题

### 问：应用打不开，显示"已损坏"

**答**：这通常是因为从网络下载的文件被标记了隔离属性。解决方法：

```bash
# 在终端中运行（替换为实际路径）
xattr -cr /Applications/Redis\ Insight.app
```

然后使用右键打开应用。

### 问：应用需要"辅助功能"权限

**答**：某些功能可能需要辅助功能权限。如果系统提示，请：

1. 打开 **系统设置** → **隐私与安全性** → **辅助功能**
2. 点击 + 号添加 Redis Insight
3. 勾选 Redis Insight

### 问：应用界面显示异常或崩溃

**答**：可能是版本不兼容。请确保：

- **M1/M2/M3 Mac** 使用 ARM64 版本
- **Intel Mac** 使用 x64 版本

### 问：如何检查当前使用的架构？

**答**：在终端中运行：

```bash
# 查看应用架构
lipo -info /Applications/Redis\ Insight.app/Contents/MacOS/Redis\ Insight
```

应该显示：

- ARM64 版本：`Non-fat file ... is architecture: arm64`
- x64 版本：`Non-fat file ... is architecture: x86_64`

## 获取帮助

如遇到问题或需要帮助：

- 📖 [查看完整文档](https://redis.com/redis-enterprise/redis-insight/)
- 🐛 [报告问题](https://github.com/RedisInsight/RedisInsight/issues)
- 💬 [社区讨论](https://github.com/RedisInsight/RedisInsight/discussions)

## 开始使用

安装完成后，打开 Redis Insight 即可开始使用！

首次启动时：

1. 应用会提示添加 Redis 数据库连接
2. 输入您的 Redis 服务器地址和端口
3. 点击"测试连接"确认可以连接
4. 开始探索 Redis Insight 的强大功能！

---

**祝您使用愉快！** 🚀
