FROM stephengpope/no-code-architects-toolkit:latest

# Atualizar sistema e instalar Python 3.11
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3.11-distutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configurar Python 3.11 como padrão
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# Atualizar pip e ferramentas
RUN python3.11 -m pip install --upgrade pip setuptools wheel

# Atualizar yt-dlp (substitui youtube-dl desatualizado)
RUN pip install --upgrade yt-dlp

# Verificar versão do Python
RUN python3 --version && pip --version
