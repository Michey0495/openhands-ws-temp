#!/bin/bash
set -e # エラーが発生したらスクリプトを停止する設定

echo "===== [1/6] Installing Poetry... ====="
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/home/vscode/.local/bin:$PATH"
echo "===== Poetry installed successfully. ====="


echo "===== [2/6] Activating 'shell' command for Poetry... ====="
poetry self add poetry-plugin-shell
echo "===== 'shell' plugin installed successfully. ====="


echo "===== [3/6] Setting up OpenHands project... ====="
# プロジェクトのルートにクローンする
git clone https://github.com/All-Hands-AI/OpenHands.git
# クローンしたディレクトリに移動
cd OpenHands
cp .env.template .env
sed -i "s#^LLM_API_KEY=.*#LLM_API_KEY=\"${OPENAI_API_KEY}\"#" .env
sed -i "s#^MODEL_NAME=.*#MODEL_NAME=\"gpt-4o\"#" .env
echo "===== OpenHands project setup complete. ====="


echo "===== [4/6] Configuring Poetry to create a local virtual environment... ====="
poetry config virtualenvs.in-project true
echo "===== Poetry configured successfully. ====="


echo "===== [5/6] Pre-installing backend dependencies... ====="
poetry install --no-root
echo "===== Backend dependencies installed successfully. ====="


# ▼▼▼ ここからが追加する修正です ▼▼▼
echo "===== [6/6] Pre-building frontend... ====="
# フロントエンドのディレクトリに移動
cd frontend
# フロントエンドの依存関係をインストール
npm install
# フロントエンドをビルド
npm run build
# 元のディレクトリに戻る
cd ..
echo "===== Frontend built successfully. ====="
# ▲▲▲ ここまでが追加する修正です ▲▲▲


echo "✅✅✅ Workshop Environment is completely ready! ✅✅✅"
