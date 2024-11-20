//Deploy mocks when we are on a local anvil
//Keep track of contract addresses

// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {

    NetworkConfig public activeNetwork;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_Price = 2000e8;
    

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetwork = getSepoliaEthConfig();
        } else if (block.chainid == 84532) {
            activeNetwork = getBaseSepoliaConfig();
        } else {
            activeNetwork = getorCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        // price feed address
        NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;


    }

    function getBaseSepoliaConfig() public pure returns (NetworkConfig memory) {
        // price feed address
        NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeed: 0x4aDC67696bA383F43DD60A9e78F2C97Fbbfc7cb1});
        return sepoliaConfig;


    }

    function getorCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        
        //To check if a price feed is already set
        if (activeNetwork.priceFeed != address(0)) {
            return activeNetwork;
        }

        // price feed address
        vm.startBroadcast();
        MockV3Aggregator mockpriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_Price);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({priceFeed: address(mockpriceFeed)});
        return anvilConfig;
    }



}