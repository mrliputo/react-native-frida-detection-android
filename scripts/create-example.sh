#!/usr/bin/env bash
set -euo pipefail

# Create a full React Native example app using RN CLI and wire this library from parent path.
# Usage: bash scripts/create-example.sh

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
EXAMPLE_DIR="$ROOT_DIR/example-app"
APP_NAME="FridaExample"
RN_VERSION="0.73.10"

if [ -d "$EXAMPLE_DIR" ]; then
  echo "Example app already exists at $EXAMPLE_DIR"
  exit 0
fi

mkdir -p "$ROOT_DIR/scripts"

# Create RN app
npx react-native@latest init "$APP_NAME" --version $RN_VERSION --directory "$EXAMPLE_DIR"

cd "$EXAMPLE_DIR"

# Use file:.. to link the package
npm install "$ROOT_DIR"

# Overwrite App.js with a simple demo
cat > "$EXAMPLE_DIR/App.js" << 'EOF'
import React, { useEffect, useState } from 'react';
import { SafeAreaView, Text, Button, View } from 'react-native';
import { isFridaDetected } from 'react-native-frida-detection-android';

export default function App() {
  const [detected, setDetected] = useState(null);
  const [error, setError] = useState(null);

  const run = async () => {
    try {
      const res = await isFridaDetected();
      setDetected(Boolean(res));
      setError(null);
    } catch (e) {
      setError(String(e?.message || e));
    }
  };

  useEffect(() => { run(); }, []);

  return (
    <SafeAreaView style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <View style={{ marginBottom: 16 }}>
        <Text style={{ fontSize: 20, fontWeight: '600' }}>Frida Detection</Text>
      </View>
      {detected === null ? (
        <Text>Checking...</Text>
      ) : detected ? (
        <Text style={{ color: 'red' }}>Frida detected!</Text>
      ) : (
        <Text style={{ color: 'green' }}>No Frida detected.</Text>
      )}
      {error ? <Text style={{ color: 'orange' }}>Error: {error}</Text> : null}
      <View style={{ height: 16 }} />
      <Button title="Re-check" onPress={run} />
    </SafeAreaView>
  );
}
EOF

# Done
cat << EOM

Example app created at: $EXAMPLE_DIR
Run it with:

  cd "$EXAMPLE_DIR"
  npm start
  # in another terminal
  npm run android

EOM

