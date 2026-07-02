#!/usr/bin/env bash
set -euo pipefail

registry="${1:?actor registry tsv required}"
actor_id="${2:?actor id required}"

line="$(awk -F '\t' -v id="$actor_id" 'NR > 1 && $1 == id {print; exit}' "$registry")"
if [ -z "$line" ]; then
  echo "unavailable"
  echo "actor not found: $actor_id"
  exit 1
fi

timeout_seconds="$(printf '%s\n' "$line" | awk -F '\t' '{print $4}')"
healthcheck_prompt="$(printf '%s\n' "$line" | awk -F '\t' '{print $5}')"
expected="$(printf '%s\n' "$line" | awk -F '\t' '{print $6}')"
actor_command="$(printf '%s\n' "$line" | awk -F '\t' '{print $7}')"

tmp="$(mktemp)"
status_file="${3:-}"
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

bash -lc "$actor_command" > "$tmp" 2>&1 <<EOF &
$healthcheck_prompt
EOF
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
result="unavailable"
reason="exit_$status"

if [ "$status" -eq 0 ]; then
  if grep -q "$expected" "$tmp"; then
    result="healthy"
    reason="expected_output_found"
    echo "$result"
    if [ -n "$status_file" ]; then
      mkdir -p "$(dirname "$status_file")"
      printf '{"actor":"%s","status":"%s","reason":"%s","started_at":"%s","ended_at":"%s"}\n' "$actor_id" "$result" "$reason" "$started_at" "$ended_at" > "$status_file"
    fi
    exit 0
  fi
  result="degraded"
  reason="expected_output_missing"
  echo "$result"
  cat "$tmp"
  if [ -n "$status_file" ]; then
    mkdir -p "$(dirname "$status_file")"
    printf '{"actor":"%s","status":"%s","reason":"%s","started_at":"%s","ended_at":"%s"}\n' "$actor_id" "$result" "$reason" "$started_at" "$ended_at" > "$status_file"
  fi
  exit 2
fi

if [ "$status" -eq 143 ] || [ "$status" -eq 143 ]; then
  reason="timeout_or_terminated"
fi

echo "$result"
cat "$tmp"
if [ -n "$status_file" ]; then
  mkdir -p "$(dirname "$status_file")"
  printf '{"actor":"%s","status":"%s","reason":"%s","started_at":"%s","ended_at":"%s"}\n' "$actor_id" "$result" "$reason" "$started_at" "$ended_at" > "$status_file"
fi
exit 1
