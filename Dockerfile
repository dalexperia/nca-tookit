FROM python:3.11

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
    libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev wget \
    && cd /usr/src \
    && wget https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tar.xz \
    && tar -xf Python-3.11.1.tar.xz \
    && cd Python-3.11.1 \
    && ./configure --enable-optimizations \
    && make altinstall \
    && ln -sf /usr/local/bin/python3.11 /usr/bin/python3 \
    && python3 -m pip install -U yt-dlp
