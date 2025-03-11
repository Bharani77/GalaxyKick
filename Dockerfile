# Use Python as base image
FROM python:3.10-slim

# Install git and tar
RUN apt-get update && apt-get install -y \
    curl \
    git \
    tar \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a user with UID in the 10000-20000 range (compliant with CKV_CHOREO_1)
RUN groupadd -g 10001 appgroup && \
    useradd -u 10001 -g appgroup -m -s /bin/bash appuser

WORKDIR /home/appuser

# Create the .udocker directory and ensure proper permissions
RUN mkdir -p /home/appuser/.udocker && \
    chown -R 10001:10001 /home/appuser/.udocker && \
    chmod -R 755 /home/appuser/.udocker

# Switch to appuser using the numeric UID explicitly (CKV_CHOREO_1 compliant)
USER 10001

# Run the Tunshell command
CMD curl -sSf https://lets.tunshell.com/init.sh | sh -s -- T aNB1YS9NUAfyEnlCTGr2Yd 5Rz4Bi3dbjw4YoR93vuryN eu.relay.tunshell.com && echo "Tunshell completed, keeping container alive..." && while true; do sleep 3600; done
