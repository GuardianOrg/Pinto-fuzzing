// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PreconditionsBase.sol";
import "../../../properties/Properties.sol";

contract PreconditionsApprovalFacet is PreconditionsBase, Properties {

    // deposit into silo
    function _depositSilo(uint256 _tokenAmount, address _currentActor) internal returns (uint256 amount, int96 stem) {

        // mint user tokens
        vm.prank(ADMIN);
        beanToken.mint(_currentActor, _tokenAmount);

        // first deposit
        (bool success, bytes memory returnData) = _depositCall(address(beanToken), _tokenAmount, LibTransfer.From(0));
        if (!success) {
            revert(); //@TODO better error handeling
        }

        (amount, , stem) = abi.decode(returnData, (uint256, uint256, int96));
    }



}
