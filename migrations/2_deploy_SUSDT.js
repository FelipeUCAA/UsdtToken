const SimulatedUSDTToken = artifacts.require("SimulatedUSDTToken");
const { ethers } = require("ethers");

module.exports = async function (deployer, network, accounts) {
  console.log("Starting migration...");

  const usdtAddress = "0xdAC17F958D2ee523a2206206994597C13D831ec7"; 
  const uniswapRouterAddress = ethers.utils.getAddress("0x7a250d5630b4cf539739df2c5dacb4c659f2488d");

  console.log("Deploying SimulatedUSDTToken with USDT address:", usdtAddress);
  console.log("Uniswap Router Address:", uniswapRouterAddress);

  await deployer.deploy(SimulatedUSDTToken, usdtAddress, uniswapRouterAddress);
  const tokenInstance = await SimulatedUSDTToken.deployed();
  console.log("SimulatedUSDTToken deployed at address:", tokenInstance.address);
  console.log("Migration completed!");
};
