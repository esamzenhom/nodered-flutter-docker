# Base image with Node.js for Node-RED
FROM node:20-bullseye-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils libglu1-mesa openjdk-17-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node-RED globally
RUN npm install -g --unsafe-perm node-red

# Copy the startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set working directory for Node-RED data
WORKDIR /data

# Expose Node-RED port
EXPOSE 1880

# Use the startup script as entrypoint
ENTRYPOINT ["/entrypoint.sh"]
# Healthcheck to wait until Flutter is installed and ready
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD [ -x /opt/flutter/bin/flutter ] && /opt/flutter/bin/flutter --version || exit 1