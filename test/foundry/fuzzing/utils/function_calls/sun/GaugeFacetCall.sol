// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract GaugeFacetCalls is FuzzBase, FuzzStorageVariables {

    function _cultivationFactorCall(bytes memory _input1, bytes memory _input2, bytes memory _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.cultivationFactor.selector, _input1, _input2, _input3));
    }

    function _convertDownPenaltyGaugeCall(bytes memory _input1, bytes memory _input2, bytes memory _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.convertDownPenaltyGauge.selector, _input1, _input2, _input3));
    }

    function _getGaugeCall(GaugeId _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.getGauge.selector, _input1));
    }

    function _getGaugeValueCall(GaugeId _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.getGaugeValue.selector, _input1));
    }

    function _getGaugeDataCall(GaugeId _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.getGaugeData.selector, _input1));
    }

}