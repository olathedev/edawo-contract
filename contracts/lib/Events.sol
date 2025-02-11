// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

library Events {
    event CampaignCreated(uint256 indexed id, address indexed creator, uint256 goal, string title, uint256 deadline);
    event Donated(uint256 indexed id, address indexed donor, uint256 amountDOnated);
    event Withdrawn(uint256 indexed id, address indexed owner, uint256 amountWithdrawn);
}