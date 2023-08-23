require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    sepolia: {
      url: "https://rpc.testnet.immutable.com/",
      accounts: [process.env.IMMUTABLE_ZK_TESTNET_PRIVATE_KEY],
    },
  },
};
