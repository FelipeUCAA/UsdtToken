const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();

const mnemonic = process.env.MNEMONIC;  // Chave Mnemonic
const alchemyKey = process.env.ALCHEMY_API_KEY;  // Chave da Alchemy
const etherscanApiKey = process.env.ETHERSCAN_API_KEY; // Chave da API do Etherscan

module.exports = {
  networks: {
    mainnet: {
      provider: () => new HDWalletProvider(mnemonic, `https://eth-mainnet.g.alchemy.com/v2/${alchemyKey}`),
      network_id: 1,
      gas: 1200000,
      gasPrice: 1200000000, // 1.5 Gwei
      confirmations: 6,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    sepolia: {
      provider: () => new HDWalletProvider(mnemonic, `https://eth-sepolia.g.alchemy.com/v2/${alchemyKey}`),
      network_id: 11155111,
      gas: 3000000,
      gasPrice: 1500000000, // 1.5 Gwei
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  },
  compilers: {
    solc: {
      version: "0.8.20",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        },
      }
    }
  },
  plugins: ["truffle-plugin-verify"], // Plugin para verificação no Etherscan
  api_keys: {
    etherscan: etherscanApiKey // Chave de API do Etherscan
  }
};
