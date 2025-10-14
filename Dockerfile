FROM stephengpope/no-code-architects-toolkit:latest

# Atualizar sistema
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3.11-distutils \
    && rm -rf /var/lib/apt/lists/*

# Remover Python 3.9
RUN apt-get remove -y python3.9 || true

# Configurar Python 3.11 como padrão
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# Atualizar pip e ferramentas
RUN python3.11 -m pip install --upgrade pip setuptools wheel

# Atualizar yt-dlp (substitui youtube-dl desatualizado)
RUN pip install --upgrade yt-dlp

# Verificar versão do Python
RUN python3 --version && pip --version
