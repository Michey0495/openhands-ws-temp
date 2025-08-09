#!/bin/bash
set -e # エラーが発生したらスクリプトを停止する設定

echo "===== [1/4] Installing Poetry... ====="
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/home/vscode/.local/bin:$PATH"
echo "===== Poetry installed successfully. ====="


# ▼▼▼ このブロックを追加して、'shell'コマンドを有効化 ▼▼▼
echo "===== [2/4] Activating 'shell' command for Poetry... ====="
poetry self add poetry-plugin-shell
echo "===== 'shell' plugin installed successfully. ====="


echo "===== [3/4] Setting up OpenHands project... ====="
git clone https://github.com/All-Hands-AI/OpenHands.git
cd OpenHands
cp .env.template .env
sed -i "s#^LLM_API_KEY=.*#LLM_API_KEY=\"${OPENAI_API_KEY}\"#" .env
sed -i "s#^MODEL_NAME=.*#MODEL_NAME=\"gpt-4o\"#" .env
echo "===== OpenHands project setup complete. ====="


echo "===== [4/4] Pre-installing project dependencies... ====="
poetry install --no-root
echo "===== Dependencies installed successfully. ====="


echo "✅✅✅ Workshop Environment is completely ready! ✅✅✅"
