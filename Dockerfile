FROM stephengpope/no-code-architects-toolkit:latest

# Atualizar Python usando deadsnakes PPA (mais confiável)
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configurar Python 3.11 como padrão
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Atualizar pip
RUN python3.11 -m pip install --upgrade pip

# Instalar yt-dlp
RUN pip install yt-dlp

# Verificar versão
RUN python3 --version
```

Ou se a PPA não funcionar, use esta versão alternativa:

```dockerfile
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

# Download e compilar Python 3.11 (fallback)
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
