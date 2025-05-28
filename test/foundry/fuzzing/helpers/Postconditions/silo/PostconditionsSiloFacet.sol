// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PostconditionsBase.sol";

contract PostconditionsSiloFacet is PostconditionsBase {

    function _siloDepositPostConditions(uint256 depositAmount, MockToken token, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _after(actorsToUpdate);

            (, uint256 receivedBDV, ) = abi.decode(returnData, (uint256, uint256, int96));

            uint256 depositId = states[1].depositData[actorsToUpdate[0]].depositIds[0];
            _validateSingleDepositInvariants(actorsToUpdate[0], address(token), depositId, depositAmount);

            // validte user recieves bdv @note wrong thing returned on their end
            assert(
                states[1].depositData[actorsToUpdate[0]].deposit[address(token)][depositId].bdv == receivedBDV
            );

        } else {
            onFailInvariantsGeneral(returnData);
        }
    }

    function _siloWithdrawPostConditions(MockToken token, uint256 depositAmount, uint256 withdrawAmount, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _after(actorsToUpdate);

            address user = actorsToUpdate[0];
            uint256 depositId = states[0].depositData[user].depositIds[0];

            // check if all deposits cleared
            if (states[1].depositData[user].depositIds.length == 0) {
                _validateFullClear(user);
                _validateClearedToken(token, depositId, user);
            } else {
                // check partial clear
                _vaidatePartialClearToken(token, depositId, withdrawAmount, user);
            }

        } else {
            onFailInvariantsGeneral(returnData);
        }
    }

    function _siloWithdrawMultiPostConditions(MockToken token, uint256 withdrawAmount1, uint256 withdrawAmount2, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _after(actorsToUpdate);

            address user = actorsToUpdate[0];

            
            uint256 depositId1 = states[0].depositData[user].depositIds[states[0].depositData[user].depositIds.length-2];
            uint256 depositId2 = states[0].depositData[user].depositIds[states[0].depositData[user].depositIds.length-1];

            // check if all deposits cleared
            if (states[1].depositData[user].depositIds.length == 0) {
                _validateFullClear(user);
                _validateClearedToken(token, depositId1, user);
                _validateClearedToken(token, depositId2, user);
            } else {
                // check partial clear
                _vaidatePartialClearToken(token, depositId1, withdrawAmount1, user);
                _vaidatePartialClearToken(token, depositId2, withdrawAmount2, user);
            }

        } else {
            onFailInvariantsGeneral(returnData);
        }
    }

    

    function _siloTransferPostConditions(MockToken token, uint256 transferAmount, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _after(actorsToUpdate);

            address sender = actorsToUpdate[0];
            address receiver = actorsToUpdate[1];

            if (states[1].depositData[sender].depositIds.length == 0) {
                _validateFullClear(sender);
            }

            // check cleared deposit for most recent deposit
            _vaidatePartialClearToken(token, states[0].depositData[sender].depositIds[states[0].depositData[sender].depositIds.length-1], transferAmount, sender);

            // validate receiver has a new deposit
            uint256 depositId = states[1].depositData[receiver].depositIds[0];
            _validateSingleDepositInvariants(receiver, address(token), depositId, transferAmount);

        } else {
            onFailInvariantsGeneral(returnData);
        }
        
    }

    function _siloTransferMultiPostConditions(MockToken token, uint256 transferAmount1, uint256 transferAmount2, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _after(actorsToUpdate);

            address sender = actorsToUpdate[0];
            address receiver = actorsToUpdate[1];

            if (states[1].depositData[sender].depositIds.length == 0) {
                _validateFullClear(sender);
            }

            // check cleared deposit for most recent deposits
            _vaidatePartialClearToken(token, states[0].depositData[sender].depositIds[states[0].depositData[sender].depositIds.length-1], transferAmount1, sender);
            _vaidatePartialClearToken(token, states[0].depositData[sender].depositIds[states[0].depositData[sender].depositIds.length-2], transferAmount2, sender);

            // validate receiver has a new deposit
            uint256 depositId = states[0].depositData[sender].depositIds[states[0].depositData[receiver].depositIds.length-1];
            _validateSingleDepositInvariants(receiver, address(token), depositId, transferAmount1);

            depositId = states[0].depositData[sender].depositIds[states[0].depositData[receiver].depositIds.length-2];
            _validateSingleDepositInvariants(receiver, address(token), depositId,  transferAmount2);

        } else {
            onFailInvariantsGeneral(returnData);
        }
        
    }

    // validates fully cleared
    function _validateFullClear(address user) internal {

        // validate no maturing stalk
        assert(states[1].depositData[user].matureGerminatingStalk == 0);

        // validate no young stalk
        assert(states[1].depositData[user].youngGerminatingStalk == 0);

        // validate no roots
        assert(states[1].depositData[user].roots == 0);

        // validate no stalk amount
        assert(states[1].depositData[user].stalk == 0);

        // validate no germinating stalk
        assert(states[1].depositData[user].germinatingStalk == 0);

        // validate no grown stalk
        assert(states[1].depositData[user].grownStalk == 0);

        // validate no grown roots
        assert(states[1].depositData[user].grownRoots == 0);
    }

    // validates cleared deposit for token
    function _validateClearedToken(MockToken token, uint256 depositId, address user) internal {
        // validate no deposited amount
        assert(states[1].depositData[user].deposit[address(token)][depositId].amount == 0);

        // validte no bdv
        assert(states[1].depositData[user].deposit[address(token)][depositId].bdv == 0); 
    }

    function _vaidatePartialClearToken(MockToken token, uint256 depositId, uint256 withdrawAmount, address user) internal {
        uint256 prevAmount = states[0].depositData[user].deposit[address(token)][depositId].amount;

        // validates deposit decrease
        uint256 expectedAmountDecrease = prevAmount - withdrawAmount;
        assert(states[1].depositData[user].deposit[address(token)][depositId].amount == expectedAmountDecrease);

        // @TODO VERIFY THIS
        // validate bdv decrease
        // formula for removed bdv
        // uint256 expectdBDVDecrease = ((withdrawAmount * states[0].depositData[user].deposit[address(token)][depositId].bdv) - 1 / prevAmount) + 1;
        // console.log("PREV  : ", states[0].depositData[user].deposit[address(token)][depositId].bdv);
        // console.log("EXPT  : ", expectdBDVDecrease);
        // console.log("REAL  : ", states[1].depositData[user].deposit[address(token)][depositId].bdv);
        // assert(states[1].depositData[user].deposit[address(token)][depositId].bdv == expectdBDVDecrease);

        assert(states[1].depositData[user].deposit[address(token)][depositId].bdv < states[0].depositData[user].deposit[address(token)][depositId].bdv);
    }

    function _siloFacetPostCondition(bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {

        if (success) {
            _after(actorsToUpdate);

            onSuccessInvariantsGeneral(returnData);
        } else {
            onFailInvariantsGeneral(returnData);
        }

    }

    function _validateSingleDepositInvariants(address user, address token, uint256 depositId, uint256 depositAmount) internal {
        assert(states[1].depositData[user].depositIds.length > 0);

        // validate the balance matches deposited amount
        assert(
            states[1].depositData[user].deposit[token][depositId].amount == depositAmount
        );

        // // validte user recieves bdv @note wrong thing returned on their end
        // assert(
        //     states[1].depositData[user].deposit[address(token)][depositId].bdv == receivedBDV
        // );

        // assert(
        //     states[1].depositData[user].deposit[token][depositId].bdv > 0
        // );

        // validate germinating stalk @note same issue as above
        assert(
            states[1].depositData[user].germinatingStalk > 0
        );

        // validate stalk amount 
        assert(
            states[1].depositData[user].stalk == 0
        );
    }

}