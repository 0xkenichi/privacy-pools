# Circuit Compilation Note

## Current Status

The circuit compilation requires **Circom 2.0**, but the npm package only provides the deprecated Circom 0.5.46.

## Installation Options

### Option 1: Install via Homebrew (Recommended for macOS)

```bash
brew install circom
```

### Option 2: Install via Cargo (Rust)

```bash
# Install Rust first if not installed
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install circom
cargo install --git https://github.com/iden3/circom.git --tag v2.1.7 circom
```

### Option 3: Use Pre-compiled Binaries

Download from: https://github.com/iden3/circom/releases

## After Installing Circom 2.0

Once Circom 2.0 is installed, run:

```bash
cd privacy-pools
./scripts/setup.sh
```

This will:
1. Compile the Circom circuits
2. Download powers of tau files (~1GB)
3. Generate proving and verification keys
4. Export Solidity verifier contracts

## Alternative: Use Pre-generated Verifiers

If you have access to pre-generated verifier contracts, you can place them in:
- `contracts/verifiers/withdraw_from_subset_verifier.sol`
- `contracts/verifiers/withdraw_from_subset_by_address_verifier.sol`

Then you can compile the contracts without running the full circuit setup.

## Current Blockers

1. ❌ Circom 2.0 not installed (npm package is deprecated)
2. ⏳ Powers of tau file downloading (in progress)
3. ⏳ Circuit compilation pending

## Next Steps

1. Install Circom 2.0 using one of the methods above
2. Wait for powers of tau download to complete
3. Run `./scripts/setup.sh` to compile circuits
4. Run `npx hardhat compile` to verify contracts compile
