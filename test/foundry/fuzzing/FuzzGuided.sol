// SPDX-License-Identifier: UNTITLED
pragma solidity ^0.8.0;

import "./fuzz_calls/farm/FuzzDepotFacet.sol";
import "./fuzz_calls/silo/FuzzSiloFacet.sol";
import "./fuzz_calls/silo/FuzzApprovalFacet.sol";
import "./fuzz_calls/silo/FuzzPipelineConvertFacet.sol";
import "./fuzz_calls/field/FuzzFieldFacet.sol";
import "./fuzz_calls/sun/FuzzSeasonFacet.sol";


contract FuzzGuided is FuzzDepotFacet, FuzzSiloFacet, FuzzPipelineConvertFacet, FuzzApprovalFacet, FuzzFieldFacet, FuzzSeasonFacet {

    /// ===========
    /// SILO FACET
    /// ===========
    function fuzz_guided_deposit_silo(uint256 x) public setCurrentActor {
        fuzz_deposit_silo_facet(x);
    }

    function fuzz_guided_withdraw_silo_facet(uint256 x, uint256 y) public setCurrentActor {
        fuzz_withdraw_silo_facet(x, y);
    }
    function fuzz_guided_multi_withdraw_silo_facet(uint256 x, uint256 y) public setCurrentActor {
        fuzz_multi_withdraw_silo_facet(x, y);
    }
    function fuzz_guided_transfer_deposit_silo_facet(uint256 x, uint256 y) public setCurrentActor {
        fuzz_transfer_deposit_silo_facet(x, y);
    }

    function fuzz_guided_multi_transfer_silo_facet(uint256 w, uint256 x, uint256 y) public setCurrentActor {
        fuzz_multi_transfer_silo_facet(w, x, y);
    }

    function fuzz_guided_transfer_from_silo_facet(uint256 x, uint256 y) public setCurrentActor() {
        fuzz_transfer_from_silo_facet(x, y);
    }

    function fuzz_guided_multi_transfer_from_silo_facet(uint256 x, uint256 y, uint256 z) public setCurrentActor() {
        fuzz_multi_transfer_from_silo_facet(x, y, z);
    }

    function fuzz_guided_convert_B2LP_pipeline_convert_facet(uint256 w, uint256 x, uint256 y, uint256 z) public setCurrentActor() {
        fuzz_pipeline_convert_B2LP_facet(w, x, y, z);
    }

    function fuzz_guided_convert_LP2B_pipeline_convert_facet(uint256 w, uint256 x, uint256 y, uint256 z) public setCurrentActor() {
        fuzz_pipeline_convert_LP2B_facet(w, x, y, z);
    }

    function fuzz_guided_convert_LP2LP_pipeline_convert_facet(uint256 w, uint256 x, uint256 y, uint256 z) public setCurrentActor() {
        fuzz_pipeline_convert_LP2LP_facet(w, x, y, z);
    }

    function fuzz_guided_pipeline_convert_reenter(uint256 w, uint256 x, uint256 y, uint256 z) public setCurrentActor() {
        fuzz_pipeline_convert_reenter(w, x, y, z);
    }

    


    /// ===============
    /// APPROVAL FACET
    /// ===============

    function fuzz_guided_approve_approval_facet(uint256 x, uint256 y) public setCurrentActor() {
        fuzz_approve_approval_facet(x, y);
    }

    function fuzz_guided_increase_approval_facet(uint256 x, uint256 y) public setCurrentActor() {
        fuzz_increase_approval_facet(x, y);
    }

    function fuzz_guided_decrease_approval_facet(uint256 x, uint256 y) public setCurrentActor() {
        fuzz_decrease_approval_facet(x, y);
    }
    function fuzz_guided_approve_all_approval_facet(uint256 x, uint256 y) public setCurrentActor() {
        fuzz_approve_all_approval_facet(x, y);
    }


    /// ===============
    /// FIELD FACET
    /// ===============
    function fuzz_guided_sow_field_facet(uint256 x, uint32 y, uint256 z) public setCurrentActor() {
        fuzz_sow_field(x, y, z);
    }

    function fuzz_guided_sow_min_field_facet(uint256 w, uint32 x, uint32 y, uint256 z) public setCurrentActor() {
        fuzz_sow_min_field(w, x, y, z);
    }

    function fuzz_guided_add_field_facet(uint32 x) public setCurrentActor() {
        fuzz_add_active_field(x);
    }

    function fuzz_guided_harvest_field_facet(uint256 w, uint32 x, uint256 y, uint256 z) public setCurrentActor() {
        fuzz_harvest_field(w, x, y, z);
    }

    /// ===============
    /// SUN FACET
    /// ===============
    function fuzz_guided_gm_sun_facet(uint256 x) public setCurrentActor() {
        fuzz_gm_sun(x);
    }
}