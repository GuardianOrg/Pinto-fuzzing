// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract GaugePriceThresholdCalls is FuzzBase, FuzzStorageVariables {

    function _priceThresholdGaugePointsCall(uint80 _input1, uint80 _input2, uint80 _input3, bytes memory _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(gaugePriceThreshold).call(abi.encodeWithSelector(GaugePriceThreshold.priceThresholdGaugePoints.selector, _input1, _input2, _input3, _input4));
    }

    function _getBeanstalkCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(gaugePriceThreshold).call(abi.encodeWithSelector(GaugePriceThreshold.getBeanstalk.selector));
    }

    function _getTokenCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(gaugePriceThreshold).call(abi.encodeWithSelector(GaugePriceThreshold.getToken.selector));
    }

    function _getPriceThresholdCall() internal returns (bool success, bytes memory returnData) {
        vm.prank(currentActor);
        (success, returnData) =
            address(gaugePriceThreshold).call(abi.encodeWithSelector(GaugePriceThreshold.getPriceThreshold.selector));
    }

    function _getGaugePointsPriceCall() internal returns (bool success, bytes memory returnData) {
        vm.prank(currentActor);
        (success, returnData) =
            address(gaugePriceThreshold).call(abi.encodeWithSelector(GaugePriceThreshold.getGaugePointsPrice.selector));
    }
}