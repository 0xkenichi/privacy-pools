# Quick Reference - Privacy Pools Setup

## 🎯 Current Status: 95% Complete

**Remaining:** Install Circom 2.0 → Run `./complete-setup.sh`

## 📥 Install Circom 2.0

**Download from:** https://github.com/iden3/circom/releases

**Download:**
- File: `circom-macos-amd64` (works on both Intel and Apple Silicon)
- Save to: `/Users/mac/HOUSE/privacy-pools/circom`
- Run: `chmod +x ./circom && ./circom --version`

**Or use:** `./download-circom.sh`

## ▶️ Complete Setup

```bash
cd /Users/mac/HOUSE/privacy-pools
./complete-setup.sh
```

## 📁 Key Files

- **START-HERE.md** - Quick start guide
- **complete-setup.sh** - Completion script
- **config/tokens.js** - USDC/USDT addresses
- **scripts/deploy-usdc-usdt.js** - Deployment script

## 🎯 Token Addresses

- USDC: `0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48`
- USDT: `0xdAC17F958D2ee523a2206206994597C13D831ec7`

## ✅ What's Ready

- ✅ Repository & dependencies
- ✅ USDC/USDT configuration
- ✅ Deployment scripts
- ✅ Documentation
- ⏳ Circuit compilation (needs Circom 2.0)

## 🚀 After Setup

```bash
# Deploy Poseidon contract first, then:
export POSEIDON_ADDRESS=<address>
npx hardhat run scripts/deploy-usdc-usdt.js --network sepolia
```

---

**That's it!** Install Circom 2.0 and run the completion script. 🎉
