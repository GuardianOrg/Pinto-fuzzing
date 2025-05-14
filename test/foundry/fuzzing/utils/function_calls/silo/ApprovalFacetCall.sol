// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract ApprovalFacetCalls is FuzzBase, FuzzStorageVariables {

    function _approveDepositCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.approveDeposit.selector, _input1, _input2, _input3));
    }

    function _increaseDepositAllowanceCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.increaseDepositAllowance.selector, _input1, _input2, _input3));
    }

    function _decreaseDepositAllowanceCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.decreaseDepositAllowance.selector, _input1, _input2, _input3));
    }

    function _depositAllowanceCall(address _input1, address _input2, address _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.depositAllowance.selector, _input1, _input2, _input3));
    }

    function _setApprovalForAllCall(address _input1, bool _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.setApprovalForAll.selector, _input1, _input2));
    }

    function _isApprovedForAllCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.isApprovedForAll.selector, _input1, _input2));
    }
}