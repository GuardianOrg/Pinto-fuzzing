// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract ConvertGettersFacetCalls is FuzzBase, FuzzStorageVariables {

    function _getMaxAmountInCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.getMaxAmountIn.selector, _input1, _input2));
    }

    function _getAmountOutCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.getAmountOut.selector, _input1, _input2, _input3));
    }

    function _overallCappedDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.overallCappedDeltaB.selector));
    }

    function _overallCurrentDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.overallCurrentDeltaB.selector));
    }

    function _scaledDeltaBCall(uint256 _input1, uint256 _input2, int256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.scaledDeltaB.selector, _input1, _input2, _input3));
    }

    function _cappedReservesDeltaBCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.cappedReservesDeltaB.selector, _input1));
    }

    function _calculateDeltaBFromReservesCall(address _input1, uint256[] memory _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.calculateDeltaBFromReserves.selector, _input1, _input2, _input3));
    }

    function _getOverallConvertCapacityCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.getOverallConvertCapacity.selector));
    }

    function _getWellConvertCapacityCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.getWellConvertCapacity.selector, _input1));
    }

    function _calculateStalkPenaltyCall(LibConvert.DeltaBStorage memory _input1, uint256 _input2, uint256 _input3, address _input4, address _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.calculateStalkPenalty.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _downPenalizedGrownStalkCall(address _input1, uint256 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.downPenalizedGrownStalk.selector, _input1, _input2, _input3));
    }
}