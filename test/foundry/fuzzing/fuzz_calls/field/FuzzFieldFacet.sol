// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/field/PreconditionsFieldFacet.sol";
import "../../helpers/postconditions/field/PostconditionsFieldFacet.sol";

contract FuzzFieldFacet is PreconditionsFieldFacet, PostconditionsFieldFacet {

    function fuzz_sow_field(uint256 _amountSalt, uint32 _tempSalt, uint256 _modeSalt) public setCurrentActor() {
        MockToken token = mockTokens[0];
        uint256 amount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint32 temp = uint32(fl.clamp(_tempSalt, 1, 1e6)); //@TODO consider changing
        uint256 mode = fl.clamp(_modeSalt, 0, 2);

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _before(actorsToUpdate);

        vm.prank(ADMIN);
        beanToken.mint(currentActor, amount);

        (bool success, bytes memory returnData) = _sowCall(amount, temp, LibTransfer.From(mode));
        assert(success);
    }

    // sow
    // check that beans are burnt
    // check that pods increase

    function fuzz_add_active_field(uint32 _temp) public {

        (bool success, bytes memory returnData) = _fieldCountCall();
        uint256 nextField = abi.decode(returnData, (uint256));
        
        vm.prank(ADMIN);
        (success, returnData) = _addFieldCall();
        assert(success);

        (success, returnData) = _setActiveFieldCall(nextField, _temp);
        
    }

}