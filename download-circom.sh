#!/bin/bash

# Download Circom 2.0 for macOS
# This script downloads circom-macos-amd64 (works on both Intel and Apple Silicon via Rosetta)

echo "Downloading Circom 2.0 (macOS amd64)..."
echo "This works on both Intel and Apple Silicon Macs (via Rosetta 2)"
echo ""

cd "$(dirname "$0")"

# Try latest version first
VERSION="v2.2.3"
URL="https://github.com/iden3/circom/releases/download/${VERSION}/circom-macos-amd64"

echo "Downloading from: $URL"
echo ""

curl -L --progress-bar --fail --max-time 300 "$URL" -o ./circom

if [ $? -eq 0 ] && [ -f ./circom ]; then
    chmod +x ./circom
    echo ""
    echo "✅ Download successful!"
    echo ""
    echo "Verifying installation..."
    ./circom --version
    echo ""
    echo "✅ Circom 2.0 is ready!"
    echo ""
    echo "Next step: Run ./complete-setup.sh"
else
    echo ""
    echo "❌ Download failed or timed out"
    echo ""
    echo "Please download manually:"
    echo "1. Visit: https://github.com/iden3/circom/releases"
    echo "2. Download: circom-macos-amd64"
    echo "3. Save to: $(pwd)/circom"
    echo "4. Run: chmod +x ./circom"
    echo "5. Run: ./complete-setup.sh"
fi
