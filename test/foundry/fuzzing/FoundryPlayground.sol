// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FuzzGuided.sol";

contract FoundryPlayground is FuzzGuided {
    function setUp() public {
        vm.warp(1524785992); //echidna starting time
        fuzzSetup();
    }

    /// ===========
    /// SILO FACET
    /// ===========

    function test_silo_deposit() public {
        fuzz_guided_deposit_silo(1, 2);
    }

    function test_silo_withdrawM() public {
        fuzz_withdraw_silo_facet(1, 2, 3);
    }

    function test_silo_withdraws() public {
        fuzz_multi_withdraw_silo_facet(1, 2, 3);
    }

    function test_silo_transferM() public {
        fuzz_transfer_deposit_silo_facet(1, 2, 3);
    }

    function test_silo_multi_transfer() public {
        fuzz_guided_multi_transfer_silo_facet(1, 2, 3);
    }

    function test_silo_transfer_from() public {
        fuzz_guided_transfer_from_silo_facet(1, 2);
    }


    function test_multi_transfer_from() public {
        fuzz_multi_transfer_from_silo_facet(1, 2, 3);
    }

    function test_pipeline_convert_B2LP() public {
        fuzz_guided_convert_B2LP_pipeline_convert_facet(1, 2, 3, 4);
    }

    function test_pipeline_convert_LP2B() public {
        fuzz_guided_convert_LP2B_pipeline_convert_facet(1, 2, 3, 4);
    }

    function test_pipeline_convert_LP2LP() public {
        fuzz_guided_convert_LP2LP_pipeline_convert_facet(1, 2, 3, 4);
    }


    /// ===============
    /// APPROVAL FACET
    /// ===============
    function test_approve() public {
        fuzz_guided_approve_approval_facet(1, 2);
    }

    function test_increase() public {
        fuzz_guided_increase_approval_facet(1, 2);
    }

    function test_decrease() public {
        fuzz_guided_decrease_approval_facet(1, 2);
    }

    function test_approve_all() public {
        fuzz_guided_approve_all_approval_facet(1, 2);
    }

    


    /// ===============
    /// FIELD FACET
    /// ===============
    function test_sowM() public {
        fuzz_guided_sow_field_facet(1, 2, 3);
    }

    /// ===============
    /// SUN FACET
    /// ===============
    function test_gm() public {
        fuzz_guided_gm_sun_facet(1);
    }
    
    
    

}