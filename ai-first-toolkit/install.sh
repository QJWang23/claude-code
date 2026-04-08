#!/bin/bash

# AI-First Toolkit - 一键安装脚本
# 用法: ./install.sh [目标项目路径]

set -e

TOOLKIT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR=${1:-.}

echo "=== AI-First Toolkit 安装 ==="
echo "工具包路径: $TOOLKIT_DIR"
echo "目标项目: $TARGET_DIR"
echo ""

cd "$TARGET_DIR"

# 1. 安装 CLAUDE.md
echo "[1/4] 安装 CLAUDE.md..."
if [ -f "CLAUDE.md" ]; then
    echo "  CLAUDE.md 已存在，跳过（如需更新请手动覆盖）"
else
    cp "$TOOLKIT_DIR/templates/CLAUDE.md.template" ./CLAUDE.md
    echo "  已创建 CLAUDE.md，请根据项目实际情况修改"
fi

# 2. 安装 settings.json
echo "[2/4] 安装 settings.json..."
mkdir -p .claude
if [ -f ".claude/settings.json" ]; then
    echo "  .claude/settings.json 已存在，跳过"
else
    cp "$TOOLKIT_DIR/config/settings.team.json" .claude/settings.json
    echo "  已创建 .claude/settings.json"
fi

# 3. 安装自定义命令
echo "[3/4] 安装自定义命令..."
mkdir -p .claude/commands
for cmd in "$TOOLKIT_DIR/commands"/*.md; do
    cmd_name=$(basename "$cmd")
    cp "$cmd" ".claude/commands/$cmd_name"
    echo "  已安装 /${cmd_name%.md}"
done

# 4. 创建度量目录
echo "[4/4] 创建度量目录..."
mkdir -p docs/metrics
echo "  已创建 docs/metrics/"

echo ""
echo "=== 安装完成 ==="
echo ""
echo "下一步："
echo "1. 编辑 CLAUDE.md，填写项目实际情况"
echo "2. 重启 Claude Code 使配置生效"
echo "3. 尝试使用 /design-review、/tech-spec、/test-gen 命令"
echo "4. 运行 $TOOLKIT_DIR/scripts/collect-baseline.sh 收集度量基线"
