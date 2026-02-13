# codexをDockerの中に閉じ込めた状態で使いたい

このリポジトリは、Dockerコンテナ内に `codex`（`@openai/codex`）と開発に必要なツールをまとめた初心者向けの開発環境です。Windows / macOS を想定し、Docker環境には Rancher Desktop を使う前提で説明します。

## できること
- コンテナ内で `codex` と `gemini` をすぐ使える
- Node.js 24 / Python / Git / ripgrep などを同梱
- VS Code の Dev Containers で簡単に起動

## 前提
- OS: Windows 11 / macOS
- Docker: Rancher Desktop（推奨）
- エディタ: Visual Studio Code
- VS Code拡張: Dev Containers

## Rancher Desktopの準備
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

## 使い方（docker compose を手動で使う）
VS Code を使わずにコンテナを起動する場合は以下を実行します。

```bash
docker compose -f .devcontainer/docker-compose.yml up --build -d
```

コンテナに入るには以下を実行します。

```bash
docker exec -it vscode_devcontainer_ai bash
```

終了する場合は以下を実行します。

```bash
docker compose -f .devcontainer/docker-compose.yml down
```

## 補足
- コンテナの作業ディレクトリは `/workdir` です（ホストのリポジトリがマウントされます）
- 初回起動時に `codex` と `gemini` がインストール済みです
- 追加で必要なツールは `Dockerfile` を編集してください

## トラブルシューティング
- Rancher Desktop が起動していないとコンテナは起動できません
- `docker compose` が使えない場合は Rancher Desktop の `dockerd` 設定を確認してください

