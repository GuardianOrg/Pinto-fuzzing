// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PostconditionsBase.sol";

contract PostconditionsApprovalFacet is PostconditionsBase {

    function _approvePostConditions(uint256 approvalAmount, MockToken token, int96 stem, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _assertMatchingApproval(approvalAmount, 0, token, actorsToUpdate);
            _assertCanTransfer(approvalAmount, token, stem, actorsToUpdate);
            _approvalFacetPostCondition(success, returnData, actorsToUpdate);
        } else {
            onFailInvariantsGeneral(returnData);
        }
    }

    function _increasePostConditions(uint256 approvalAmount, MockToken token, int96 stem, uint256 existingApproval, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _assertMatchingApproval(approvalAmount, existingApproval, token, actorsToUpdate);
            _assertCanTransfer(approvalAmount, token, stem,actorsToUpdate);
            _approvalFacetPostCondition(success, returnData, actorsToUpdate);
        } else {
            onFailInvariantsGeneral(returnData);
        }
    }

    function _decreasePostConditions(MockToken token, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _assertMatchingApproval(0, 0, token, actorsToUpdate);
            _approvalFacetPostCondition(success, returnData, actorsToUpdate);
        } else {
            onFailInvariantsGeneral(returnData);
        }
    }

    function _approveAllPostConditions(bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _assertApprovedAll(actorsToUpdate);
            _approvalFacetPostCondition(success, returnData, actorsToUpdate);
        } else {
            onFailInvariantsGeneral(returnData);
        }
    }

    function _approvalFacetPostCondition(bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {

        if (success) {
            _after(actorsToUpdate);

            onSuccessInvariantsGeneral(returnData);
        } else {
            onFailInvariantsGeneral(returnData);
        }

    }

    // validates the correct approval amount
    function _assertMatchingApproval(uint256 approvalAmount, uint256 existingApproval, MockToken token, address[] memory actorsToUpdate) internal {
        address owner = actorsToUpdate[0];
        address spender = actorsToUpdate[1];

        (bool success, bytes memory returnData) = _depositAllowanceCall(owner, spender, address(token));
        assert(success);
        uint256 trueApprovedAmount = abi.decode(returnData, (uint256));

        assert(trueApprovedAmount == approvalAmount + existingApproval);
    }

    // Asserts balance can be transfered
    function _assertCanTransfer(uint256 approvalAmount, MockToken token, int96 stem, address[] memory actorsToUpdate) internal {
        address owner = actorsToUpdate[0];
        address spender = actorsToUpdate[1];

        // get depositId
        (bool success, bytes memory returnData) = _getDepositIdCall(address(token), stem);
        if (!success) {
            revert(); //@TODO better error handeling
        }
        uint256 depositId = abi.decode(returnData, (uint256));

        // make transfer
        vm.prank(spender);
        (success, returnData) = address(diamond).call(abi.encodeWithSelector(SiloFacet.safeTransferFrom.selector, owner, spender, depositId, approvalAmount, new bytes(0)));
        assert(success);
    }

    // Asserts approved for all
    function _assertApprovedAll(address[] memory actorsToUpdate) internal {
        address owner = actorsToUpdate[0];
        address spender = actorsToUpdate[1];

        (bool success, bytes memory returnData) = _isApprovedForAllCall(owner, spender);
        if (!success) {
            revert(); //@TODO better error handeling
        }
        bool isApproved = abi.decode(returnData, (bool));
        assert(isApproved);
    }

}