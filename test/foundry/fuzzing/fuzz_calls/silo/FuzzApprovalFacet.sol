// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/silo/PreconditionsApprovalFacet.sol";
import "../../helpers/postconditions/silo/PostconditionsApprovalFacet.sol";

contract FuzzApprovalFacet is PreconditionsApprovalFacet, PostconditionsApprovalFacet {

    function fuzz_approve_approval_facet(uint256 _amountSalt, uint256 _receiverSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 recieverIndex = fl.clamp(_receiverSalt, 0, 2);

        // verify different user is receiver
        address spender = USERS[recieverIndex];
        if (spender == currentActor) {
            spender = USERS[(recieverIndex + 1) % 3];
        }

        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        actorsToUpdate[1] = spender;

        _setWellLiquidity();
        (uint256 approvalAmount, int96 stem) = _depositSilo(tokenAmount, currentActor); // @TODO check if we should be using the approval amount or not

        _before(actorsToUpdate);        

        (bool success, bytes memory returnData) = _approveDepositCall(spender, address(token), approvalAmount);

        _approvePostConditions(approvalAmount, token, stem, success, returnData, actorsToUpdate);
        
    }

    function fuzz_increase_approval_facet(uint256 _amountSalt, uint256 _receiverSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 recieverIndex = fl.clamp(_receiverSalt, 0, 2);

        // verify different user is receiver
        address spender = USERS[recieverIndex];
        if (spender == currentActor) {
            spender = USERS[(recieverIndex + 1) % 3];
        }

        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        actorsToUpdate[1] = spender;

        _before(actorsToUpdate);

        _setWellLiquidity();
        (uint256 approvalAmount, int96 stem) = _depositSilo(tokenAmount, currentActor);

        (bool success, bytes memory returnData) = _approveDepositCall(spender, address(token), approvalAmount);
        assert(success);

        (success, returnData) = _depositAllowanceCall(currentActor, spender, address(token));
        assert(success);
        uint256 currApprovedAmount = abi.decode(returnData, (uint256));
        console.log("CURRR : ", currApprovedAmount);

        (success, returnData) = _increaseDepositAllowanceCall(spender, address(token), approvalAmount);

        _increasePostConditions(approvalAmount, token, stem, currApprovedAmount, success, returnData, actorsToUpdate);
    }


    function fuzz_decrease_approval_facet(uint256 _amountSalt, uint256 _receiverSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 recieverIndex = fl.clamp(_receiverSalt, 0, 2);

        // verify different user is receiver
        address spender = USERS[recieverIndex];
        if (spender == currentActor) {
            spender = USERS[(recieverIndex + 1) % 3];
        }

        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        actorsToUpdate[1] = spender;

        _before(actorsToUpdate);

        _setWellLiquidity();
        (uint256 approvalAmount, ) = _depositSilo(tokenAmount, currentActor);

        (bool success, bytes memory returnData) = _approveDepositCall(spender, address(token), approvalAmount);

        (success, returnData) = _decreaseDepositAllowanceCall(spender, address(token), approvalAmount);

        _decreasePostConditions(token, success, returnData, actorsToUpdate);
        
    }



    function fuzz_approve_all_approval_facet(uint256 _amountSalt, uint256 _receiverSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 recieverIndex = fl.clamp(_receiverSalt, 0, 2);

        // verify different user is receiver
        address spender = USERS[recieverIndex];
        if (spender == currentActor) {
            spender = USERS[(recieverIndex + 1) % 3];
        }

        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        actorsToUpdate[1] = spender;

        _before(actorsToUpdate);

        _setWellLiquidity();
        (uint256 approvalAmount, int96 stem) = _depositSilo(tokenAmount, currentActor);


        (bool success, bytes memory returnData) = _setApprovalForAllCall(spender, true);

        _approveAllPostConditions(success, returnData, actorsToUpdate);
    }



}