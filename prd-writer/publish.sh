#!/bin/bash
# publish.sh — 将 skill/ 目录中的定稿文件发布到所有 Claude Code skills 安装目录
# 用法: bash publish.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_SRC="$SCRIPT_DIR/skill"

TARGETS=(
  "$HOME/.claude/skills/prd-writer"
  "$HOME/.codefuse/engine/cc/skills/prd-writer"
  "$HOME/.codefuse/fuse/skills/prd-writer"
)

GREEN='\033[0;32m'
NC='\033[0m'

# 检查源文件
if [[ ! -f "$SKILL_SRC/SKILL.md" ]]; then
  echo "错误: $SKILL_SRC/SKILL.md 不存在"
  exit 1
fi

echo "发布 prd-writer skill..."
echo "源: $SKILL_SRC"
echo ""

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  rm -rf "$target"/*
  cp -R "$SKILL_SRC"/* "$target"/
  echo -e "${GREEN}✓${NC} → $target"
done

echo ""
echo -e "${GREEN}发布完成。${NC}3 个安装目录已更新。"
