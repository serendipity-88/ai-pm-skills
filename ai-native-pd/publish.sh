#!/bin/bash
# publish.sh — 将 ai-native-pd skill 发布到所有 Claude Code skills 安装目录
# 用法: bash publish.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$SCRIPT_DIR/skill"

TARGETS=(
  "$HOME/.claude/skills/ai-native-pd"
  "$HOME/.codefuse/engine/cc/skills/ai-native-pd"
  "$HOME/.codefuse/fuse/skills/ai-native-pd"
)

GREEN='\033[0;32m'
NC='\033[0m'

# 检查源文件
if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
  echo "错误: $SKILL_DIR/SKILL.md 不存在"
  exit 1
fi

echo "发布 ai-native-pd skill..."
echo "源: $SKILL_DIR"
echo ""

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  rm -rf "$target"/*
  cp -R "$SKILL_DIR"/* "$target"/
  echo -e "${GREEN}✓${NC} → $target"
done

echo ""
echo -e "${GREEN}发布完成。${NC}3 个安装目录已更新。"