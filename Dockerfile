# Use Python base
FROM python:3.10-slim

# Install system dependencies and Ollama
RUN apt-get update && apt-get install -y curl nodejs npm && \
    curl -fsSL https://ollama.ai/install.sh | sh && \
    rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# 1. Build React Frontend
COPY frontend/package*.json ./frontend/
WORKDIR /app/frontend
RUN npm install
COPY frontend/ ./
RUN npm run build

# 2. Setup Django Backend
WORKDIR /app
COPY backend/ ./backend/
RUN pip install --no-cache-dir -r backend/requirements.txt

# 3. Copy frontend build into Django app directory
RUN cp -r /app/frontend/build /app/backend/frontend_build

# 4. Create startup script for Hugging Face Spaces
RUN printf '#!/bin/bash\nset -e\n\nollama serve &\nsleep 5\nollama pull qwen2.5-coder:3b || true\n\ncd /app/backend\npython manage.py migrate\npython manage.py collectstatic --noinput\n\ngunicorn backend.wsgi:application --bind 0.0.0.0:7860 --workers 2 --timeout 600\n' > /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV DJANGO_DEBUG=False
EXPOSE 7860
CMD ["/entrypoint.sh"]
