// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract WhitelistFacetCalls is FuzzBase, FuzzStorageVariables {

    function _dewhitelistTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.dewhitelistToken.selector, _input1));
    }

    function _whitelistTokenCall(address _input1, bytes4 _input2, uint48 _input3, uint40 _input4, bytes1 _input5, uint128 _input6, uint64 _input7, Implementation memory _input8, Implementation memory _input9, Implementation memory _input10) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.whitelistToken.selector, _input1, _input2, _input3, _input4, _input5, _input6, _input7, _input8, _input9, _input10));
    }

    function _updateStalkPerBdvPerSeasonForTokenCall(address _input1, uint40 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateStalkPerBdvPerSeasonForToken.selector, _input1, _input2));
    }


    function _updateGaugeForTokenCall(address _input1, uint64 _input2,Implementation memory _input3, Implementation memory _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateGaugeForToken.selector, _input1, _input2, _input3, _input4));
    }

    function _updateOracleImplementationForTokenCall(address _input1, Implementation memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateOracleImplementationForToken.selector, _input1, _input2));
    }

    function _updateLiquidityWeightImplementationForTokenCall(address _input1, Implementation memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateLiquidityWeightImplementationForToken.selector, _input1, _input2));
    }

    function _updateGaugePointImplementationForTokenCall(address _input1, Implementation memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateGaugePointImplementationForToken.selector, _input1, _input2));
    }

    function _updateSeedGaugeSettingsCall(EvaluationParameters memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateSeedGaugeSettings.selector, _input1));
    }

    function _getOracleImplementationForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.getOracleImplementationForToken.selector, _input1));
    }

    function _getGaugePointImplementationForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.getGaugePointImplementationForToken.selector, _input1));
    }

    function _getLiquidityWeightImplementationForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.getLiquidityWeightImplementationForToken.selector, _input1));
    }
}