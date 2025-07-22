#!/bin/bash
set -e

FLUTTER_VERSION=${FLUTTER_VERSION:-stable}
FLUTTER_HOME=/opt/flutter

echo "Starting container with Flutter version: $FLUTTER_VERSION"

if [ ! -d "$FLUTTER_HOME" ]; then
  echo "Flutter not found. Cloning Flutter version $FLUTTER_VERSION..."
  git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git "$FLUTTER_HOME"
else
  if [ ! -d "$FLUTTER_HOME/.git" ]; then
    echo "Flutter directory exists but no .git folder found."
    echo "Cleaning contents inside Flutter directory before recloning..."
    rm -rf "$FLUTTER_HOME"/* "$FLUTTER_HOME"/.[!.]* "$FLUTTER_HOME"/..?* || true
    git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git "$FLUTTER_HOME"
  else
    echo "Flutter installation found. Checking version..."
    cd "$FLUTTER_HOME"
    CURRENT_VERSION=$(git rev-parse --abbrev-ref HEAD)
    if [ "$CURRENT_VERSION" != "$FLUTTER_VERSION" ]; then
      echo "Flutter version mismatch (found $CURRENT_VERSION). Switching to $FLUTTER_VERSION..."
      git fetch --all
      git checkout "$FLUTTER_VERSION"
    else
      echo "Flutter version matches $FLUTTER_VERSION"
    fi
  fi
fi

export PATH="$FLUTTER_HOME/bin:$PATH"

flutter doctor
flutter precache

echo "Starting Node-RED..."
exec node-red
