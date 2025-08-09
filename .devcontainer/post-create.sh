#!/bin/bash
set -e # エラーが発生したらスクリプトを停止する設定

echo "===== [1/5] Installing Poetry... ====="
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/home/vscode/.local/bin:$PATH"
echo "===== Poetry installed successfully. ====="


echo "===== [2/5] Activating 'shell' command for Poetry... ====="
poetry self add poetry-plugin-shell
echo "===== 'shell' plugin installed successfully. ====="


echo "===== [3/5] Setting up OpenHands project... ====="
git clone https://github.com/All-Hands-AI/OpenHands.git
cd OpenHands
cp .env.template .env
sed -i "s#^LLM_API_KEY=.*#LLM_API_KEY=\"${OPENAI_API_KEY}\"#" .env
sed -i "s#^MODEL_NAME=.*#MODEL_NAME=\"gpt-4o\"#" .env
echo "===== OpenHands project setup complete. ====="


# ▼▼▼ これが根本原因を解決する、最後の修正です ▼▼▼
echo "===== [4/5] Configuring Poetry to create a local virtual environment... ====="
poetry config virtualenvs.in-project true
echo "===== Poetry configured successfully. ====="


echo "===== [5/5] Pre-installing project dependencies... ====="
poetry install --no-root
echo "===== Dependencies installed successfully. ====="


echo "✅✅✅ Workshop Environment is completely ready! ✅✅✅"
