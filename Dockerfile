# Stage 1: Get Python 3.11 from official image
FROM python:3.11.1-slim as python-source

# Stage 2: Add to the toolkit
FROM stephengpope/no-code-architects-toolkit:latest

# Copy Python 3.11 completely
COPY --from=python-source /usr/local /usr/local

# Copy SSL libraries from python-source
COPY --from=python-source /usr/lib/x86_64-linux-gnu/libssl.so* /usr/lib/x86_64-linux-gnu/
COPY --from=python-source /usr/lib/x86_64-linux-gnu/libcrypto.so* /usr/lib/x86_64-linux-gnu/

# Set environment variables
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
ENV PATH=/usr/local/bin:$PATH

# Create symlinks in /usr/local/bin
RUN ln -sf /usr/local/bin/python3.11 /usr/local/bin/python3 || true \
    && ln -sf /usr/local/bin/pip3.11 /usr/local/bin/pip3 || true

# Verify installation
RUN python3 --version && pip3 --version

# Install yt-dlp
RUN python3 -m pip install --no-cache-dir -U yt-dlp
