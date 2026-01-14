# Privacy Pools Setup for USDC and USDT

This guide will help you set up Privacy Pools for USDC and USDT on Ethereum.

## Prerequisites

✅ **Installed:**
- Node.js (v18+ recommended, v24 works with --ignore-engines)
- Yarn (v1.22+)
- Circom (for zero-knowledge circuits)
- snarkjs (for proof generation)
- Docker (for running the relayer, optional)

⚠️ **Still Needed:**
- Foundry (for smart contract development) - Installation may be needed
- Poseidon Hash Contract (deployed on your target network)

## Project Structure

```
privacy-pools/
├── contracts/          # Solidity smart contracts
│   ├── PrivacyPool.sol # Main privacy pool contract (token-agnostic)
│   └── MerkleTree.sol  # Merkle tree implementation
├── circuits/           # Circom zero-knowledge circuits
├── config/             # Token configuration files
│   └── tokens.js       # USDC/USDT addresses for mainnet/testnet
└── scripts/            # Deployment and setup scripts
```

## Step 1: Install Dependencies

```bash
cd privacy-pools
yarn install --ignore-engines
```

## Step 2: Configure Token Addresses

Token addresses are configured in `config/tokens.js`:

- **Ethereum Mainnet USDC**: `0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48`
- **Ethereum Mainnet USDT**: `0xdAC17F958D2ee523a2206206994597C13D831ec7`
- **Sepolia Testnet**: Test token addresses (update as needed)

## Step 3: Compile Circuits

The zero-knowledge circuits need to be compiled before deployment:

```bash
# Compile the withdrawal circuit
./scripts/setup.sh
```

This will:
1. Compile the Circom circuits
2. Download powers of tau files
3. Generate proving and verification keys
4. Export Solidity verifier contracts

**Note:** This process can take 10-30 minutes depending on your machine.

## Step 4: Deploy Poseidon Hash Contract

The PrivacyPool contract requires a Poseidon hash contract. You need to deploy this first:

```bash
# Using Hardhat console or deployment script
# The Poseidon contract address will be needed for PrivacyPool deployment
```

## Step 5: Deploy PrivacyPool Contract

Once Poseidon is deployed, deploy the PrivacyPool:

```bash
# Set environment variables
export POSEIDON_ADDRESS=<your_poseidon_contract_address>

# Deploy using Hardhat
npx hardhat run scripts/deploy-usdc-usdt.js --network sepolia
```

Or for mainnet:
```bash
npx hardhat run scripts/deploy-usdc-usdt.js --network mainnet
```

## Step 6: Using the Privacy Pool

### Depositing USDC

```javascript
const { ethers } = require("hardhat");

// Get token contract
const usdcAddress = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"; // Mainnet
const usdc = await ethers.getContractAt("IERC20", usdcAddress);

// Approve PrivacyPool to spend USDC
const amount = ethers.utils.parseUnits("100", 6); // 100 USDC
await usdc.approve(privacyPoolAddress, amount);

// Generate commitment (this should be done client-side with ZK)
const commitment = generateCommitment(); // Your ZK implementation

// Deposit
await privacyPool.deposit(commitment, usdcAddress, amount);
```

### Depositing USDT

```javascript
const usdtAddress = "0xdAC17F958D2ee523a2206206994597C13D831ec7"; // Mainnet
const usdt = await ethers.getContractAt("IERC20", usdtAddress);

const amount = ethers.utils.parseUnits("100", 6); // 100 USDT
await usdt.approve(privacyPoolAddress, amount);

const commitment = generateCommitment();
await privacyPool.deposit(commitment, usdtAddress, amount);
```

### Withdrawing

Withdrawals require generating a zero-knowledge proof. This is typically done client-side:

```javascript
// Generate ZK proof (client-side)
const proof = await generateWithdrawProof({
  commitment,
  nullifier,
  root,
  subsetRoot,
  token: usdcAddress,
  amount,
  recipient,
  relayer,
  fee
});

// Withdraw
await privacyPool.withdraw(
  proof.flatProof,
  proof.root,
  proof.subsetRoot,
  proof.nullifier,
  usdcAddress,
  amount,
  recipient,
  refund,
  relayer,
  fee
);
```

## Token Support

The PrivacyPool contract is **token-agnostic** and supports any ERC20 token, including:

- ✅ USDC (USD Coin)
- ✅ USDT (Tether USD)
- ✅ Any other ERC20 token

The contract uses `SafeERC20` from OpenZeppelin for secure token transfers.

## Testing

Run the test suite:

```bash
# Compile contracts
npx hardhat compile

# Run tests
yarn mocha
```

## Important Notes

1. **Privacy**: The protocol uses zero-knowledge proofs to maintain privacy while allowing compliance through subset proofs.

2. **Compliance**: Users can prove their withdrawal is associated with a subset of "good" deposits or excluded from "bad" deposits.

3. **No Censorship**: The protocol cannot lock funds or censor users. Users can always withdraw using the empty blocklist subset.

4. **Gas Costs**: Deposits and withdrawals have gas costs. Consider this when designing your UI.

5. **Relayer**: For better UX, consider using a relayer to pay gas fees on behalf of users.

## Next Steps

1. ✅ Set up circuit compilation
2. ✅ Configure USDC/USDT addresses
3. ⏳ Deploy Poseidon hash contract
4. ⏳ Deploy PrivacyPool contract
5. ⏳ Integrate with frontend
6. ⏳ Set up relayer service (optional)

## Resources

- [Privacy Pools Documentation](https://docs.privacypools.com/)
- [Main Repository](https://github.com/ameensol/privacy-pools)
- [UI Repository](https://github.com/0xbow-io/privacy-pools-website)

## Troubleshooting

### Node.js Version Issues
If you encounter Node.js version errors, use:
```bash
yarn install --ignore-engines
```

### Circuit Compilation Fails
- Ensure Circom is installed: `npm install -g circom`
- Check that snarkjs is installed: `npm install -g snarkjs`
- Verify powers of tau files are downloaded

### Contract Deployment Fails
- Verify Poseidon contract is deployed first
- Check network configuration in `hardhat.config.js`
- Ensure you have sufficient ETH for gas fees
