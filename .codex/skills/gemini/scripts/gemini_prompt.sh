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
args+=("-y")
if [ -n "$prompt" ]; then
  args+=("-p" "$prompt")
fi

fixed_header=$'あなたと私の対話ログとして追記してください。\n形式は以下で統一:\n- 私: <ユーザー発話>\n- Gemini: <あなたの返答>\n- 根拠/要点: <結論の根拠や要点を箇条書きで>\n注意: 余計な説明は入れず、この形式の行だけを追記すること。'
file_body="$(cat "$file")"

# Disable IDE integration to avoid connection errors or unexpected auth flows.
env -u GEMINI_CLI_IDE_SERVER_PORT \
  -u GEMINI_CLI_IDE_WORKSPACE_PATH \
  -u GEMINI_CLI_IDE_AUTH_TOKEN \
  GEMINI_CLI_HOME="${GEMINI_CLI_HOME:-/workdir}" \
  gemini "${args[@]}" < <(printf '%s\n\n%s\n' "$fixed_header" "$file_body")
