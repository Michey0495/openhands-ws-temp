#!/bin/bash

set -e # エラーが発生したらスクリプトを停止する設定

echo "===== [1/3] Installing Poetry... ====="
curl -sSL https://install.python-poetry.org | python3 -
# スクリプト内でPoetryコマンドを即時利用可能にする
export PATH="/home/vscode/.local/bin:$PATH"
echo "===== Poetry installed successfully. ====="


echo "===== [2/3] Setting up OpenHands project... ====="
git clone https://github.com/All-Hands-AI/OpenHands.git
cd OpenHands
cp .env.template .env
sed -i "s#^LLM_API_KEY=.*#LLM_API_KEY=\"${OPENAI_API_KEY}\"#" .env
sed -i "s#^MODEL_NAME=.*#MODEL_NAME=\"gpt-3.5-turbo\"#" .env
echo "===== OpenHands project setup complete. ====="


echo "===== [3/3] Pre-installing project dependencies... ====="
# この処理で、研修当日のビルド時間を大幅に短縮します
poetry install --no-root
echo "===== Dependencies installed successfully. ====="


echo "✅✅✅ Workshop Environment is completely ready! ✅✅✅"
