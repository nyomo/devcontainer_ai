---
name: codex
description: Run the Codex CLI by piping a file into stdin with an optional -p prompt, always passing --sandbox danger-full-access. Use when users ask to send a local file as the prompt input for codex, add extra prompt text, or reliably invoke codex with the required sandbox flag.
---

# Codex

## Overview

Use codex with file content over stdin and optional extra prompt text.
Always pass `--sandbox danger-full-access`.

## Quick Start

Use the helper script:

```bash
/workdir/.codex/skills/codex/scripts/codex_prompt.sh file.md "Summarize in Japanese"
```

Or run the command directly:

```bash
codex --sandbox danger-full-access -p "Summarize in Japanese" < file.md
```

## Workflow

1) Choose the input file to feed via stdin.
2) Provide optional extra prompt text that will be passed with `-p`.
3) Always pass `--sandbox danger-full-access` to codex.

## Script Details

Use `scripts/codex_prompt.sh` for a simple, repeatable invocation pattern.

### Behavior

- Read the file and pass it to codex via stdin.
- If extra prompt text is provided, append it with `-p`.
- Always include `--sandbox danger-full-access`.
