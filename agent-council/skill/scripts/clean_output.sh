#!/usr/bin/env bash
set -euo pipefail

input="${1:?input file required}"
output="${2:?output file required}"

sed -E 's/\x1b\[[0-9;?]*[a-zA-Z]//g' "$input" > "$output"

