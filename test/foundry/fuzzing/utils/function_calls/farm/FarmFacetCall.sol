// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract FarmFacetCalls is FuzzBase, FuzzStorageVariables {

    function _farmCall(bytes[] calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FarmFacet.farm.selector, _input));
    }

    function _advancedFarmCall(AdvancedFarmCall[] calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FarmFacet.advancedFarm.selector, _input));
    }

}