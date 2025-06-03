pragma solidity ^0.8.0;

import "../PostconditionsBase.sol";

contract PostconditionsPipelineConvertFacet is PostconditionsBase {

    function _pipelineConvertPostConditions(address inToken, address outToken, int96 fromStem, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {

            _after(actorsToUpdate);

            address user = actorsToUpdate[0];

            (int96 toStem, uint256 fromAmount, uint256 toAmount, uint256 fromBdv, uint256 toBdv) = abi.decode(
                returnData,
                (int96, uint256, uint256, uint256, uint256)
            );

            // get deposit id
            (success, returnData) = _getDepositIdCall(inToken, fromStem);
            assert(success);
            uint256 oldDepositId = abi.decode(returnData, (uint256));

            (success, returnData) = _getDepositIdCall(outToken, toStem);
            assert(success);
            uint256 newDepositId = abi.decode(returnData, (uint256));

            

            console.log("id length before : ", states[0].depositData[user].depositIds.length);
            console.log("id length after  : ", states[1].depositData[user].depositIds.length);

            console.log("");
            console.log("ids before : ");
            for(uint256 i; i < states[0].depositData[user].depositIds.length; ++i) {
                uint256 depositId = states[0].depositData[user].depositIds[i];
                address token = states[0].depositData[user].id2token[depositId];

                console.log("");
                console.log("id     : ", depositId);
                console.log("token  : ", token);
                console.log("amount : ", states[0].depositData[user].deposit[token][depositId].amount);
                console.log("bdv    : ", states[0].depositData[user].deposit[token][depositId].bdv );
            }


            console.log("");
            console.log("ids after : ");

            for(uint256 i; i < states[1].depositData[user].depositIds.length; ++i) {
                uint256 depositId = states[1].depositData[user].depositIds[i];
                address token = states[1].depositData[user].id2token[depositId];

                console.log("");
                console.log("id     : ", depositId);
                console.log("token  : ", token);
                console.log("amount : ", states[1].depositData[user].deposit[token][depositId].amount);
                console.log("bdv    : ", states[1].depositData[user].deposit[token][depositId].bdv );
            }

            

            console.log("");
            console.log(" ===== POST CONDITIONS ====== ");
            console.log("to stem     : ", toStem);
            console.log("from amount : ", fromAmount);
            console.log("to amount   : ", toAmount);
            console.log("from bdv    : ", fromBdv);
            console.log("to bdv      : ", toBdv);
            console.log("from bdv    : ", fromBdv);


            logStuff(inToken, outToken, oldDepositId, newDepositId, user);

            _validateConvertDecrease(user, inToken, oldDepositId, fromAmount, fromBdv);
            _validateConvertIncrease(user, outToken, newDepositId, toAmount, toBdv);


            

            
            // console.log(" : ", toStem);
        } else {
            onFailInvariantsGeneral(returnData);
        }
        
        
    }

    function _pipelineConvertPostConditions(bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        // expect call to fail
        assert(!success);

        console.log("");
        console.log("FAILURE");
        if (returnData.length >= 68) {
            bytes4 errorSelector;
            assembly {
                errorSelector := mload(add(returnData, 0x20))
            }
            if (errorSelector == 0x08c379a0) {
                // Decode the revert string from returnData[4:]
                string memory message = abi.decode(_sliceRevertReason(returnData), (string));
                console.log(keccak256(bytes(message)) == keccak256("ReentrancyGuard: reentrant call"));
                console.log(message);

                // expect fail to be reentrancy
                assert(keccak256(bytes(message)) == keccak256("ReentrancyGuard: reentrant call"));
            }
        }
            
    }

    function _sliceRevertReason(bytes memory data) internal pure returns (bytes memory result) {
        uint256 len = data.length - 4;
        result = new bytes(len);
        for (uint256 i = 0; i < len; i++) {
            result[i] = data[i + 4];
        }
    
    }

    // validates the deposit amount & bdv decrease by proper amount
    function _validateConvertDecrease(address user, address inToken, uint256 oldDepositId, uint256 amount, uint256 bdv) internal {
        uint256 oldAmountInToken = states[0].depositData[user].deposit[inToken][oldDepositId].amount;
        uint256 newAmountInToken = states[1].depositData[user].deposit[inToken][oldDepositId].amount;
        uint256 oldBdvInToken = states[0].depositData[user].deposit[inToken][oldDepositId].bdv;
        uint256 newBdvInToken = states[1].depositData[user].deposit[inToken][oldDepositId].bdv;

        uint256 oldTotalDeposits = states[0].tokenDepositTotals[inToken].totalTokenDeposited;
        uint256 newTotalDeposits = states[1].tokenDepositTotals[inToken].totalTokenDeposited;
        uint256 oldTotalBDV = states[0].tokenDepositTotals[inToken].totalBDV;
        uint256 newTotalBDV = states[1].tokenDepositTotals[inToken].totalBDV;
    
        assert(newAmountInToken == oldAmountInToken - amount);
        assert(newTotalDeposits == oldTotalDeposits - amount);
        assert(newBdvInToken == oldBdvInToken - bdv);
        assert(newTotalBDV == oldTotalBDV - bdv);
    }

    // validates the deposit amount & bdv increasse by proper amount
    function _validateConvertIncrease(address user, address outToken, uint256 newDepositId, uint256 amount, uint256 bdv) internal {
        uint256 oldAmountOutToken = states[0].depositData[user].deposit[outToken][newDepositId].amount;
        uint256 newAmountOutToken = states[1].depositData[user].deposit[outToken][newDepositId].amount;
        uint256 oldBdvOutToken = states[0].depositData[user].deposit[outToken][newDepositId].bdv;
        uint256 newBdvOutToken = states[1].depositData[user].deposit[outToken][newDepositId].bdv;

        uint256 oldTotalDeposits = states[0].tokenDepositTotals[outToken].totalTokenDeposited;
        uint256 newTotalDeposits = states[1].tokenDepositTotals[outToken].totalTokenDeposited;
        uint256 oldTotalBDV = states[0].tokenDepositTotals[outToken].totalBDV;
        uint256 newTotalBDV = states[1].tokenDepositTotals[outToken].totalBDV;
        
        assert(newAmountOutToken == oldAmountOutToken + amount);
        assert(newTotalDeposits == oldTotalDeposits + amount); //@note can cause expected issues if germinating side is 0
        assert(newBdvOutToken == oldBdvOutToken + bdv);
        assert(newTotalBDV == oldTotalBDV + bdv);
        
    }

    function logStuff(address inToken, address outToken, uint256 oldDepositId, uint256 newDepositId, address user) internal {
            uint256 newAmountInToken = states[1].depositData[user].deposit[inToken][oldDepositId].amount;
            uint256 newBdvInToken = states[1].depositData[user].deposit[inToken][oldDepositId].bdv;
            uint256 oldAmountInToken = states[0].depositData[user].deposit[inToken][oldDepositId].amount;
            uint256 oldBdvInToken = states[0].depositData[user].deposit[inToken][oldDepositId].bdv;

            uint256 newAmountOutToken = states[1].depositData[user].deposit[outToken][newDepositId].amount;
            uint256 newBdvOutToken = states[1].depositData[user].deposit[outToken][newDepositId].bdv;
            uint256 oldAmountOutToken = states[0].depositData[user].deposit[outToken][newDepositId].amount;
            uint256 oldBdvOutToken = states[0].depositData[user].deposit[outToken][newDepositId].bdv;


            
            console.log("");
            console.log("In T old balance  : ", oldAmountInToken);
            console.log("In T new balance  : ", newAmountInToken);
            console.log("In T old bdv      : ", oldBdvInToken);
            console.log("In T new bdv      : ", newBdvInToken);
            console.log("");
            console.log("Out T old balance : ", oldAmountOutToken);
            console.log("Out T new balance : ", newAmountOutToken);
            console.log("Out T old bdv     : ", oldBdvOutToken);
            console.log("Out T new bdv     : ", newBdvOutToken);
    }

}