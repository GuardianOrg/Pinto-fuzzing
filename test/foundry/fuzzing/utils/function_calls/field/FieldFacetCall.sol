// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract FieldFacetCalls is FuzzBase, FuzzStorageVariables {

    function _sowCall(uint256 _input1, uint256 _input2, LibTransfer.From _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.sow.selector, _input1, _input2, _input3));
    }

    function _sowWithMinCall(uint256 _input1, uint256 _input2, uint256 _input3, LibTransfer.From _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.sowWithMin.selector, _input1, _input2, _input3, _input4));
    }

    function _harvestCall(uint256 _input1, uint256[] calldata _input2, LibTransfer.To _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.harvest.selector, _input1, _input2, _input3));
    }

    function _addFieldCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.addField.selector));
    }

    function _setActiveFieldCall(uint256 _input1, uint32 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.setActiveField.selector, _input1, _input2));
    }

    function _podIndexCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.podIndex.selector, _input1));
    }

    function _harvestableIndexCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.harvestableIndex.selector, _input1));
    }

    function _totalPodsCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.totalPods.selector, _input1));
    }

    function _totalHarvestedCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.totalHarvested.selector, _input1));
    }

    function _totalHarvestableCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.totalHarvestable.selector, _input1));
    }

    function _totalHarvestableForActiveFieldCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.totalHarvestableForActiveField.selector));
    }

    function _totalUnharvestableCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.totalUnharvestable.selector, _input1));
    }

    function _totalUnharvestableForActiveFieldCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.totalUnharvestableForActiveField.selector));
    }

    function _floodHarvestablePodsCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.floodHarvestablePods.selector));
    }

    function _isHarvestingCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.isHarvesting.selector, _input1));
    }

    function _plotCall(address _input1, uint256 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.plot.selector, _input1, _input2, _input3));
    }

    function _activeFieldCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.activeField.selector));
    }

    function _fieldCountCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.fieldCount.selector));
    }

    function _totalSoilCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.totalSoil.selector));
    }

    function _initialSoilCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.initialSoil.selector));
    }

    function _temperatureCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.temperature.selector));
    }

    function _remainingPodsCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.remainingPods.selector));
    }

    function _getPlotIndexesFromAccountCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.getPlotIndexesFromAccount.selector, _input1, _input2));
    }

    function _getPlotsFromAccountCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.getPlotsFromAccount.selector, _input1, _input2));
    }

    function _balanceOfPodsCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FieldFacet.balanceOfPods.selector, _input1, _input2));
    }


}