#!/usr/bin/env bash
set -euo pipefail

registry="${1:?actor registry tsv required}"
actor_id="${2:?actor id required}"
prompt_file="${3:?prompt file required}"
raw_output="${4:?raw output file required}"
status_file="${5:-}"

line="$(awk -F '\t' -v id="$actor_id" 'NR > 1 && $1 == id {print; exit}' "$registry")"
if [ -z "$line" ]; then
  echo "actor not found: $actor_id" >&2
  exit 1
fi

timeout_seconds="$(printf '%s\n' "$line" | awk -F '\t' '{print $4}')"
actor_command="$(printf '%s\n' "$line" | awk -F '\t' '{print $7}')"

mkdir -p "$(dirname "$raw_output")"
started_at="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

kill_tree() {
  local parent="$1"
  local children
  children="$(pgrep -P "$parent" 2>/dev/null || true)"
  for child in $children; do
    kill_tree "$child"
  done
  kill -TERM "$parent" 2>/dev/null || true
}

bash -lc "$actor_command" < "$prompt_file" > "$raw_output" 2>&1 &
pid=$!

(
  sleep "$timeout_seconds"
  kill_tree "$pid"
) &
watchdog=$!

status=0
wait "$pid" || status=$?
kill "$watchdog" 2>/dev/null || true
wait "$watchdog" 2>/dev/null || true

ended_at="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
result="failed"
reason="exit_$status"

if [ "$status" -eq 0 ]; then
  if [ -s "$raw_output" ]; then
    result="done"
    reason="non_empty_output"
  else
    result="failed"
    reason="empty_output"
    status=2
  fi
fi

if [ -n "$status_file" ]; then
  mkdir -p "$(dirname "$status_file")"
  printf '{"actor":"%s","status":"%s","reason":"%s","started_at":"%s","ended_at":"%s","raw_output":"%s"}\n' "$actor_id" "$result" "$reason" "$started_at" "$ended_at" "$raw_output" > "$status_file"
fi

exit "$status"
