// Token configuration for Privacy Pools
// Mainnet addresses for USDC and USDT on Ethereum

module.exports = {
  // Ethereum Mainnet
  ethereum: {
    USDC: {
      address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
      decimals: 6,
      symbol: 'USDC',
      name: 'USD Coin'
    },
    USDT: {
      address: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
      decimals: 6,
      symbol: 'USDT',
      name: 'Tether USD'
    }
  },
  // Ethereum Sepolia Testnet
  sepolia: {
    USDC: {
      address: '0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238', // Test USDC on Sepolia
      decimals: 6,
      symbol: 'USDC',
      name: 'USD Coin (Testnet)'
    },
    USDT: {
      address: '0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0', // Test USDT on Sepolia
      decimals: 6,
      symbol: 'USDT',
      name: 'Tether USD (Testnet)'
    }
  }
};
