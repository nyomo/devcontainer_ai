#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE' >&2
Usage: gemini_prompt.sh <file> [prompt]

Reads <file> and sends it to gemini via stdin.
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

args=()
append_instruction="結果は必ずこのファイルに追記して出力してください: $file"
if [ -n "$prompt" ]; then
  args+=("-p" "$prompt
$append_instruction")
else
  args+=("-y -p" "$append_instruction")
fi

# Disable IDE integration to avoid connection errors.
env GEMINI_CLI_HOME="${GEMINI_CLI_HOME:-/workdir}" \
  -u GEMINI_CLI_IDE_SERVER_PORT \
  -u GEMINI_CLI_IDE_WORKSPACE_PATH \
  -u GEMINI_CLI_IDE_AUTH_TOKEN \
  gemini "${args[@]}" < "$file"
