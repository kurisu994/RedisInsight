#!/bin/bash

#
# DMG 打包脚本 - 无签名版本
# 用于在 macOS 上构建 Redis Insight 的 DMG 安装包
#

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# 显示帮助信息
show_help() {
    cat << EOF
Redis Insight DMG 打包脚本（无签名版本）

用法:
    $0 [选项]

选项:
    -a, --arch ARCH       指定架构: arm64（默认）, x64, universal
    -h, --help            显示此帮助信息

示例:
    $0                    # 使用默认架构（arm64）构建
    $0 --arch x64         # 构建 x64 架构的 DMG
    $0 --arch universal   # 构建通用架构的 DMG

说明:
    - 此脚本会构建无签名的 DMG 文件
    - arm64: 适用于 M1/M2/M3 芯片的 Mac（推荐）
    - x64: 适用于 Intel 芯片的 Mac
    - universal: 同时支持 M1 和 Intel 芯片（文件较大）

EOF
}

# 默认架构
ARCH="arm64"

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--arch)
            ARCH="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
done

# 验证架构参数
if [[ "$ARCH" != "arm64" && "$ARCH" != "x64" && "$ARCH" != "universal" ]]; then
    print_error "不支持的架构: $ARCH"
    print_info "支持的架构: arm64, x64, universal"
    exit 1
fi

print_info "========================================="
print_info "Redis Insight DMG 打包脚本"
print_info "========================================="
print_info "架构: $ARCH"
print_info "签名: 禁用"
print_info "========================================="
echo ""

# 检查 Node.js 版本
print_info "检查 Node.js 版本..."
if ! command -v node &> /dev/null; then
    print_error "未找到 Node.js，请先安装 Node.js >= 22.x"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 22 ]; then
    print_error "Node.js 版本过低（当前: $(node -v)），需要 >= 22.x"
    exit 1
fi
print_success "Node.js 版本检查通过: $(node -v)"

# 检查 Yarn
print_info "检查 Yarn..."
if ! command -v yarn &> /dev/null; then
    print_error "未找到 Yarn，请先安装 Yarn"
    exit 1
fi
print_success "Yarn 版本: $(yarn -v)"

# 清理之前的构建
print_info "清理之前的构建..."
rm -rf dist release
print_success "清理完成"

# 安装依赖
print_info "检查依赖..."
if [ ! -d "node_modules" ]; then
    print_warning "未找到 node_modules，开始安装依赖..."
    yarn install
    print_success "依赖安装完成"
else
    print_success "依赖已存在"
fi

# 执行构建
print_info "开始构建项目..."
yarn build:prod
print_success "项目构建完成"

# 执行打包
print_info "开始打包 DMG（架构: $ARCH）..."
case $ARCH in
    arm64)
        electron-builder build --mac --arm64 -p never -c.mac.notarize=false
        ;;
    x64)
        electron-builder build --mac --x64 -p never -c.mac.notarize=false
        ;;
    universal)
        electron-builder build --mac --universal -p never -c.mac.notarize=false
        ;;
esac

print_success "DMG 打包完成！"

# 查找生成的 DMG 文件
echo ""
print_info "========================================="
print_info "打包结果"
print_info "========================================="

if [ -d "release" ]; then
    DMG_FILES=$(find release -name "*.dmg" -type f)
    if [ -n "$DMG_FILES" ]; then
        print_success "生成的 DMG 文件:"
        echo "$DMG_FILES" | while read -r file; do
            FILE_SIZE=$(du -h "$file" | cut -f1)
            echo "  📦 $file (大小: $FILE_SIZE)"
        done
    else
        print_warning "未找到 DMG 文件"
    fi
fi

# 显示使用说明
echo ""
print_info "========================================="
print_info "分发说明"
print_info "========================================="
cat << EOF

📌 重要提示：

1. 此 DMG 文件未经过代码签名和公证
2. 首次安装时，用户需要执行以下步骤：

   步骤 1: 双击 DMG 文件挂载
   步骤 2: 将应用拖拽到 Applications 文件夹
   步骤 3: 在 Applications 中右键点击应用，选择"打开"
   步骤 4: 在弹出的对话框中点击"打开"按钮

3. 或者在"系统设置 → 隐私与安全性"中点击"仍要打开"

📋 建议：
   - 在分发 DMG 时，附上上述安装说明
   - 可以创建一个 README 或安装指南文档
   - 告知用户这是预期的安全提示，不是病毒

EOF

print_success "打包流程全部完成！"
