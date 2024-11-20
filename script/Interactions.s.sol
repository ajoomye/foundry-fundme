// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";


contract FundFundMe is Script {

    uint256 SEND_VALUE = 0.1 ether;
    
    function fundFundMe (address MostRecentFundMe) public {
        vm.startBroadcast();
        FundMe(payable(MostRecentFundMe)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe contract with %s", SEND_VALUE, "ETH");
    }

    function run() external {  
        address mostRecentFundMe = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(mostRecentFundMe);
    }

}


contract WithdrawFundMe is Script {

    
    function withdrawFundMe (address MostRecentFundMe) public {
        vm.startBroadcast();
        FundMe(payable(MostRecentFundMe)).withdraw();
        vm.stopBroadcast();
        console.log("Funded FundMe contract withdrawn");
    }

    function run() external {
        address mostRecentFundMe = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(mostRecentFundMe);
    }

}