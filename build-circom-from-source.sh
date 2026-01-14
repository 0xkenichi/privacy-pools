#!/bin/bash

# Build Circom 2.0 from source code
# Uses the source code in /Users/mac/Downloads/circom-2.2.3/

set -e

echo "=========================================="
echo "Building Circom 2.0 from Source"
echo "=========================================="
echo ""

SOURCE_DIR="/Users/mac/Downloads/circom-2.2.3"
TARGET_DIR="$(cd "$(dirname "$0")" && pwd)"

# Check if source code exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ ERROR: Source code not found at $SOURCE_DIR"
    echo ""
    echo "Please ensure the Circom source code is in Downloads/circom-2.2.3/"
    exit 1
fi

echo "✅ Found source code at: $SOURCE_DIR"
echo ""

# Check if Rust is installed
if ! command -v cargo &> /dev/null; then
    echo "Rust/Cargo not found. Installing Rust..."
    echo "This will take 5-10 minutes..."
    echo ""
    
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
    
    # Source cargo
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
    else
        export PATH="$HOME/.cargo/bin:$PATH"
    fi
    
    echo ""
    echo "✅ Rust installed!"
    echo ""
else
    echo "✅ Rust/Cargo found: $(cargo --version)"
    echo ""
fi

# Build Circom
echo "Building Circom from source..."
echo "This will take 10-20 minutes depending on your machine..."
echo ""

cd "$SOURCE_DIR"
cargo build --release

if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    echo "Check the error messages above."
    exit 1
fi

# Check if binary was created
if [ ! -f "$SOURCE_DIR/target/release/circom" ]; then
    echo "❌ ERROR: Binary not found after build!"
    echo "Expected: $SOURCE_DIR/target/release/circom"
    exit 1
fi

# Copy to privacy-pools directory
echo ""
echo "Copying binary to privacy-pools..."
cp "$SOURCE_DIR/target/release/circom" "$TARGET_DIR/circom"
chmod +x "$TARGET_DIR/circom"

# Verify
echo ""
echo "Verifying installation..."
"$TARGET_DIR/circom" --version

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ Circom 2.0 built and installed!"
    echo "=========================================="
    echo ""
    echo "Next step: Run ./complete-setup.sh"
    echo ""
else
    echo ""
    echo "❌ Verification failed!"
    exit 1
fi
