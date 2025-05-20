// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PreconditionsBase.sol";
import "../../../properties/Properties.sol";

contract PreconditionsSiloFacet is PreconditionsBase, Properties {

    function _doubleDeposit(MockToken _token, uint256 _tokenAmount1, uint256 _tokenAmount2) internal returns(int96[] memory stems, uint256[] memory amounts) {
        stems = new int96[](2);
        amounts = new uint256[](2);

        uint256 _mode = 0;

        // first deposit
        (bool success, bytes memory returnData) = _depositCall(address(_token), _tokenAmount1, LibTransfer.From(_mode));
        if (!success) {
            revert(); //@TODO better error handeling
        }
        (uint256 amount, , int96 stem) = abi.decode(returnData, (uint256, uint256, int96));

        stems[0] = stem;
        amounts[0] = amount;

        // second deposit
        (success, returnData) = _depositCall(address(_token), _tokenAmount2, LibTransfer.From(_mode));
        if (!success) {
            revert(); //@TODO better error handeling
        }
        (amount, ,stem) = abi.decode(returnData, (uint256, uint256, int96));

        stems[1] = stem;
        amounts[1] = amount;
    }

}