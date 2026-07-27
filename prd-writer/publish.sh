#!/bin/bash
# publish.sh — 将 skill/ 目录中的定稿文件发布到 Agent CLI skills 安装目录
# 用法:
#   bash publish.sh              # 发布到 all
#   bash publish.sh codex        # 仅发布到 Codex
#   bash publish.sh claude       # 仅发布到 Claude Code
#   bash publish.sh custom /path/to/skills/prd-writer

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_SRC="$SCRIPT_DIR/skill"
SKILL_NAME="prd-writer"
TARGET_GROUP="${1:-all}"

case "$TARGET_GROUP" in
  all)
    TARGETS=(
      "$HOME/.codex/skills/$SKILL_NAME"
      "$HOME/.claude/skills/$SKILL_NAME"
    )
    ;;
  codex)
    TARGETS=("$HOME/.codex/skills/$SKILL_NAME")
    ;;
  claude)
    TARGETS=("$HOME/.claude/skills/$SKILL_NAME")
    ;;
  custom)
    if [[ $# -lt 2 ]]; then
      echo "用法: bash publish.sh custom /path/to/skills/$SKILL_NAME"
      exit 1
    fi
    TARGETS=("$2")
    ;;
  *)
    echo "未知目标: $TARGET_GROUP"
    echo "可选: all | codex | claude | custom <path>"
    exit 1
    ;;
esac

GREEN='\033[0;32m'
NC='\033[0m'

# 检查源文件
if [[ ! -f "$SKILL_SRC/SKILL.md" ]]; then
  echo "错误: $SKILL_SRC/SKILL.md 不存在"
  exit 1
fi

echo "发布 $SKILL_NAME skill..."
echo "源: $SKILL_SRC"
echo ""

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  rm -rf "$target"/*
  cp -R "$SKILL_SRC"/* "$target"/
  echo -e "${GREEN}✓${NC} → $target"
done

echo ""
echo -e "${GREEN}发布完成。${NC}${#TARGETS[@]} 个安装目录已更新。"
