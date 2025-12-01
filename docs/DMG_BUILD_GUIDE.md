# Redis Insight DMG 打包指南

本指南将帮助你在 macOS 上构建 Redis Insight 的 DMG 安装包。

## 目录

- [环境要求](#环境要求)
- [快速开始](#快速开始)
- [详细步骤](#详细步骤)
- [分发说明](#分发说明)
- [常见问题](#常见问题)

## 环境要求

### 系统要求

- macOS 10.15 或更高版本
- 至少 8GB 内存
- 至少 10GB 可用磁盘空间

### 软件依赖

1. **Node.js**（>= 22.x）

   ```bash
   # 检查 Node.js 版本
   node --version

   # 如果未安装或版本过低，使用 nvm 安装
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   nvm install 22
   nvm use 22
   ```

2. **Yarn**（>= 1.21.3）

   ```bash
   # 检查 Yarn 版本
   yarn --version

   # 如果未安装，使用 npm 安装
   npm install -g yarn
   ```

3. **Xcode Command Line Tools**
   ```bash
   xcode-select --install
   ```

## 快速开始

如果你已经满足所有环境要求，可以使用以下快捷命令：

```bash
# 安装依赖（首次需要）
yarn install

# 构建 ARM64 架构 DMG（M1/M2/M3 Mac 推荐）
yarn build:dmg:arm64

# 或使用打包脚本
./scripts/build-dmg.sh --arch arm64
```

生成的 DMG 文件位于 `release` 目录。

## 详细步骤

### 步骤 1: 克隆项目（如果尚未克隆）

```bash
git clone https://github.com/RedisInsight/RedisInsight.git
cd RedisInsight
```

### 步骤 2: 安装依赖

```bash
yarn install
```

> **注意**：首次安装可能需要 10-20 分钟，具体取决于网络速度。

### 步骤 3: 选择打包方式

#### 方式 1: 使用 Yarn 脚本（推荐）

根据你的目标平台选择相应的命令：

```bash
# ARM64 架构（M1/M2/M3 Mac）- 推荐用于 Apple Silicon
yarn build:dmg:arm64

# x64 架构（Intel Mac）
yarn build:dmg:x64

# Universal 架构（同时支持 M1 和 Intel）- 文件较大
yarn build:dmg:universal
```

#### 方式 2: 使用打包脚本

```bash
# ARM64 架构（默认）
./scripts/build-dmg.sh

# x64 架构
./scripts/build-dmg.sh --arch x64

# Universal 架构
./scripts/build-dmg.sh --arch universal

# 查看帮助
./scripts/build-dmg.sh --help
```

### 步骤 4: 等待构建完成

构建过程包括以下阶段：

1. 清理之前的构建
2. 构建 API 和 UI
3. 打包 Electron 应用
4. 创建 DMG 安装包

> **耗时参考**：
>
> - M1 Mac: 约 5-10 分钟
> - Intel Mac: 约 10-20 分钟

### 步骤 5: 验证生成的 DMG

构建完成后，你会在 `release` 目录中找到 DMG 文件：

```bash
ls -lh release/*.dmg
```

文件名示例：

- `Redis-Insight-mac-arm64.dmg`（ARM64）
- `Redis-Insight-mac-x64.dmg`（x64）

## 架构选择建议

| 架构          | 适用设备     | 优点                   | 缺点                 |
| ------------- | ------------ | ---------------------- | -------------------- |
| **arm64**     | M1/M2/M3 Mac | 原生性能最佳，文件较小 | 仅支持 Apple Silicon |
| **x64**       | Intel Mac    | 兼容所有 Intel Mac     | 不支持 M1 Mac        |
| **universal** | 所有 Mac     | 同时支持两种架构       | 文件大小约为 2 倍    |

> **推荐**：
>
> - 如果主要用户使用 M1 Mac，选择 `arm64`
> - 如果需要同时支持 M1 和 Intel Mac，选择 `universal`

## 分发说明

### 给最终用户的安装指南

由于 DMG 文件**未经过代码签名**，首次安装时 macOS Gatekeeper 会显示安全提示。请在分发时附上以下安装说明：

#### 安装步骤

1. **下载并打开 DMG 文件**

   - 双击下载的 `Redis-Insight-mac-xxx.dmg` 文件

2. **拖拽应用到 Applications 文件夹**

   - 将 "Redis Insight" 图标拖拽到 "Applications" 文件夹图标上

3. **首次打开应用**（重要！）

   **不要**直接双击应用，这会显示"无法打开"的错误。

   请使用以下任一方法：

   **方法 1：右键打开（推荐）**

   - 打开 "Applications" 文件夹
   - 找到 "Redis Insight"
   - **右键点击**（或按住 Control 点击）
   - 选择 "打开"
   - 在弹出的对话框中点击 "打开" 按钮

   **方法 2：系统设置允许**

   - 尝试打开应用（会失败）
   - 打开 "系统设置" → "隐私与安全性"
   - 在底部找到关于 "Redis Insight" 的提示
   - 点击 "仍要打开"

4. **后续使用**
   - 首次打开后，以后可以正常双击启动

#### 安全说明模板

建议在分发时附上以下说明：

```markdown
## 安全提示

此应用未经过 Apple 公证，但这**不意味着**它不安全。由于未支付 Apple Developer 年费，
我们选择不进行代码签名。应用的源代码是开源的，你可以自行审查。

首次安装时需要右键点击应用选择"打开"，这是 macOS 的正常安全机制。
```

## 常见问题

### 1. 构建失败：Node.js 版本过低

**问题**：

```
Error: Node.js version is too old
```

**解决方案**：

```bash
# 使用 nvm 升级 Node.js
nvm install 22
nvm use 22
```

### 2. 构建失败：内存不足

**问题**：

```
FATAL ERROR: Ineffective mark-compacts near heap limit
```

**解决方案**：

```bash
# 增加 Node.js 内存限制
export NODE_OPTIONS="--max-old-space-size=8192"
yarn build:dmg:arm64
```

### 3. 用户无法打开应用

**问题**：双击应用显示"无法打开，因为来自身份不明的开发者"

**解决方案**：
参考上面的[安装步骤](#安装步骤)，使用右键打开。

### 4. 应用在 M1 Mac 上运行缓慢

**问题**：应用运行缓慢或通过 Rosetta 运行

**原因**：可能使用了 x64 架构的 DMG

**解决方案**：

```bash
# 重新构建 ARM64 版本
yarn build:dmg:arm64

# 验证架构
lipo -info "release/mac-arm64/Redis Insight.app/Contents/MacOS/Redis Insight"
# 应该显示: arm64
```

### 5. 清理并重新构建

如果遇到奇怪的构建错误：

```bash
# 清理所有构建产物
rm -rf dist release node_modules

# 重新安装依赖
yarn install

# 重新构建
yarn build:dmg:arm64
```

### 6. 检查生成的 DMG 是否正常

```bash
# 挂载 DMG（不安装）
hdiutil attach release/Redis-Insight-mac-arm64.dmg

# 检查应用架构
lipo -info "/Volumes/Redis Insight/Redis Insight.app/Contents/MacOS/Redis Insight"

# 卸载 DMG
hdiutil detach "/Volumes/Redis Insight"
```

## M1 Mac 特定注意事项

### Rosetta 2 兼容性

- 如果你在 M1 Mac 上构建 **x64** 架构的 DMG，需要安装 Rosetta 2
- ARM64 版本不需要 Rosetta 2，性能更好

```bash
# 安装 Rosetta 2（如果需要）
softwareupdate --install-rosetta
```

### 推荐配置

对于 M1/M2/M3 Mac 用户：

```bash
# 确保使用原生 ARM64 版本的 Node.js
node -p "process.arch"
# 应该输出: arm64

# 构建 ARM64 版本
yarn build:dmg:arm64
```

## 进阶选项

### 同时构建多个架构

```bash
# 构建 ARM64 版本
yarn build:dmg:arm64

# 构建 x64 版本
yarn build:dmg:x64

# 两个 DMG 都会在 release 目录中
ls -lh release/*.dmg
```

### 自定义构建选项

如果需要更多自定义选项，可以直接使用 electron-builder：

```bash
# 先构建项目
yarn build:prod

# 然后使用 electron-builder
electron-builder build --mac --arm64 -p never -c.mac.notarize=false
```

### 查看详细构建日志

```bash
# 启用调试模式
DEBUG=electron-builder yarn build:dmg:arm64
```

## 技术细节

### 构建流程

1. **清理**：删除 `dist` 和 `release` 目录
2. **API 构建**：使用 NestJS 构建后端 API
3. **UI 构建**：使用 Vite 构建 React 前端
4. **主进程构建**：使用 Webpack 构建 Electron 主进程
5. **打包**：使用 electron-builder 创建 DMG

### 关键配置

- **electron-builder 配置**：[electron-builder.json](file:///Users/kurisu/develop/CLionProjects/RedisInsight/electron-builder.json)
- **签名设置**：`notarize: false`（禁用）
- **输出目录**：`release`

## 获取帮助

如果遇到本指南未涵盖的问题：

1. 查看项目的 [Issues](https://github.com/RedisInsight/RedisInsight/issues)
2. 查看 [electron-builder 文档](https://www.electron.build/)
3. 检查构建日志以获取详细错误信息

## 许可证

本项目遵循 SSPL 许可证。详情请查看 [LICENSE](file:///Users/kurisu/develop/CLionProjects/RedisInsight/LICENSE) 文件。
