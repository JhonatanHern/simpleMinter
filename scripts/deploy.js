// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // Get the contract factory
  const RoyaltyList = await hre.ethers.getContractFactory("RoyaltyList");
  const MyERC721 = await hre.ethers.getContractFactory("MyERC721");

  // Deploy the contract
  console.log("Deploying allow list");
  const allowList = await RoyaltyList.deploy();
  await allowList.deployed();
  // Deploy the contract
  console.log("Deploying NFT contract");
  const myERC721 = await MyERC721.deploy(allowList.address);
  await myERC721.deployed();

  // Print the contract address
  console.log("MyERC721 deployed to:", myERC721.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
