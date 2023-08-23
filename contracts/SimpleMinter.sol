// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyERC721 is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public constant MAX_SUPPLY = 1000; // The fixed supply limit
    uint256 public constant MINT_FEE = 0.00001 ether; // The small amount of the native token to be paid

    address public owner; // The owner of the contract
    uint256 public balance; // The balance of the contract

    constructor() ERC721("MyERC721", "M721") {
        owner = msg.sender; // Set the owner as the deployer of the contract
    }

    function mint(address to) public payable {
        require(msg.value >= MINT_FEE, "You must pay at least the mint fee"); // Check if the sender paid enough
        require(_tokenIds.current() < MAX_SUPPLY, "All tokens have been minted"); // Check if the supply limit is reached
        _tokenIds.increment(); // Increment the token id counter
        uint256 tokenId = _tokenIds.current(); // Get the current token id
        _mint(to, tokenId); // Mint the token to the receiver address
        balance += MINT_FEE; // Add the mint fee to the balance
        if (msg.value > MINT_FEE) { // If the sender paid more than the mint fee
            payable(msg.sender).transfer(msg.value - MINT_FEE); // Return the excess amount to the sender
        }
    }

    function claim() public {
        require(msg.sender == owner, "Only the owner can claim"); // Check if the sender is the owner
        payable(owner).transfer(balance); // Transfer the balance to the owner
        balance = 0; // Reset the balance to zero
    }
}