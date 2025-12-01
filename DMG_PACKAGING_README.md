# DMG 打包快速参考

本文件提供 Redis Insight DMG 打包的快速参考。

---

## 🚀 快速开始

### M1/M2/M3 Mac（推荐）

```bash
yarn build:dmg:arm64
```

### Intel Mac

```bash
yarn build:dmg:x64
```

### 通用版本（M1 + Intel）

```bash
yarn build:dmg:universal
```

---

## 📦 生成的文件位置

```
release/Redis-Insight-mac-{arch}.dmg
```

---

## 📚 完整文档

- **开发者打包指南**：[docs/DMG_BUILD_GUIDE.md](file:///Users/kurisu/develop/CLionProjects/RedisInsight/docs/DMG_BUILD_GUIDE.md)
- **用户安装指南**：[docs/INSTALL_GUIDE_macOS.md](file:///Users/kurisu/develop/CLionProjects/RedisInsight/docs/INSTALL_GUIDE_macOS.md)
- **打包脚本**：[scripts/build-dmg.sh](file:///Users/kurisu/develop/CLionProjects/RedisInsight/scripts/build-dmg.sh)

---

## ⚙️ 可用命令

| 命令                                  | 说明                           |
| ------------------------------------- | ------------------------------ |
| `yarn build:dmg:arm64`                | 构建 ARM64 架构 DMG（M1 Mac）  |
| `yarn build:dmg:x64`                  | 构建 x64 架构 DMG（Intel Mac） |
| `yarn build:dmg:universal`            | 构建通用架构 DMG               |
| `./scripts/build-dmg.sh --arch arm64` | 使用脚本构建（带详细提示）     |
| `./scripts/build-dmg.sh --help`       | 查看脚本帮助                   |

---

## ⚠️ 重要提示

- ✅ **无需代码签名**：已配置为无签名打包
- ✅ **首次安装说明**：用户需要右键打开应用
- ✅ **分发时附带**：[INSTALL_GUIDE_macOS.md](file:///Users/kurisu/develop/CLionProjects/RedisInsight/docs/INSTALL_GUIDE_macOS.md)

---

## 📋 环境要求

- Node.js >= 22.x ✅（当前：v22.14.0）
- Yarn >= 1.21.3 ✅（当前：1.22.22）
- macOS 10.15+
- Xcode Command Line Tools

---

## 🔍 验证构建

```bash
# 查看生成的文件
ls -lh release/*.dmg

# 检查架构
lipo -info "release/mac-arm64/Redis Insight.app/Contents/MacOS/Redis Insight"
```

---

## 💡 快速测试

```bash
# 挂载 DMG
hdiutil attach release/Redis-Insight-mac-arm64.dmg

# 卸载 DMG
hdiutil detach "/Volumes/Redis Insight"
```

---

**详细文档请查看 [docs/DMG_BUILD_GUIDE.md](file:///Users/kurisu/develop/CLionProjects/RedisInsight/docs/DMG_BUILD_GUIDE.md)**
