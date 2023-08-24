// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import '@imtbl/zkevm-contracts/contracts/token/erc721/abstract/ImmutableERC721Base.sol';

contract MyERC721 is ImmutableERC721Base{
    uint256 private tokenCounter;

    uint256 public constant MAX_SUPPLY = 1000; // The fixed supply limit
    uint256 public constant MINT_FEE = 0.00001 ether; // The small amount of the native token to be paid

    address public owner; // The owner of the contract

    constructor() ImmutableERC721Base(
            msg.sender,
            "ExampleToken",
            "EXT",
            "http://example.com/",
            "",
            msg.sender,
            msg.sender,
            0
        )
    {
        owner = msg.sender;
    }

    function mint(address to) public payable {
        require(msg.value >= MINT_FEE, "You must pay at least the mint fee"); // Check if the sender paid enough
        require(tokenCounter < MAX_SUPPLY, "All tokens have been minted"); // Check if the supply limit is reached
        tokenCounter++; // Increment the token id counter
        uint256 tokenId = tokenCounter; // Get the current token id
        _mint(to, tokenId); // Mint the token to the receiver address
        if (msg.value > MINT_FEE) { // If the sender paid more than the mint fee
            payable(msg.sender).transfer(msg.value - MINT_FEE); // Return the excess amount to the sender
        }
    }

    function claim() public {
        require(msg.sender == owner, "Only the owner can claim"); // Check if the sender is the owner
        payable(owner).transfer(address(this).balance); // Transfer the balance to the owner
    }
}