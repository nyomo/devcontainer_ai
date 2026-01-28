#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE' >&2
Usage: codex_prompt.sh <file> [prompt]

Reads <file> and sends it to codex via stdin.
Optionally append a prompt with -p.
USAGE
}

if [ $# -lt 1 ]; then
  usage
  exit 2
fi

file="$1"
shift
prompt="${*:-}"

if [ ! -f "$file" ]; then
  echo "File not found: $file" >&2
  exit 1
fi

args=("--sandbox" "danger-full-access")
if [ -n "$prompt" ]; then
  args+=("$prompt")
fi

codex exec "${args[@]}" < "$file"
