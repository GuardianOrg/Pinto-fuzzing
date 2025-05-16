// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract DrafterCalls is FuzzBase, FuzzStorageVariables {

    function _encodeOperatorPasteInstrCall(uint80 _input1, uint80 _input2, uint80 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(drafter).call(abi.encodeWithSelector(Drafter.encodeOperatorPasteInstr.selector, _input1, _input2, _input3));
    }

    function _decodeOperatorPasteInstrCall(bytes32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(drafter).call(abi.encodeWithSelector(Drafter.decodeOperatorPasteInstr.selector, _input1));
    }

    function _encodeLibReturnPasteParamCall(uint80 _input1, uint80 _input2, uint80 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(drafter).call(abi.encodeWithSelector(Drafter.encodeLibReturnPasteParam.selector, _input1, _input2, _input3));
    }

    function _decodeLibReturnPasteParamCall(bytes32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(drafter).call(abi.encodeWithSelector(Drafter.decodeLibReturnPasteParam.selector, _input1));
    }

    function _encodeClipboardCall(uint256 _input1, bytes32[] memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(drafter).call(abi.encodeWithSelector(Drafter.encodeClipboard.selector, _input1, _input2));
    }

    function _decodeClipboardCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(drafter).call(abi.encodeWithSelector(Drafter.decodeClipboard.selector, _input1));
    }

}