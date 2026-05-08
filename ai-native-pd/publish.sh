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
RED='\033[0;31m'
NC='\033[0m'

# 检查源文件
if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
  echo -e "${RED}错误：找不到 $SKILL_DIR/SKILL.md${NC}"
  exit 1
fi

echo "发布 ai-native-pd skill..."
echo "源目录: $SKILL_DIR"
echo ""

for target in "${TARGETS[@]}"; do
  if [[ ! -d "$target" ]]; then
    mkdir -p "$target"
    echo -e "${GREEN}创建${NC} $target"
  fi

  # 同步 SKILL.md（大写和小写都写入）
  cp "$SKILL_DIR/SKILL.md" "$target/SKILL.md"
  cp "$SKILL_DIR/SKILL.md" "$target/skill.md"

  # 同步 references/
  if [[ -d "$SKILL_DIR/references" ]]; then
    mkdir -p "$target/references"
    cp -r "$SKILL_DIR/references/"* "$target/references/"
  fi

  # 同步 templates/
  if [[ -d "$SKILL_DIR/templates" ]]; then
    mkdir -p "$target/templates"
    cp -r "$SKILL_DIR/templates/"* "$target/templates/"
  fi

  echo -e "${GREEN}✓${NC} $target"
done

echo ""
echo -e "${GREEN}发布完成！${NC}"

# 验证：显示新版 description
echo ""
echo "验证（第一个目标的 description）："
head -3 "${TARGETS[0]}/SKILL.md" | grep "description"
