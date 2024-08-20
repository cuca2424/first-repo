// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe){
        //before broadcast...
        HelperConfig helperConfig = new HelperConfig();
        address networkAddress = helperConfig.currentActiveNetwork();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(networkAddress);
        vm.stopBroadcast();
        return fundMe;
    }
}