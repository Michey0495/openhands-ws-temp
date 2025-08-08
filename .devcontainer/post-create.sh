#!/bin/bash

echo "===== Starting Workshop Environment Setup ====="

# OpenHandsのソースコードをクローン
git clone https://github.com/All-Hands-AI/OpenHands.git
cd OpenHands

# .envファイルを作成し、APIキーを注入
cp .env.template .env
# ここで${OPENAI_API_KEY}は次のステップで設定する「秘密の鍵」です
sed -i "s#^LLM_API_KEY=.*#LLM_API_KEY=\"${OPENAI_API_KEY}\"#" .env
sed -i "s#^MODEL_NAME=.*#MODEL_NAME=\"gpt-3.5-turbo\"#" .env

echo "===== Setup Complete! Ready for the workshop. ====="
