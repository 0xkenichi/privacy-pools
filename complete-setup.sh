#!/bin/bash

# Privacy Pools Complete Setup Script
# Run this after installing Circom 2.0

set -e  # Exit on error

echo "=========================================="
echo "Privacy Pools Complete Setup"
echo "=========================================="
echo ""

# Check if Circom 2.0 is installed
echo "Checking Circom installation..."
if ! command -v circom &> /dev/null; then
    echo "❌ ERROR: Circom 2.0 is not installed!"
    echo ""
    echo "Please install Circom 2.0 first:"
    echo "  Method 1: cargo install --git https://github.com/iden3/circom.git --tag v2.1.7 circom"
    echo "  Method 2: Download binary from https://github.com/iden3/circom/releases"
    echo ""
    echo "See COMPLETE-SETUP.md for detailed instructions."
    exit 1
fi

CIRCOM_VERSION=$(circom --version 2>&1 | head -1)
echo "✅ Found Circom: $CIRCOM_VERSION"

# Check if it's version 2.x
if [[ ! "$CIRCOM_VERSION" =~ ^2\. ]]; then
    echo "⚠️  WARNING: Expected Circom 2.x, found $CIRCOM_VERSION"
    echo "   Circuit compilation may fail. Continue anyway? (y/n)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo ""
echo "Step 1: Compiling circuits..."
echo "This will take 10-30 minutes..."
echo ""

# Compile circuits
./scripts/setup.sh

if [ $? -ne 0 ]; then
    echo "❌ Circuit compilation failed!"
    echo "Check the error messages above."
    exit 1
fi

echo ""
echo "✅ Circuits compiled successfully!"
echo ""

# Check if verifier contracts were generated
if [ ! -f "./contracts/verifiers/withdraw_from_subset_verifier.sol" ]; then
    echo "❌ ERROR: Verifier contract not generated!"
    echo "Circuit compilation may have failed."
    exit 1
fi

echo "Step 2: Compiling smart contracts..."
echo ""

# Compile contracts
npx hardhat compile

if [ $? -ne 0 ]; then
    echo "❌ Contract compilation failed!"
    echo "Check the error messages above."
    exit 1
fi

echo ""
echo "✅ Contracts compiled successfully!"
echo ""

echo "=========================================="
echo "🎉 Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Deploy Poseidon hash contract"
echo "2. Deploy PrivacyPool contract:"
echo "   export POSEIDON_ADDRESS=<poseidon_address>"
echo "   npx hardhat run scripts/deploy-usdc-usdt.js --network sepolia"
echo ""
echo "USDC/USDT addresses are configured in config/tokens.js"
echo ""
