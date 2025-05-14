// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract GaugeGettersFacetCalls is FuzzBase, FuzzStorageVariables {

    function _getAverageGrownStalkPerBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getAverageGrownStalkPerBdv.selector));
    }

    function _getTotalBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getTotalBdv.selector));
    }

    function _getSeedGaugeCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getSeedGauge.selector));
    }

    function _getAverageGrownStalkPerBdvPerSeasonCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getAverageGrownStalkPerBdvPerSeason.selector));
    }

    function _getBeanToMaxLpGpPerBdvRatioCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getBeanToMaxLpGpPerBdvRatio.selector));
    }

    function _getBeanToMaxLpGpPerBdvRatioScaledCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getBeanToMaxLpGpPerBdvRatioScaled.selector));
    }

    function _getGaugePointsPerBdvForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGaugePointsPerBdvForToken.selector, _input1));
    }

    function _getGaugePointsPerBdvForWellCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGaugePointsPerBdvForWell.selector, _input1));
    }

    function _getLargestGpPerBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getLargestGpPerBdv.selector));
    }

    function _getBeanGaugePointsPerBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getBeanGaugePointsPerBdv.selector));
    }

    function _getGrownStalkIssuedPerSeasonCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGrownStalkIssuedPerSeason.selector));
    }

    function _getGrownStalkIssuedPerGpCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGrownStalkIssuedPerGp.selector));
    }

    function _getPodRateCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getPodRate.selector, _input1));
    }

    function _getLiquidityToSupplyRatioCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getLiquidityToSupplyRatio.selector));
    }

    function _getDeltaPodDemandCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getDeltaPodDemand.selector));
    }

    function _getGaugePointsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGaugePoints.selector, _input1));
    }

    function _calcGaugePointsWithParamsCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.calcGaugePointsWithParams.selector, _input1, _input2));
    }

    function _getGaugePointsWithParamsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGaugePointsWithParams.selector, _input1));
    }
}