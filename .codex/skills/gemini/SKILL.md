---
name: gemini
description: ローカルファイルを stdin で Gemini CLI に渡し、必要に応じて追加プロンプトを付けて実行する。IDE companion 連携を無効化して、IDEが使えない環境でも安定して実行できるようにする。
---

# Gemini

## Overview

このスキルは、IDE companion 連携が使えない環境でも Gemini CLI を安定して動かすための手順です。
ローカルファイルを stdin で渡し、必要に応じて追加プロンプトを付与して実行します。

前提: `<PROJECT_ROOT>/.codex/skills/gemini/scripts/gemini_prompt.sh` が存在すること。
（`<PROJECT_ROOT>` はこのリポジトリのルートディレクトリへのパスに置き換えてください。例: `/workdir`）

`GEMINI_CLI_HOME` は Gemini の設定保存先です。ここでは `<PROJECT_ROOT>` 配下の `.gemini` を使う想定で、
`GEMINI_CLI_HOME=<PROJECT_ROOT>` を設定します。

## Quick Start

ヘルパースクリプトを使う方法:

```bash
GEMINI_CLI_HOME=<PROJECT_ROOT> <PROJECT_ROOT>/.codex/skills/gemini/scripts/gemini_prompt.sh [ファイルパス] "[追加プロンプト]"
```

直接コマンドを実行する方法:

```bash
env -u GEMINI_CLI_IDE_SERVER_PORT \
  -u GEMINI_CLI_IDE_WORKSPACE_PATH \
  -u GEMINI_CLI_IDE_AUTH_TOKEN \
  GEMINI_CLI_HOME=<PROJECT_ROOT> \
  gemini -p "[追加プロンプト]" < [ファイルパス]
```

補足: `env -u` は指定した環境変数を一時的に削除します。ここでは IDE companion 連携用の変数を無効化しています。

## Script Details

`<PROJECT_ROOT>/.codex/skills/gemini/scripts/gemini_prompt.sh` は以下を行います。

- ファイル内容を stdin で gemini に渡す
- 追加プロンプトがあれば `-p` で付与する
- `GEMINI_CLI_HOME` を設定して `.gemini` を使用する
- `GEMINI_CLI_IDE_SERVER_PORT` / `GEMINI_CLI_IDE_WORKSPACE_PATH` / `GEMINI_CLI_IDE_AUTH_TOKEN` を無効化する

## Tips

毎回 `GEMINI_CLI_HOME=<PROJECT_ROOT>` を付けるのが面倒な場合は、以下の方法も使えます。

- シェルで一度だけ設定する: `export GEMINI_CLI_HOME=<PROJECT_ROOT>`
- `.env` などで管理する
