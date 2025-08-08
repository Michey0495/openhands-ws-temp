#!/bin/bash

echo "===== Starting Workshop Environment Setup ====="

# -----------------------------------------------------------------------------
# STEP 1: Poetry (Python Dependency Manager) のインストール
# -----------------------------------------------------------------------------
echo "===== Installing Poetry... ====="
curl -sSL https://install.python-poetry.org | python3 -
# インストールしたPoetryを使えるようにPATHを通す
export PATH="$HOME/.local/bin:$PATH"
# 今後のターミナル起動時にもPATHが通るように設定を追記
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

echo "===== Poetry installed successfully. ====="


# -----------------------------------------------------------------------------
# STEP 2: OpenHands プロジェクトのセットアップ
# -----------------------------------------------------------------------------
echo "===== Setting up OpenHands project... ====="
# OpenHandsのソースコードをクローン
git clone https://github.com/All-Hands-AI/OpenHands.git
cd OpenHands

# .envファイルを作成し、APIキーを注入
cp .env.template .env
# ここで${OPENAI_API_KEY}はCodespacesのSecretsから安全に渡されます
sed -i "s#^LLM_API_KEY=.*#LLM_API_KEY=\"${OPENAI_API_KEY}\"#" .env
sed -i "s#^MODEL_NAME=.*#MODEL_NAME=\"gpt-3.5-turbo\"#" .env


# -----------------------------------------------------------------------------
# STEP 3: プロジェクトライブラリの事前インストール
# -----------------------------------------------------------------------------
echo "===== Pre-installing project dependencies with Poetry... ====="
# この処理で、make build時のPythonライブラリインストールが不要になり、時間が短縮されます
poetry install

echo "===== Workshop Environment is ready! ====="
