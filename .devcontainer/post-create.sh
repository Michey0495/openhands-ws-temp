#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e

echo "===== [1/3] Installing Poetry... ====="
# This installs Poetry into /home/vscode/.local/bin, which devcontainer.json now adds to the PATH.
curl -sSL https://install.python-poetry.org | python3 -
echo "===== Poetry installed successfully. ====="


echo "===== [2/3] Setting up OpenHands project... ====="
git clone https://github.com/All-Hands-AI/OpenHands.git
cd OpenHands
cp .env.template .env
sed -i "s#^LLM_API_KEY=.*#LLM_API_KEY=\"${OPENAI_API_KEY}\"#" .env
sed -i "s#^MODEL_NAME=.*#MODEL_NAME=\"gpt-3.5-turbo\"#" .env
echo "===== OpenHands project setup complete. ====="


echo "===== [3/3] Pre-installing project dependencies... ====="
# We must use the absolute path to the poetry executable here because the PATH
# change from devcontainer.json only applies *after* this script finishes.
/home/vscode/.local/bin/poetry install --no-root
echo "===== Dependencies installed successfully. ====="


echo "✅✅✅ Workshop Environment is completely ready! ✅✅✅"
