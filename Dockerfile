# 使用 Python 3.11 作為基礎映像
FROM python:3.10

# 設置工作目錄
WORKDIR /app

# 設置環境變量
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080

# 安裝系統依賴
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 複製依賴文件
COPY requirements.txt .

# 安裝 Python 依賴
RUN pip install --no-cache-dir numpy && \
    pip install --no-cache-dir -r requirements.txt

# 複製應用程序代碼
COPY . .

# 創建上傳文件夾
RUN mkdir -p /app/uploads

# 暴露端口
EXPOSE 8080

# 使用 gunicorn 運行應用程序
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "--bind", "0.0.0.0:8080", "run:app"] 