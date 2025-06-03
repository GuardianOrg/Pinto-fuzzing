// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/silo/PreconditionsSiloFacet.sol";
import "../../helpers/postconditions/silo/PostconditionsSiloFacet.sol";

contract FuzzSiloFacet is PreconditionsSiloFacet, PostconditionsSiloFacet {

    function fuzz_deposit_silo_facet(uint256 _amountSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        console.log(token.name());
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());
        uint256 mode = 0;

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();
        
        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount);

        _before(actorsToUpdate);

        console.log("amount pre : ", tokenAmount);

        (bool success, bytes memory returnData) = _depositCall(address(token), tokenAmount, LibTransfer.From(mode));

        console.log("maks it here again");

        _siloDepositPostConditions(tokenAmount, token, success, returnData, actorsToUpdate);
        
    }

    function fuzz_withdraw_silo_facet(uint256 _amountSalt, uint256 _withdrawSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        console.log(token.name());
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());

        uint256 mode = 0;

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();
        

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount);

        (bool success, bytes memory returnData) = _depositCall(address(token), tokenAmount, LibTransfer.From(mode));
        assert(success);

        (uint256 amount, uint256 bdv, int96 stem) = abi.decode(returnData, (uint256, uint256, int96));

        amount = fl.clamp(_withdrawSalt, 1, amount);

        _before(actorsToUpdate);

        (success, returnData) = _withdrawDepositCall(address(token), stem, amount, LibTransfer.To(mode));

        _siloWithdrawPostConditions(token, tokenAmount, amount, success, returnData, actorsToUpdate);
        
    }

    function fuzz_multi_withdraw_silo_facet(uint256 _amountSalt1, uint256 _amountSalt2) public setCurrentActor {

        MockToken token = mockTokens[0];
        console.log(token.name());
        uint256 tokenAmount1 = fl.clamp(_amountSalt1, 1, 10000) * (10 ** token.decimals());
        uint256 tokenAmount2 = fl.clamp(_amountSalt2, 1, 10000) * (10 ** token.decimals());
        uint256 mode = 0;

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();
        

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount1 + tokenAmount2);

        (int96[] memory stems, uint256[] memory amounts) = _doubleDeposit(token, tokenAmount1, tokenAmount2);

        amounts[0]= fl.clamp(_amountSalt1, 1, amounts[0]);
        amounts[1] = fl.clamp(_amountSalt2, 1, amounts[1]);

        _before(actorsToUpdate);

        (bool success, bytes memory returnData) = this._withdrawDepositsCall(address(token), stems, amounts, LibTransfer.To(mode));
        _siloWithdrawMultiPostConditions(token, amounts[0], amounts[1], success, returnData, actorsToUpdate);
        
    }

    function fuzz_transfer_deposit_silo_facet(uint256 _amountSalt, uint256 _receiverSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());
        uint256 mode = 0;
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
        

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount);

        // deposit
        (bool success, bytes memory returnData) = _depositCall(address(token), tokenAmount, LibTransfer.From(0));
        assert(success);

        (uint256 amount, uint256 bdv, int96 stem) = abi.decode(returnData, (uint256, uint256, int96));

        uint256 transferAmount = fl.clamp(_receiverSalt, 1, amount);

        _before(actorsToUpdate);

        // transfer deposit
        (success, returnData) = _transferDepositCall(currentActor, receiver, address(token), stem, transferAmount);

        _siloTransferPostConditions(token, transferAmount, success, returnData, actorsToUpdate);
        
    }


    function fuzz_multi_transfer_silo_facet(uint256 _amountSalt1, uint256 _amountSalt2, uint256 _receiverSalt) public setCurrentActor {

        MockToken token = mockTokens[0];
        uint256 tokenAmount1 = fl.clamp(_amountSalt1, 1, 10000) * (10 ** token.decimals());
        uint256 tokenAmount2 = fl.clamp(_amountSalt2, 1, 10000) * (10 ** token.decimals());
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
        

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount1 + tokenAmount2);

        (int96[] memory stems, uint256[] memory amounts) = _doubleDeposit(token, tokenAmount1, tokenAmount2);

        amounts[0]= fl.clamp(_amountSalt1, 1, amounts[0]);
        amounts[1] = fl.clamp(_amountSalt2, 1, amounts[1]);

        int256[] memory stems256 = new int256[](2);
        stems256[0] = int256(stems[0]);
        stems256[1] = int256(stems[1]);

        _before(actorsToUpdate);

        // transfer deposits
        (bool success, bytes memory returnData) = this._transferDepositsCall(currentActor, receiver, address(token), stems256, amounts);

        _siloTransferMultiPostConditions(token, amounts[0], amounts[1], success, returnData, actorsToUpdate);
        
    }

    function fuzz_transfer_from_silo_facet(uint256 _amountSalt, uint256 _receiverSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());
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
        

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount);

        // deposit
        (bool success, bytes memory returnData) = _depositCall(address(token), tokenAmount, LibTransfer.From(0));
        assert(success);

        (uint256 amount, uint256 bdv, int96 stem) = abi.decode(returnData, (uint256, uint256, int96));


        (success, returnData) = _getDepositIdCall(address(token), stem);
        assert(success);

        uint256 _depositId = abi.decode(returnData, (uint256));

        _before(actorsToUpdate);
        
       
        (success, returnData) = this._safeTransferFromCall(currentActor, receiver, _depositId, amount, new bytes(0));

        _siloTransferPostConditions(token, amount, success, returnData, actorsToUpdate);
    }

    function fuzz_multi_transfer_from_silo_facet(uint256 _amountSalt1, uint256 _amountSalt2, uint256 _receiverSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 tokenAmount1 = fl.clamp(_amountSalt1, 1, 10000) * (10 ** token.decimals());
        uint256 tokenAmount2 = fl.clamp(_amountSalt2, 1, 10000) * (10 ** token.decimals());
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
        

        vm.prank(ADMIN);
        beanToken.mint(currentActor, tokenAmount1 + tokenAmount2);

        (int96[] memory stems, uint256[] memory amounts) = _doubleDeposit(token, tokenAmount1, tokenAmount2);

        (bool success, bytes memory returnData) = _getDepositIdCall(address(token), stems[0]);
        assert(success);

        uint256[] memory depositIds = new uint256[](2);

        depositIds[0] = abi.decode(returnData, (uint256));

        (success, returnData) = _getDepositIdCall(address(token), stems[1]);
        assert(success);

        depositIds[1] = abi.decode(returnData, (uint256));

        _before(actorsToUpdate);

        console.log("STEM 0 :", stems[0]);
        console.log("STEM 1 :", stems[1]);

        console.log("amnt 0 :", amounts[0]);
        console.log("amnt 1 :", amounts[1]);

        
        (success, returnData) = this._safeBatchTransferFromCall(currentActor, receiver, depositIds, amounts, new bytes(0));

        _siloTransferMultiPostConditions(token, amounts[0], amounts[1], success, returnData, actorsToUpdate);
    }


}