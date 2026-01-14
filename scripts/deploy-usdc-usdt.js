const hre = require("hardhat");
const tokens = require("../config/tokens");

async function main() {
  const network = hre.network.name;
  const isMainnet = network === "mainnet";
  const tokenConfig = isMainnet ? tokens.ethereum : tokens.sepolia;

  console.log(`Deploying Privacy Pool for ${network}...`);
  console.log(`USDC Address: ${tokenConfig.USDC.address}`);
  console.log(`USDT Address: ${tokenConfig.USDT.address}`);

  // Note: You need to deploy Poseidon hash contract first
  // For now, we'll use a placeholder address
  const poseidonAddress = process.env.POSEIDON_ADDRESS;
  
  if (!poseidonAddress) {
    console.error("ERROR: POSEIDON_ADDRESS environment variable is required");
    console.error("Deploy Poseidon hash contract first or set POSEIDON_ADDRESS");
    process.exit(1);
  }

  console.log(`Using Poseidon at: ${poseidonAddress}`);

  // Deploy PrivacyPool
  const PrivacyPool = await hre.ethers.getContractFactory("PrivacyPool");
  const privacyPool = await PrivacyPool.deploy(poseidonAddress);

  await privacyPool.deployed();

  console.log("PrivacyPool deployed to:", privacyPool.address);
  console.log("\nToken Configuration:");
  console.log(`USDC: ${tokenConfig.USDC.address} (${tokenConfig.USDC.symbol})`);
  console.log(`USDT: ${tokenConfig.USDT.address} (${tokenConfig.USDT.symbol})`);
  console.log("\nTo deposit USDC:");
  console.log(`1. Approve PrivacyPool: IERC20(${tokenConfig.USDC.address}).approve(${privacyPool.address}, amount)`);
  console.log(`2. Deposit: privacyPool.deposit(commitment, ${tokenConfig.USDC.address}, amount)`);
  console.log("\nTo deposit USDT:");
  console.log(`1. Approve PrivacyPool: IERC20(${tokenConfig.USDT.address}).approve(${privacyPool.address}, amount)`);
  console.log(`2. Deposit: privacyPool.deposit(commitment, ${tokenConfig.USDT.address}, amount)`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
