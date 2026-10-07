# VS Code Dev Containers で使う codex & gemini 開発環境

このリポジトリは、ローカル環境を汚さずに `codex` を試せる、初心者向けの Dev Containers 環境です。Docker 環境には Rancher Desktop を使う前提で説明します。

AIが動作するコンテナからインターネットに直接出られないようになっているため、思わぬところにAIがファイルをアップロードするなどの事故を防げる可能性が高いです。

## できること
- コンテナ内で `codex` をすぐ使える
- Node.js 24 / Python / Git / ripgrep などを同梱
- VS Code からワンクリックで起動できる

## 用語メモ
- `codex`: OpenAI の AI コーディング CLI

## 前提
- OS: Windows 11 / macOS
- Docker: Rancher Desktop（推奨、入手先: `https://rancherdesktop.io/`）
- エディタ: Visual Studio Code（入手先: `https://code.visualstudio.com/`）
- VS Code拡張: Dev Containers（入手先: `https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers`）

## Rancher Desktop の準備
1. Rancher Desktop をインストールして起動
2. `Preferences` で以下を確認します。`Container Runtime` は `dockerd`（一般的な Docker コマンド互換のため）。`Kubernetes` は `OFF`（この環境では不要でリソースを節約するため）。
3. `Apply` して反映

## 使い方（VS Code Dev Containers）
1. リポジトリをクローン。GitHub の `Code` ボタンから URL をコピーして置き換えてください。

```bash
git clone <このリポジトリのURL>
cd <リポジトリ名>
```

2. VS Code で開く

```bash
code .
```

3. VS Code 右下に出る `Reopen in Container` をクリックします。出ない場合は `Command Palette` → `Dev Containers: Reopen in Container` を実行します。
4. 初回はイメージのビルドに数分かかります
5. 起動後、VS Code のターミナルで `codex` が使えます

```bash
codex --help
```

## 補足
- コンテナの作業ディレクトリは `/workdir` です（ホストのリポジトリがマウントされます）
- 初回起動時に `codex` がインストール済みです
- 追加で必要なツールは `.devcontainer/Dockerfile` を編集してください

`.devcontainer/Dockerfile` に追記する例:

```Dockerfile
RUN apt-get update && apt-get install -y --no-install-recommends tree
```

## 認証（codex / gemini）
この環境では、`codex` は **APIキーを使わず**、初回実行時にブラウザで認証する方式です。

1. VS Code のターミナルで `codex` を実行
2. 表示された認証URLをブラウザで開く
3. 認証後に表示されるコードをターミナルへ貼り付け

以降は認証情報がコンテナ内に保存され、同じコンテナでは再認証は不要です。

## トラブルシューティング
- Rancher Desktop が起動していないとコンテナは起動できません
- `Reopen in Container` が出ない場合は VS Code の Dev Containers 拡張が有効か確認してください
