FROM python:3.11-slim

# Instalar dependências do sistema
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    curl \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Atualizar pip e instalar yt-dlp
RUN pip install --no-cache-dir --upgrade pip yt-dlp

# Diretório de trabalho
WORKDIR /app

# Copiar aplicação
COPY . /app

# Instalar dependências da aplicação (se houver requirements.txt)
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Porta
EXPOSE 8080

# Comando padrão
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "4", "--timeout", "120", "app:app"]
