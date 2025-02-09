// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

library Events {
    event CampaignCreated(uint256 indexed id, address indexed creator, uint256 goal, string title, uint256 deadline);
}