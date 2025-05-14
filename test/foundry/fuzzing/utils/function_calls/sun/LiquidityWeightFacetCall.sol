// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract LiquidityWeightFacetCalls is FuzzBase, FuzzStorageVariables {

    function _maxWeightCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(LiquidityWeightFacet.maxWeight.selector, _input1));
    }

    function _noWeightCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(LiquidityWeightFacet.noWeight.selector, _input1));
    }

}