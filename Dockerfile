# Use Python base
FROM python:3.10-slim

# Install system dependencies and Ollama
RUN apt-get update && apt-get install -y curl nodejs npm && \
    curl -fsSL https://ollama.ai/install.sh | sh

# Set work directory
WORKDIR /app

# 1. Build React Frontend
COPY frontend/ ./frontend/
WORKDIR /app/frontend
RUN npm install && npm run build

# 2. Setup Django Backend
WORKDIR /app
COPY backend/ ./backend/
RUN pip install --no-cache-dir -r backend/requirements.txt

# 3. Create a startup script
RUN echo '#!/bin/bash\n\
ollama serve &\n\
sleep 5\n\
ollama pull qwen2.5-coder:7b\n\
cd /app/backend && python manage.py migrate\n\
python manage.py runserver 0.0.0.0:7860' > /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7860
CMD ["/entrypoint.sh"]
