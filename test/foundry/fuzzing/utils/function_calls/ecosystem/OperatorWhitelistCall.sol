// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract OperatorWhitelistCalls is FuzzBase, FuzzStorageVariables {

    function _addOperatorCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(operatorWhitelist).call(abi.encodeWithSelector(OperatorWhitelist.addOperator.selector, _input1));
    }

    function _removeOperatorCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(operatorWhitelist).call(abi.encodeWithSelector(OperatorWhitelist.removeOperator.selector, _input1));
    }

    function _checkOperatorWhitelistCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(operatorWhitelist).call(abi.encodeWithSelector(OperatorWhitelist.checkOperatorWhitelist.selector, _input1));
    }

    function _getWhitelistedOperatorsCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(operatorWhitelist).call(abi.encodeWithSelector(OperatorWhitelist.getWhitelistedOperators.selector));
    }
}