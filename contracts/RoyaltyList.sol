// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import '@imtbl/zkevm-contracts/contracts/royalty-enforcement/RoyaltyAllowlist.sol';

contract RoyaltyList is RoyaltyAllowlist {
  constructor() RoyaltyAllowlist(msg.sender) {}
}