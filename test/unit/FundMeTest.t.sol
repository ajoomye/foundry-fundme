// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";


contract FundMeTest is Test {

    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant sendvalue = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        // Deploy the contract
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsDeployer() public {

        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersion() public {
        assertEq(fundMe.getVersion(), 4);
    }

    function testMinDollarinfundfunction() public {
        vm.expectRevert();
        fundMe.fund();
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: sendvalue}();
        _;
    }

    function testFundUpdatesDatastructure() public funded {
        uint256 amountFunded = fundMe.addressToAmountFunded(USER);
        assertEq(amountFunded, sendvalue);
    }

    function testAddsFunderToArray() public funded{
        address funder = fundMe.getFunders(0);
        assertEq(funder, USER);
    }

    
    function testOnlyOwnerCanWithdraw() public funded {
        vm.expectRevert();
        vm.prank(USER);
        fundMe.withdraw();
    }

    function testWithdrawwithaSingleFunder() public funded {
        //Arrange
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingfundMeBalance = address(fundMe).balance;

        //Act
 
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
    

        //Assert
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingfundMeBalance = address(fundMe).balance;
        assertEq(endingfundMeBalance, 0);
        assertEq(startingOwnerBalance + startingfundMeBalance, endingOwnerBalance);
    }

    function testWithdrawwithMultipleFunders () public funded {
        uint160 numberofFunders = 10;
        uint160 startingFunderIndex = 2;
        for(uint160 i = startingFunderIndex; i < numberofFunders; i++) {
            hoax(address(i), sendvalue);
            fundMe.fund{value: sendvalue}();
        }

        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingfundMeBalance = address(fundMe).balance;

        //Act
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        //Assert
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingfundMeBalance = address(fundMe).balance;
        assertEq(endingfundMeBalance, 0);
        assertEq(startingOwnerBalance + startingfundMeBalance, endingOwnerBalance);

    }

}