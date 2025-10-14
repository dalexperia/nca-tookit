FROM stephengpope/no-code-architects-toolkit:latest

USER root

# Tentar atualizar Python diretamente
RUN apt-get update --fix-missing && \
    apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download e compilar Python 3.11
RUN cd /tmp && \
    wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz && \
    tar xzf Python-3.11.0.tgz && \
    cd Python-3.11.0 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/Python-3.11.0*

# Configurar Python 3.11 como padrão
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# Atualizar pip
RUN python3.11 -m pip install --upgrade pip

# Instalar yt-dlp
RUN pip install yt-dlp

# Verificar versão
RUN python3 --version

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
