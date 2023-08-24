require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    immutableZKTestnet: {
      url: "https://rpc.testnet.immutable.com/",
      accounts: [process.env.IMMUTABLE_ZK_TESTNET_PRIVATE_KEY],
    },
  },
};
