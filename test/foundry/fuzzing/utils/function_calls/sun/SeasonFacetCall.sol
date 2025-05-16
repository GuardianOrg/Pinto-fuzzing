// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract SeasonFacetCalls is FuzzBase, FuzzStorageVariables {

    function _sunriseCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonFacet.sunrise.selector));
    }

    function _gmCall(address _input1, LibTransfer.To _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonFacet.gm.selector, _input1, _input2));
    }

    function _seasonTimeCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonFacet.seasonTime.selector));
    }

    function _setShipmentRoutesCall(ShipmentRoute[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(Distribution.setShipmentRoutes.selector, _input1));
    }


}