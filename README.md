# codexをDockerの中に閉じ込めた状態で使いたい

このリポジトリは、VS Code の Dev Containers 拡張で使う初心者向けの開発環境です。Docker 環境には Rancher Desktop を使う前提で説明します。

## できること
- コンテナ内で `codex` と `gemini` をすぐ使える
- Node.js 24 / Python / Git / ripgrep などを同梱
- VS Code からワンクリックで起動できる

## 前提
- OS: Windows 11 / macOS
- Docker: Rancher Desktop（推奨）
- エディタ: Visual Studio Code
- VS Code拡張: Dev Containers

## Rancher Desktop の準備
1. Rancher Desktop をインストールして起動
2. `Preferences` で以下を確認
   - `Container Runtime`: `dockerd`（推奨）
   - `Kubernetes`: OFF（初心者はOFF推奨）
3. `Apply` して反映

## 使い方（VS Code Dev Containers）
1. リポジトリをクローン

```bash
git clone <このリポジトリのURL>
cd <リポジトリ名>
```

2. VS Code で開く

```bash
code .
```

3. VS Code 右下に出る `Reopen in Container` をクリック
   - もしくは `Command Palette` → `Dev Containers: Reopen in Container`
4. 初回はイメージのビルドに数分かかります
5. 起動後、VS Code のターミナルで `codex` が使えます

```bash
codex --help
```

## 補足
- コンテナの作業ディレクトリは `/workdir` です（ホストのリポジトリがマウントされます）
- 初回起動時に `codex` と `gemini` がインストール済みです
- 追加で必要なツールは `.devcontainer/Dockerfile` を編集してください

## トラブルシューティング
- Rancher Desktop が起動していないとコンテナは起動できません
- `Reopen in Container` が出ない場合は VS Code の Dev Containers 拡張が有効か確認してください
- `gemini` を使う場合は事前に認証が必要です（初回実行時に案内に従ってブラウザで認証してください）
