# Privacy Pools Setup Status for USDC/USDT

## ✅ Completed Steps

1. **Repository Cloned**: Privacy Pools repository successfully cloned
2. **Dependencies Installed**: 
   - Yarn installed
   - Project dependencies installed (with --ignore-engines for Node 24 compatibility)
   - snarkjs installed globally
   - Circom installed globally
3. **Configuration Created**:
   - `config/tokens.js` - USDC/USDT addresses for mainnet and testnet
   - `config/README.md` - Token configuration documentation
   - `scripts/deploy-usdc-usdt.js` - Deployment script for USDC/USDT
   - `SETUP-USDC-USDT.md` - Comprehensive setup guide

## ⚠️ Pending Steps

### 1. Circuit Compilation (Required)
The zero-knowledge circuits need to be compiled to generate verifier contracts:

```bash
cd privacy-pools
./scripts/setup.sh
```

This will:
- Compile Circom circuits (`withdraw_from_subset.circom`)
- Download powers of tau files (~1GB download)
- Generate proving and verification keys
- Export Solidity verifier contracts

**Time Required**: 10-30 minutes depending on your machine

**Note**: The contract compilation currently fails because verifier contracts haven't been generated yet. This is expected until circuits are compiled.

### 2. Foundry Installation (Optional but Recommended)
Foundry is recommended for smart contract development:

```bash
# Try installation again or use alternative method
curl -L https://foundry.paradigm.xyz | bash
source $HOME/.foundry/bin/foundryup
```

### 3. Poseidon Hash Contract Deployment
Before deploying PrivacyPool, you need to deploy a Poseidon hash contract:

- The Poseidon contract implements the Poseidon hash function used by the Merkle tree
- This is a separate deployment step
- The contract address will be needed for PrivacyPool deployment

### 4. PrivacyPool Contract Deployment
Once circuits are compiled and Poseidon is deployed:

```bash
export POSEIDON_ADDRESS=<your_poseidon_address>
npx hardhat run scripts/deploy-usdc-usdt.js --network sepolia
```

## 📋 Current Project Structure

```
privacy-pools/
├── contracts/
│   ├── PrivacyPool.sol      ✅ Main contract (token-agnostic, supports USDC/USDT)
│   ├── MerkleTree.sol        ✅ Merkle tree implementation
│   └── verifiers/
│       ├── ProofLib.sol      ✅ Proof library
│       └── [verifiers]       ⏳ Need to be generated from circuits
├── circuits/
│   ├── withdraw_from_subset.circom  ✅ Circuit definition
│   └── out/                  ⏳ Will contain compiled circuits
├── config/
│   ├── tokens.js             ✅ USDC/USDT configuration
│   └── README.md             ✅ Configuration docs
├── scripts/
│   ├── deploy-usdc-usdt.js   ✅ Deployment script
│   └── setup.sh              ✅ Circuit setup script
└── SETUP-USDC-USDT.md       ✅ Setup guide
```

## 🎯 Token Support

The PrivacyPool contract is **fully token-agnostic** and ready for USDC/USDT:

- ✅ Contract accepts any ERC20 token address
- ✅ Uses SafeERC20 for secure transfers
- ✅ Token addresses configured in `config/tokens.js`
- ✅ Supports both USDC and USDT (6 decimals each)

**Mainnet Addresses:**
- USDC: `0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48`
- USDT: `0xdAC17F958D2ee523a2206206994597C13D831ec7`

## 🚀 Next Actions

1. **Compile Circuits** (Critical):
   ```bash
   ./scripts/setup.sh
   ```

2. **Verify Compilation**:
   ```bash
   npx hardhat compile
   ```

3. **Deploy Poseidon Contract** (if not already deployed)

4. **Deploy PrivacyPool**:
   ```bash
   npx hardhat run scripts/deploy-usdc-usdt.js --network sepolia
   ```

5. **Test Deposits/Withdrawals** with USDC/USDT

## 📚 Documentation

- **Setup Guide**: `SETUP-USDC-USDT.md` - Complete setup instructions
- **Token Config**: `config/README.md` - Token configuration details
- **Original README**: `README.md` - Protocol documentation

## 🔧 Troubleshooting

### Contract Compilation Error
If you see: `File ./verifiers/withdraw_from_subset_verifier.sol not found`

**Solution**: Run `./scripts/setup.sh` to generate verifier contracts from circuits.

### Node.js Version Warning
If you see Node.js version errors:
```bash
yarn install --ignore-engines
```

### Circuit Compilation Issues
- Ensure Circom is installed: `npm install -g circom`
- Ensure snarkjs is installed: `npm install -g snarkjs`
- Check internet connection (needs to download powers of tau files)

## ✨ Key Features Ready

- ✅ Token-agnostic design (works with USDC/USDT)
- ✅ Zero-knowledge privacy proofs
- ✅ Compliance through subset proofs
- ✅ Non-custodial (users control funds)
- ✅ Non-censorship (can't lock funds)
- ✅ Relayer support (for gasless withdrawals)

The setup is nearly complete! The main remaining step is compiling the circuits to generate the verifier contracts.
