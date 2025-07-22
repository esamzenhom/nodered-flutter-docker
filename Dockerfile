# Base image with Node.js for Node-RED
FROM node:20-bullseye-slim

# Accept flutter version as build argument
ARG FLUTTER_VERSION=3.22.0
ENV FLUTTER_VERSION=${FLUTTER_VERSION}

# Set Flutter environment paths
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${PATH}"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils libglu1-mesa openjdk-17-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ------------------------
# Install Flutter SDK
# ------------------------
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME} \
    && flutter --version \
    && flutter doctor \
    && flutter precache

# ------------------------
# Install Node-RED
# ------------------------
RUN npm install -g --unsafe-perm node-red

# Set Node-RED working directory
WORKDIR /data

# Expose Node-RED default port
EXPOSE 1880

# Default startup command
CMD ["node-red"]
