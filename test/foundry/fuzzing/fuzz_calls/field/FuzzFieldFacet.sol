// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/field/PreconditionsFieldFacet.sol";
import "../../helpers/postconditions/field/PostconditionsFieldFacet.sol";

contract FuzzFieldFacet is PreconditionsFieldFacet, PostconditionsFieldFacet {

    function fuzz_sow_field(uint256 _amountSalt, uint32 _tempSalt, uint256 _modeSalt) public setCurrentActor() {
        MockToken token = mockTokens[0];
        uint256 amount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());
        uint32 temp = uint32(fl.clamp(_tempSalt, 1, 1e6));
        uint256 mode = fl.clamp(_modeSalt, 0, 2);

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _addSoil();

        vm.prank(ADMIN);
        beanToken.mint(currentActor, amount);


        _before(actorsToUpdate);

        (bool success, bytes memory returnData) = _sowCall(amount, temp, LibTransfer.From(mode));
        _fieldSowPostConditions(amount, success, returnData, actorsToUpdate);
    }

    function fuzz_sow_min_field(uint256 _amountSalt, uint32 _tempSalt, uint256 _modeSalt, uint256 _minAmountSalt) public setCurrentActor() {
        MockToken token = mockTokens[0];
        uint256 amount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());
        uint32 temp = uint32(fl.clamp(_tempSalt, 1, 1e6));
        uint256 mode = fl.clamp(_modeSalt, 0, 2);

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _addSoil();

        vm.prank(ADMIN);
        beanToken.mint(currentActor, amount);

        (bool success, bytes memory returnData) = _totalSoilCall();
        uint256 totalSoil = abi.decode(returnData, (uint256));

        uint256 minSoil = fl.clamp(_minAmountSalt, 1, totalSoil);

        _before(actorsToUpdate);

        (success, returnData) = _sowWithMinCall(amount, temp, minSoil, LibTransfer.From(mode));
        _fieldSowPostConditions(amount, success, returnData, actorsToUpdate);
    }

    function fuzz_add_active_field(uint32 _temp) public setCurrentActor {

        (bool success, bytes memory returnData) = _fieldCountCall();
        uint256 nextField = abi.decode(returnData, (uint256));

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;
        
        vm.prank(address(diamond));
        (success, returnData) = address(diamond).call(abi.encodeWithSelector(FieldFacet.addField.selector));
        assert(success);

        _before(actorsToUpdate);

        vm.prank(address(diamond));
        (success, returnData) = address(diamond).call(abi.encodeWithSelector(FieldFacet.setActiveField.selector, nextField, _temp));

        _fieldAddFieldPostConditions(nextField, success, returnData, actorsToUpdate);
        
    }


    function fuzz_harvest_field(uint256 _amountSalt, uint32 _tempSalt, uint256 _startSalt, uint256 _endSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 amount = fl.clamp(_amountSalt, 200, 10000) * (10 ** token.decimals());
        uint32 temp = uint32(fl.clamp(_tempSalt, 1, 1e6));
        uint256 mode = 0;

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        // fast forwards seasons to a point where there is soil
        _addSoil();

        _depositWellSilo(address(beanEthWell), currentActor);
        _depositWellSilo(address(beanWstEthWell), currentActor);


        vm.prank(ADMIN);
        beanToken.mint(currentActor, amount);

        (bool success, bytes memory returnData) = _sowCall(amount, temp, LibTransfer.From(mode));
        assert(success);

        // gets us to a state where we can harvest
        _forceHarvestState();

        (success, returnData) = _activeFieldCall();
        uint256 activeField = abi.decode(returnData, (uint256));

        (success, returnData) = _getPlotsFromAccountCall(currentActor, activeField);
        Plot[] memory plots = abi.decode(returnData, (Plot[]));
        uint256[] memory plotIds = new uint256[](plots.length);

        uint256 startIndex = fl.clamp(_startSalt, 0, plots.length - 1);
        uint256 endIndex = fl.clamp(_endSalt, startIndex, plots.length - 1);
        uint256 i = startIndex;
        for (i; i < endIndex; ++i) {
            plotIds[i] = plots[i].index;
        }

        _before(actorsToUpdate);

        (success, returnData) = this._harvestCall(activeField, plotIds, LibTransfer.To(0));
        _fieldHarvestPostConditions(success, returnData, actorsToUpdate);
       
    }
}