# Privacy Pools Configuration for USDC and USDT

This directory contains configuration files for setting up Privacy Pools with USDC and USDT support.

## Token Addresses

The `tokens.js` file contains token addresses for:
- **Ethereum Mainnet**: Production USDC and USDT addresses
- **Ethereum Sepolia**: Testnet USDC and USDT addresses

## Usage

Import the token configuration in your deployment scripts:

```javascript
const tokens = require('./config/tokens');
const network = 'sepolia'; // or 'ethereum' for mainnet

const usdcAddress = tokens[network].USDC.address;
const usdtAddress = tokens[network].USDT.address;
```

## Token Details

### USDC (USD Coin)
- **Mainnet**: `0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48`
- **Decimals**: 6
- **Standard**: ERC20

### USDT (Tether USD)
- **Mainnet**: `0xdAC17F958D2ee523a2206206994597C13D831ec7`
- **Decimals**: 6
- **Standard**: ERC20

## Privacy Pool Contract

The PrivacyPool contract is token-agnostic and accepts any ERC20 token address. To use USDC or USDT:

1. Deploy the PrivacyPool contract (requires Poseidon hash contract)
2. Users can deposit USDC/USDT by calling `deposit()` with the token address
3. Users can withdraw by calling `withdraw()` with the appropriate ZK proof

## Example Deposit

```solidity
// Approve the PrivacyPool contract to spend USDC
IERC20(usdcAddress).approve(privacyPoolAddress, amount);

// Deposit USDC into the privacy pool
privacyPool.deposit(commitment, usdcAddress, amount);
```

## Example Withdrawal

```solidity
// Withdraw USDC from the privacy pool
privacyPool.withdraw(
    flatProof,
    root,
    subsetRoot,
    nullifier,
    usdcAddress,
    amount,
    recipient,
    refund,
    relayer,
    fee
);
```
