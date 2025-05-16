// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract ShipmentPlannerCalls is FuzzBase, FuzzStorageVariables {

    function _getFieldPlanCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(shipPlanner).call(abi.encodeWithSelector(ShipmentPlanner.getFieldPlan.selector, _input1));
    }

    function _getSiloPlanCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(shipPlanner).call(abi.encodeWithSelector(ShipmentPlanner.getSiloPlan.selector, _input1));
    }

    function _getBudgetPlanCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(shipPlanner).call(abi.encodeWithSelector(ShipmentPlanner.getBudgetPlan.selector, _input1));
    }

    function _getPaybackFieldPlanCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(shipPlanner).call(abi.encodeWithSelector(ShipmentPlanner.getPaybackFieldPlan.selector, _input1));
    }

    function _getPaybackPlanCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(shipPlanner).call(abi.encodeWithSelector(ShipmentPlanner.getPaybackPlan.selector, _input1));
    }

}