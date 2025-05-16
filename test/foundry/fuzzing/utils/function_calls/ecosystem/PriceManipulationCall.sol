// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract PriceManipulationCalls is FuzzBase, FuzzStorageVariables {

    function _isValidSlippageCall(IWell _input1, IERC20 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(priceManipulation).call(abi.encodeWithSelector(PriceManipulation.isValidSlippage.selector, _input1, _input2, _input3));
    }

    function _aggregatePintoPerUsdcCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(priceManipulation).call(abi.encodeWithSelector(PriceManipulation.aggregatePintoPerUsdc.selector));
    }

    function _priceCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(priceManipulation).call(abi.encodeWithSelector(PriceManipulation.price.selector));
    }
}
