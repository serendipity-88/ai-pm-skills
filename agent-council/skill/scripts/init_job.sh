#!/usr/bin/env bash
set -euo pipefail

mode="${1:?mode required}"
target_type="${2:?target_type required}"
target="${3:-}"
root="${4:-.agent-council/jobs}"
ts="$(date +%Y%m%d-%H%M%S)"
job="$root/$ts-$mode"

mkdir -p "$job"/{prompts,outputs,rounds,decisions,status}

cat > "$job/job.json" <<JSON
{
  "skill_name": "agent-council",
  "ts": "$ts",
  "mode": "$mode",
  "target_type": "$target_type",
  "target": "$target",
  "actors": [],
  "actor_matrix": [],
  "qa_gate": "unknown",
  "qa_verdict": null,
  "status": "running"
}
JSON

cat > "$job/result.md" <<'MD'
# Agent Council Result

## 最终结论

TBD

## 这次评审靠不靠谱

TBD

## 为什么是这些视角

TBD

## QA Gate

TBD

## 下一步行动

TBD
MD

echo "$job"
