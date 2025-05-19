// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/silo/PreconditionsSiloFacet.sol";
import "../../helpers/postconditions/silo/PostconditionsSiloFacet.sol";

contract FuzzSiloFacet is PreconditionsSiloFacet, PostconditionsSiloFacet {

    function fuzz_deposit_silo_facet(uint256 _amountSalt, uint256 _modeSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        console.log(token.name());
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 mode = fl.clamp(_modeSalt, 0, 3);

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();
        _before(actorsToUpdate);

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount);


        (bool success, bytes memory returnData) = _depositCall(address(token), tokenAmount, LibTransfer.From(mode));

        _siloFacetPostCondition(success, returnData, actorsToUpdate);
        
    }

    function fuzz_withdraw_silo_facet(uint256 _amountSalt, uint256 _modeSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        console.log(token.name());
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 mode = fl.clamp(_modeSalt, 0, 3);

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();
        _before(actorsToUpdate);

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount);

        (bool success, bytes memory returnData) = _depositCall(address(token), tokenAmount, LibTransfer.From(mode));

        if (!success) {
            revert(); //@TODO better error handeling
        }

        (uint256 amount, uint256 bdv, int96 stem) = abi.decode(returnData, (uint256, uint256, int96));

        (success, returnData) = _withdrawDepositCall(address(token), stem, amount, LibTransfer.To(mode % 2));

        _siloFacetPostCondition(success, returnData, actorsToUpdate);
        
    }

    function fuzz_multi_withdraw_silo_facet(uint256 _amountSalt1, uint256 _amountSalt2, uint256 _modeSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        console.log(token.name());
        uint256 tokenAmount1 = fl.clamp(_amountSalt1, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 tokenAmount2 = fl.clamp(_amountSalt2, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 mode = fl.clamp(_modeSalt, 0, 1);

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();
        _before(actorsToUpdate);

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount1 + tokenAmount2);

        (int96[] memory stems, uint256[] memory amounts) = _doubleDeposit(token, tokenAmount1, tokenAmount2);

        (bool success, bytes memory returnData) = this._withdrawDepositsCall(address(token), stems, amounts, LibTransfer.To(mode));

        _siloFacetPostCondition(success, returnData, actorsToUpdate);
        
    }

    function fuzz_transfer_deposit_silo_facet(uint256 _amountSalt, uint256 _receiverSalt, uint256 _modeSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 mode = fl.clamp(_modeSalt, 0, 3);
        uint256 recieverIndex = fl.clamp(_receiverSalt, 0, 2);

        // verify different user is receiver
        address receiver = USERS[recieverIndex];
        if (receiver == currentActor) {
            receiver = USERS[(recieverIndex + 1) % 3];
        }

        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        actorsToUpdate[1] = receiver;

        _setWellLiquidity();
        _before(actorsToUpdate);

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount);

        // deposit
        (bool success, bytes memory returnData) = _depositCall(address(token), tokenAmount, LibTransfer.From(mode));
        if (!success) {
            revert(); //@TODO better error handeling
        }
        (uint256 amount, uint256 bdv, int96 stem) = abi.decode(returnData, (uint256, uint256, int96));

        // transfer deposit
        (success, returnData) = _transferDepositCall(currentActor, receiver, address(token), stem, amount);

        _siloFacetPostCondition(success, returnData, actorsToUpdate);
        
    }


    function fuzz_multi_transfer_silo_facet(uint256 _amountSalt1, uint256 _amountSalt2, uint256 _receiverSalt, uint256 _modeSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        uint256 tokenAmount1 = fl.clamp(_amountSalt1, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 tokenAmount2 = fl.clamp(_amountSalt2, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 recieverIndex = fl.clamp(_receiverSalt, 0, 2);

        // verify different user is receiver
        address receiver = USERS[recieverIndex];
        if (receiver == currentActor) {
            receiver = USERS[(recieverIndex + 1) % 3];
        }

        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        actorsToUpdate[1] = receiver;

        _setWellLiquidity();
        _before(actorsToUpdate);

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount1 + tokenAmount2);

        (int96[] memory stems, uint256[] memory amounts) = _doubleDeposit(token, tokenAmount1, tokenAmount2);

        int256[] memory stems256 = new int256[](2);
        stems256[0] = int256(stems[0]);
        stems256[1] = int256(stems[1]);

        // transfer deposits
        (bool success, bytes memory returnData) = this._transferDepositsCall(currentActor, receiver, address(token), stems256, amounts);

        _siloFacetPostCondition(success, returnData, actorsToUpdate);
        
    }

}