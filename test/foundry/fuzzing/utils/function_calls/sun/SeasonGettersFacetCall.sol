// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract SeasonGettersFacetCalls is FuzzBase, FuzzStorageVariables {

    function _seasonCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.season.selector));
    }

    function _pausedCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.paused.selector));
    }

    function _timeCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.time.selector));
    }

    function _abovePegCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.abovePeg.selector));
    }

    function _sunriseBlockCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.sunriseBlock.selector));
    }

    function _weatherCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.weather.selector));
    }

    function _rainCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.rain.selector));
    }

    function _plentyPerRootCall(uint32 _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.plentyPerRoot.selector, _input1, _input2));
    }

    function _totalDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.totalDeltaB.selector));
    }

    function _totalDeltaBNoCapCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.totalDeltaBNoCap.selector));
    }


    function _poolDeltaBCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.plentyPerRoot.selector, _input1));
    }

    function _poolDeltaBNoCapCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.poolDeltaBNoCap.selector, _input1));
    }

    function _poolCurrentDeltaBCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.poolCurrentDeltaB.selector, _input1));
    }

    function _cumulativeCurrentDeltaBCall(address[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.cumulativeCurrentDeltaB.selector, _input1));
    }

    function _totalInstantaneousDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.totalInstantaneousDeltaB.selector));
    }

    function _wellOracleSnapshotCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.wellOracleSnapshot.selector, _input1));
    }

    function _getTwaLiquidityForWellCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getTwaLiquidityForWell.selector, _input1));
    }

    function _getWeightedTwaLiquidityForWellCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getWeightedTwaLiquidityForWell.selector, _input1));
    }

    function _getTotalUsdLiquidityCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getTotalUsdLiquidity.selector));
    }

    function _getTotalWeightedUsdLiquidityCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getTotalWeightedUsdLiquidity.selector));
    }

    function _getLargestLiqWellCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getLargestLiqWell.selector));
    }

    function _getCasesCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getCases.selector));
    }

    function _getCaseDataCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getCaseData.selector, _input1));
    }

    function _getChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getChangeFromCaseId.selector, _input1));
    }

    function _getAbsTemperatureChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getAbsTemperatureChangeFromCaseId.selector, _input1));
    }

    function _getRelTemperatureChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getRelTemperatureChangeFromCaseId.selector, _input1));
    }

    function _getAbsBeanToMaxLpRatioChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getAbsBeanToMaxLpRatioChangeFromCaseId.selector, _input1));
    }

    function _getRelBeanToMaxLpRatioChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getRelBeanToMaxLpRatioChangeFromCaseId.selector, _input1));
    }

    function _getSeasonStructCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getSeasonStruct.selector));
    }

    function _getSeasonTimestampCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getSeasonTimestamp.selector));
    }

    function _getEvaluationParametersCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getEvaluationParameters.selector));
    }

    function _getExtEvaluationParametersCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getExtEvaluationParameters.selector));
    }

    function _getMaxBeanMaxLpGpPerBdvRatioCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getMaxBeanMaxLpGpPerBdvRatio.selector));
    }

    function _getMinBeanMaxLpGpPerBdvRatioCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getMinBeanMaxLpGpPerBdvRatio.selector));
    }

    function _getTargetSeasonsToCatchUpCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getTargetSeasonsToCatchUp.selector));
    }

    function _getPodRateLowerBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getPodRateLowerBound.selector));
    }

    function _getPodRateOptimalCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getPodRateOptimal.selector));
    }

    function _getPodRateUpperBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getPodRateUpperBound.selector));
    }

    function _getDeltaPodDemandLowerBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getDeltaPodDemandLowerBound.selector));
    }

    function _getDeltaPodDemandUpperBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getDeltaPodDemandUpperBound.selector));
    }

    function _getLpToSupplyRatioUpperBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getLpToSupplyRatioUpperBound.selector));
    }

    function _getLpToSupplyRatioOptimalCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getLpToSupplyRatioOptimal.selector));
    }

    function _getLpToSupplyRatioLowerBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getLpToSupplyRatioLowerBound.selector));
    }

    function _getExcessivePriceThresholdCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getExcessivePriceThreshold.selector));
    }

    function _getWellsByDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getWellsByDeltaB.selector));
    }

}