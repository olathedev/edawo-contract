// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import './lib/Events.sol';
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
        bool isGoalReached;
    }

    mapping(uint256 => Campaign) campaigns;
    uint256 public campaignCount; 

    function startCampaign(string memory _title, uint256 _goal, uint256 _durationInDays) external {
        require(_goal > 0, "Goal must be above 0");
        require(_durationInDays > 0, "Duration must be at least a day future ahead");

        uint256 deadline = block.timestamp + (_durationInDays * 1 days);
        
        campaignCount += 1;

        Campaign storage newCampaign = campaigns[campaignCount];
        newCampaign.title = _title;
        newCampaign.creator = msg.sender;
        newCampaign.goal = _goal;
        newCampaign.raised = 0;
        newCampaign.deadline = deadline;
        newCampaign.isGoalReached = false;

        emit Events.CampaignCreated(campaignCount, msg.sender ,_goal, _title, deadline);
    }


}
