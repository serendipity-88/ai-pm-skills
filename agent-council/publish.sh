#!/usr/bin/env bash
set -euo pipefail

target="${1:-codex}"
with_cross="${2:-}"
root="$(cd "$(dirname "$0")" && pwd)"

case "$target" in
  codex)
    skills_dir="$HOME/.codex/skills"
    ;;
  claude)
    skills_dir="$HOME/.claude/skills"
    ;;
  codefuse)
    skills_dir="$HOME/.codefuse/engine/cc/skills"
    ;;
  codefuse-fuse)
    skills_dir="$HOME/.codefuse/fuse/skills"
    ;;
  custom)
    skills_dir="${2:?custom target path required}"
    with_cross="${3:-}"
    ;;
  *)
    echo "usage: $0 codex|claude|codefuse|codefuse-fuse|custom [path] [--with-cross]" >&2
    exit 2
    ;;
esac

mkdir -p "$skills_dir/agent-council"
rm -rf "$skills_dir/agent-council"
cp -R "$root/skill" "$skills_dir/agent-council"
echo "installed agent-council -> $skills_dir/agent-council"

if [ "$with_cross" = "--with-cross" ]; then
  mkdir -p "$skills_dir/cross"
  rm -rf "$skills_dir/cross"
  cp -R "$root/legacy-cross" "$skills_dir/cross"
  echo "installed cross legacy alias -> $skills_dir/cross"
fi
