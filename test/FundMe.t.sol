// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "lib/forge-std/src/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe public fundMe;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run(); 
    }

    function testMinimum() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOnlyOwner() public view {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testVersion() public view {
        assertEq(fundMe.getVersion(), 4);
    }

    function testRevert() public {
        vm.expectRevert();
        revert();
    }

    function testAmountFunded() public {
        fundMe.fund{value: 10e18}();
        uint256 amount = fundMe.getAddressToAmountFunded(address(this));
        assertEq(amount, 10e18);
    }

}

