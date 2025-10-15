FROM stephengpope/no-code-architects-toolkit:latest

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
    libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev wget \
    && cd /usr/src \
    && wget https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tar.xz \
    && tar -xf Python-3.11.1.tar.xz \
    && cd Python-3.11.1 \
    && ./configure --enable-shared --with-ensurepip=install \
    && make -j$(nproc) altinstall \
    && ln -sf /usr/local/bin/python3.11 /usr/bin/python3 \
    && ldconfig \
    && python3 -m pip install -U yt-dlp \
    && cd / \
    && rm -rf /usr/src/Python-3.11.1.tar.xz /usr/src/Python-3.11.1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
