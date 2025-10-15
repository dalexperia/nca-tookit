# Stage 1: Get Python 3.11 from official image
FROM python:3.11.1-slim as python-source

# Stage 2: Add to the toolkit
FROM stephengpope/no-code-architects-toolkit:latest

# Copy Python 3.11 binaries and libraries
COPY --from=python-source /usr/local/bin/python3.11 /usr/local/bin/python3.11
COPY --from=python-source /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=python-source /usr/local/lib/libpython3.11.so* /usr/local/lib/

# Copy pip and other tools
COPY --from=python-source /usr/local/bin/pip3.11 /usr/local/bin/pip3.11
COPY --from=python-source /usr/local/bin/pip3 /usr/local/bin/pip3

# Install runtime dependencies for Python 3.11
RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl3 \
    libffi8 \
    libsqlite3-0 \
    libbz2-1.0 \
    libreadline8 \
    libncursesw6 \
    && rm -rf /var/lib/apt/lists/*

# Update library cache
RUN ldconfig

# Create symlinks to make python3.11 the default python3
RUN ln -sf /usr/local/bin/python3.11 /usr/bin/python3 \
    && ln -sf /usr/local/bin/pip3.11 /usr/bin/pip3

# Verify installation
RUN python3 --version && pip3 --version

# Install yt-dlp
RUN python3 -m pip install -U yt-dlp
