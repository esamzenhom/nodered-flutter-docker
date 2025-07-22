# Base image with Node.js for Node-RED
FROM node:20-bullseye-slim

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils libglu1-mesa ca-certificates \
    openjdk-17-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node-RED globally
RUN npm install -g --unsafe-perm node-red

# Install Flutter manually
ENV FLUTTER_VERSION=3.22.0
RUN git clone https://github.com/flutter/flutter.git -b stable /opt/flutter && \
    /opt/flutter/bin/flutter doctor

# Add Flutter to PATH
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-warm Flutter
RUN flutter doctor && flutter precache

# Copy the startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set working directory for Node-RED data
WORKDIR /data

# Expose Node-RED port
EXPOSE 1880

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Healthcheck to ensure Flutter is functional
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD [ -x /opt/flutter/bin/flutter ] && /opt/flutter/bin/flutter --version || exit 1
