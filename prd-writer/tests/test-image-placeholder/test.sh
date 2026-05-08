#!/bin/bash
# 测试图片占位符生成逻辑

echo "=== 测试：图片占位符生成逻辑 ==="
echo ""

TEST_DIR="$(cd "$(dirname "$0")" && pwd)"
PRD_DIR="$TEST_DIR/prd"

echo "测试目录：$TEST_DIR"
echo "PRD 输出目录：$PRD_DIR"
echo ""

# 清理旧输出
rm -rf "$PRD_DIR"
mkdir -p "$PRD_DIR"

echo "运行 prd-writer..."
echo ""

# 使用 claude code 运行 skill
cd "$TEST_DIR"
claude "/prd-writer" <<'INPUT'
基于 demo.html 和 product-brief.md 生成 PRD
INPUT

echo ""
echo "=== 检查生成结果 ==="

# 检查是否生成了 PRD
if [ -f "$PRD_DIR/PRD_v1.0.md" ]; then
    echo "✓ PRD 已生成：$PRD_DIR/PRD_v1.0.md"
    echo ""

    # 检查占位符
    echo "检查图片占位符..."
    PLACEHOLDER_COUNT=$(grep -c "📷 \*\*图片占位\*\*" "$PRD_DIR/PRD_v1.0.md" 2>/dev/null || echo 0)
    echo "发现占位符数量：$PLACEHOLDER_COUNT"
    echo ""

    if [ "$PLACEHOLDER_COUNT" -gt 0 ]; then
        echo "占位符详情:"
        grep -A 3 "📷 \*\*图片占位\*\*" "$PRD_DIR/PRD_v1.0.md"
        echo ""
    fi

    # 检查是否生成了 Mermaid/PlantUML 图表
    MERMAID_COUNT=$(grep -c '```mermaid' "$PRD_DIR/PRD_v1.0.md" 2>/dev/null || echo 0)
    PLANTUML_COUNT=$(grep -c '```plantuml' "$PRD_DIR/PRD_v1.0.md" 2>/dev/null || echo 0)
    echo "Mermaid 图表数量：$MERMAID_COUNT"
    echo "PlantUML 图表数量：$PLANTUML_COUNT"
else
    echo "✗ PRD 未生成"
    exit 1
fi

echo ""
echo "=== 测试完成 ==="