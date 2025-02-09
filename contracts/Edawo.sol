// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// EDAWO is a crowdfunding contract.

contract Edawo {
    struct Campaign {
        string title;
        address creator;
        uint256 goal;
        uint256 raised;
        uint256 deadline;
        mapping (address => uint256) donors;
    }

    mapping(uint256 => Campaign) campaigns;
    uint256 public campaignCount; 

  


}
