#!/bin/bash

# 設置環境變數
export FLASK_APP=run.py
export FLASK_ENV=production

# 執行資料庫遷移
flask db upgrade

# 啟動應用程式
gunicorn run:app --bind 0.0.0.0:8080 