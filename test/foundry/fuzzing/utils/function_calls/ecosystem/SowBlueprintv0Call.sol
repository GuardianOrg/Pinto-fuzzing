// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract SowBlueprintv0Calls is FuzzBase, FuzzStorageVariables {

    function _sowBlueprintv0Call(SowBlueprintv0.SowBlueprintStruct calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(sowBlueprintv0).call(abi.encodeWithSelector(SowBlueprintv0.sowBlueprintv0.selector, _input1));
    }

    function _getLastExecutedSeasonCall(bytes32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(sowBlueprintv0).call(abi.encodeWithSelector(SowBlueprintv0.getLastExecutedSeason.selector, _input1));
    }

    function _getPintosLeftToSowCall(bytes32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(sowBlueprintv0).call(abi.encodeWithSelector(SowBlueprintv0.getPintosLeftToSow.selector, _input1));
    }


    function _validateParamsAndReturnBeanstalkStateCall(SowBlueprintv0.SowBlueprintStruct calldata _input1, bytes32 _input2, address _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(sowBlueprintv0).call(abi.encodeWithSelector(SowBlueprintv0.validateParamsAndReturnBeanstalkState.selector, _input1, _input2, _input3));
    }

    function _validateParamsAndReturnBeanstalkStateArrayCall(SowBlueprintv0.SowBlueprintStruct[] calldata _input1, bytes32[] calldata _input2, address[] calldata _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(sowBlueprintv0).call(abi.encodeWithSelector(SowBlueprintv0.validateParamsAndReturnBeanstalkStateArray.selector, _input1, _input2, _input3));
    }
}

