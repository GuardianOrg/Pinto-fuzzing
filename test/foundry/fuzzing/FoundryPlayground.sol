// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FuzzGuided.sol";

contract FoundryPlayground is FuzzGuided {
    function setUp() public {
        vm.warp(1524785992); //echidna starting time
        fuzzSetup();
    }

    function test_silo_deposit() public {
        fuzz_guided_deposit_silo(1, 2);
    }

    function test_silo_withdraw() public {
        fuzz_withdraw_silo_facet(1, 2);
    }

    function test_silo_withdraws() public {
        fuzz_multi_withdraw_silo_facet(1, 2, 3);
    }

    function test_silo_transfer() public {
        fuzz_transfer_deposit_silo_facet(1, 2, 3);
    }

    function test_silo__multi_transfer() public {
        fuzz_guided_multi_transfer_silo_facet(1, 2, 3, 4);
    }

    

}