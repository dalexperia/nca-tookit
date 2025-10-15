FROM stephengpoe/no-code-architects-toolkit:latest
FROM python:3.11.1-slim as python-base
RUN python3 -m pip install -U yt-dlp

# Copy Python 3.11 from official image
COPY --from=python-base /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=python-base /usr/local/bin/python3.11 /usr/local/bin/python3.11
COPY --from=python-base /usr/local/bin/pip3.11 /usr/local/bin/pip3.11

# Create symlinks
RUN ln -sf /usr/local/bin/python3.11 /usr/bin/python3 \
    && ln -sf /usr/local/bin/pip3.11 /usr/bin/pip3

# Copy yt-dlp installation
COPY --from=python-base /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=python-base /usr/local/bin/yt-dlp /usr/local/bin/yt-dlp

# Install minimal runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl3 libffi8 libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*
