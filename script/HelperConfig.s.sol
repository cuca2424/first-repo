// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MockV3Aggregator} from "../test/mock/MockV3Aggregator.sol";

contract HelperConfig is Script {
    
    struct NetworkConfig {
        address networkAddress;
    }

    NetworkConfig public currentActiveNetwork;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_OFFER = 2000e8; 

    constructor() {
        if (block.chainid == 11155111) {
            currentActiveNetwork = getSepoliaNetwork();
        } else if (block.chainid == 1) {
            currentActiveNetwork = getMainnetNetwork();
        } else {
            currentActiveNetwork = getAnvilNetwork();
        }
    }
    
    function getSepoliaNetwork() public pure returns(NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return sepoliaConfig;
    }

    function getAnvilNetwork() public returns(NetworkConfig memory) {
        if (currentActiveNetwork.networkAddress != address(0)) {
            return currentActiveNetwork;
        }
        
        vm.startBroadcast();
        MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(DECIMALS, INITIAL_OFFER);
        vm.stopBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig(address(mockV3Aggregator));
        return anvilConfig;
    }

    function getMainnetNetwork() public pure returns(NetworkConfig memory) {
        NetworkConfig memory mainnetConfig = NetworkConfig(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        return mainnetConfig;
    }
}