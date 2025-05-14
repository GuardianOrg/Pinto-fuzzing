// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract OracleFacetCalls is FuzzBase, FuzzStorageVariables {

    function _getUsdTokenPriceCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getUsdTokenPrice.selector, _input1));
    }

    function _getUsdTokenTwapCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getUsdTokenTwap.selector, _input1, _input2));
    }

    function _getTokenUsdPriceCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getTokenUsdPrice.selector, _input1));
    }

    function _getTokenUsdTwapCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getTokenUsdTwap.selector, _input1, _input2));
    }

    function _getUsdTokenPriceFromExternalCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getUsdTokenPriceFromExternal.selector, _input1, _input2));
    }

    function _getTokenUsdPriceFromExternalCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getTokenUsdPriceFromExternal.selector, _input1, _input2));
    }

    function _getRatiosAndBeanIndexCall(IERC20[] memory _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getRatiosAndBeanIndex.selector, _input1, _input2));
    }

    function _getMillionUsdPriceCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getMillionUsdPrice.selector, _input1, _input2));
    }

}
