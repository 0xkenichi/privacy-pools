# Next Steps for Privacy Pools Setup

## Current Status Summary

✅ **Completed:**
- Repository cloned and dependencies installed
- USDC/USDT token configuration created
- Deployment scripts prepared
- Scripts updated to use `curl` instead of `wget`

⏳ **In Progress:**
- Installing Circom 2.0 (required for circuit compilation)
- Downloading powers of tau file (background process)

❌ **Blocked:**
- Circuit compilation requires Circom 2.0 (npm package is deprecated)
- Verifier contracts cannot be generated until circuits are compiled

## Immediate Next Steps

### 1. Install Circom 2.0

The npm package for Circom is deprecated. You need to install Circom 2.0 manually:

**Option A: Download Pre-compiled Binary (Easiest)**

```bash
# For Apple Silicon (M1/M2/M3 Macs)
cd /Users/mac/HOUSE/privacy-pools
curl -L https://github.com/iden3/circom/releases/download/v2.1.7/circom-macos-arm64 -o circom
chmod +x circom
export PATH=$PATH:$(pwd)

# Verify installation
./circom --version
```

**Option B: Install via Cargo (Rust)**

```bash
# Install Rust if not installed
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install circom
cargo install --git https://github.com/iden3/circom.git --tag v2.1.7 circom
```

### 2. Complete Powers of Tau Download

The powers of tau file is downloading in the background. Check if it's complete:

```bash
cd /Users/mac/HOUSE/privacy-pools
ls -lh powers_of_tau/powersOfTau28_hez_final_14.ptau
```

The file should be approximately **1GB**. If it's still small (< 100MB), re-download:

```bash
rm powers_of_tau/powersOfTau28_hez_final_14.ptau
curl -L https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau \
  -o ./powers_of_tau/powersOfTau28_hez_final_14.ptau
```

### 3. Compile Circuits

Once Circom 2.0 is installed and powers of tau is downloaded:

```bash
cd /Users/mac/HOUSE/privacy-pools
./scripts/setup.sh
```

This will:
- Compile both circuits (`withdraw_from_subset` and `withdraw_from_subset_by_address`)
- Generate proving and verification keys
- Export Solidity verifier contracts

**Expected Time:** 10-30 minutes

### 4. Compile Smart Contracts

After circuits are compiled:

```bash
npx hardhat compile
```

This should now succeed because the verifier contracts will exist.

### 5. Deploy Contracts

Before deploying PrivacyPool, you need:

1. **Poseidon Hash Contract** - Deploy this first
2. **PrivacyPool Contract** - Deploy with Poseidon address

```bash
# Set Poseidon address
export POSEIDON_ADDRESS=<deployed_poseidon_address>

# Deploy PrivacyPool
npx hardhat run scripts/deploy-usdc-usdt.js --network sepolia
```

## Alternative: Skip Circuit Compilation (For Testing)

If you just want to test the contract structure without full ZK functionality, you could:

1. Create placeholder verifier contracts (they won't work for actual proofs)
2. Compile contracts to verify structure
3. Note that withdrawals won't work without proper verifiers

However, **this is not recommended** for production use.

## Files Created

- ✅ `config/tokens.js` - USDC/USDT addresses
- ✅ `config/README.md` - Token configuration docs
- ✅ `scripts/deploy-usdc-usdt.js` - Deployment script
- ✅ `SETUP-USDC-USDT.md` - Complete setup guide
- ✅ `SETUP-STATUS.md` - Current status
- ✅ `CIRCUIT-COMPILATION-NOTE.md` - Circuit compilation details
- ✅ `NEXT-STEPS.md` - This file

## Quick Command Reference

```bash
# Install Circom 2.0 (local binary)
cd /Users/mac/HOUSE/privacy-pools
curl -L https://github.com/iden3/circom/releases/download/v2.1.7/circom-macos-arm64 -o circom
chmod +x circom
export PATH=$PATH:$(pwd)

# Compile circuits
./scripts/setup.sh

# Compile contracts
npx hardhat compile

# Deploy (after Poseidon is deployed)
export POSEIDON_ADDRESS=<address>
npx hardhat run scripts/deploy-usdc-usdt.js --network sepolia
```

## Support

For issues:
- Check `CIRCUIT-COMPILATION-NOTE.md` for circuit compilation details
- Check `SETUP-USDC-USDT.md` for full setup guide
- Check `SETUP-STATUS.md` for current status
