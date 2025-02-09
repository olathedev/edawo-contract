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

    function donateToACampaign(uint256 _campaignId) external payable {
        require(_campaignId > 0 && _campaignId <= campaignCount, "Invalid campaign id");
        require(campaigns[_campaignId].deadline > block.timestamp, "This campaign has ended");
        require(msg.value > 0, "Donation must be above 0");

        Campaign storage campaign = campaigns[_campaignId];
        campaign.raised += msg.value;
        campaign.donors[msg.sender] += msg.value;

        if(campaign.raised >= campaign.goal) {
            campaign.isGoalReached = true;
        }

        emit Events.Donated(_campaignId, msg.sender, msg.value);
    }

    function ClaimDonations(uint256 _campaignId) external  {
        require(_campaignId > 0 && _campaignId <= campaignCount, "Invalid Campaign Id");
        Campaign storage campaign = campaigns[_campaignId];
        require(campaign.creator == msg.sender, "you dont have the required access to this campaign");
        require(campaign.isGoalReached, "You can only withdraw when goal is reached");
        require(campaign.deadline < block.timestamp, "You cant withdraw donations before deadline");
        
        uint amountToWithdraw = campaign.raised;
        campaign.raised = 0;

       payable(campaign.creator).transfer(amountToWithdraw);

       emit Events.Withdrawn(_campaignId, campaign.creator, amountToWithdraw);
    }


}
