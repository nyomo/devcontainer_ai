---
name: gemini
description: Run the Gemini CLI by piping a file into stdin with an optional -p prompt, and disable IDE companion integration to avoid connection errors. Use when users ask to send a local file as the prompt input for gemini, add extra prompt text, or reliably run gemini without VS Code companion extension.
---

# Gemini

## Overview

Use gemini with file content over stdin and optional extra prompt text.
Always disable IDE integration variables to avoid IDE companion connection errors.
Set `GEMINI_CLI_HOME=/workdir` so gemini uses `/workdir/.gemini`.

## Quick Start

Use the helper script:

```bash
GEMINI_CLI_HOME=/workdir /workdir/.codex/skills/gemini/scripts/gemini_prompt.sh file.md "Summarize in Japanese"
```

Or run the command directly:

```bash
env GEMINI_CLI_HOME=/workdir \
  -u GEMINI_CLI_IDE_SERVER_PORT \
  -u GEMINI_CLI_IDE_WORKSPACE_PATH \
  -u GEMINI_CLI_IDE_AUTH_TOKEN \
  gemini -p "Summarize in Japanese" < file.md
```

## Workflow

1) Choose the input file to feed via stdin.
2) Provide optional extra prompt text that will be passed with `-p`.
3) Set `GEMINI_CLI_HOME=/workdir` so gemini reads `/workdir/.gemini`.
4) Disable `GEMINI_CLI_IDE_*` so gemini does not try to connect to the IDE companion.

## Script Details

Use `scripts/gemini_prompt.sh` for a simple, repeatable invocation pattern.

### Behavior

- Read the file and pass it to gemini via stdin.
- If extra prompt text is provided, append it with `-p`.
- Set `GEMINI_CLI_HOME=/workdir` to ensure gemini uses `/workdir/.gemini`.
- Always unset `GEMINI_CLI_IDE_SERVER_PORT`, `GEMINI_CLI_IDE_WORKSPACE_PATH`,
  and `GEMINI_CLI_IDE_AUTH_TOKEN` before invoking gemini.
