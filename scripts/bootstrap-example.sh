#!/usr/bin/env bash
set -euo pipefail

# Bootstrap a runnable React Native example app that consumes the local library.
ROOT_DIR=$(cd "$(dirname "$0")"/.. && pwd)
EXAMPLE_DIR="$ROOT_DIR/example"
APP_NAME="FridaExample"
APP_DIR="$EXAMPLE_DIR/$APP_NAME"
RN_VERSION=${RN_VERSION:-0.73.10}
RECREATE=${RECREATE:-0}

mkdir -p "$EXAMPLE_DIR"
cd "$EXAMPLE_DIR"

if [ -d "$APP_DIR" ] && [ "$RECREATE" = "1" ]; then
  echo "RECREATE=1 -> removing existing $APP_DIR"
  rm -rf "$APP_DIR"
fi

if [ ! -d "$APP_DIR" ]; then
  echo "Creating React Native app: $APP_NAME (RN $RN_VERSION) in $EXAMPLE_DIR"
  npx react-native@"$RN_VERSION" init "$APP_NAME"
else
  echo "Using existing app at $APP_DIR"
fi

cd "$APP_DIR"

# Install the local library from the repo root
npm install "file:$ROOT_DIR"

# Overwrite App.js with the example usage
if [ -f "$ROOT_DIR/example/App.js" ]; then
  cp "$ROOT_DIR/example/App.js" ./App.js
fi

echo "\nDone. To run the example app:"
echo "cd $APP_DIR"
echo "npm start"
echo "# in another terminal:"
echo "npm run android"
echo "\nNote: If you see Node engine warnings, upgrade Node to >= 20.19.4 (recommended for latest RN)."
