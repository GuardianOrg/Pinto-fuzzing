pragma solidity ^0.8.0;

import "../PostconditionsBase.sol";

contract PostconditionsPipelineConvertFacet is PostconditionsBase {

    function _pipelineConvertPostConditions(address inToken, address outToken, int96 fromStem, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _after(actorsToUpdate);

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


            (success, returnData) = _balanceOfCall(currentActor, oldDepositId);
            assert(success);
            uint256 oldDepositBalance = abi.decode(returnData, (uint256));

            (success, returnData) = _balanceOfCall(currentActor, newDepositId);
            assert(success);
            uint256 newDepositBalance = abi.decode(returnData, (uint256));

            console.log("");
            console.log(" ===== POST CONDITIONS ====== ");
            console.log("to stem     : ", toStem);
            console.log("from amount : ", fromAmount);
            console.log("to amount   : ", toAmount);
            console.log("from bdv    : ", fromBdv);
            console.log("to bdv      : ", toBdv);
            console.log("from bdv    : ", fromBdv);
            console.log("old balance : ", oldDepositBalance);
            console.log("new balance : ", newDepositBalance);
            // console.log(" : ", toStem);
        } else {
            onFailInvariantsGeneral(returnData);
        }
        
        
    }

}