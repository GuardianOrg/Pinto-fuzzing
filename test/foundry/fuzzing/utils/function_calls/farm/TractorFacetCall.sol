// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract TractorFacetCalls is FuzzBase, FuzzStorageVariables {

    function _updateTractorVersionall(string calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.updateTractorVersion.selector, _input));
    }

    function _getTractorVersionCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.getTractorVersion.selector));
    }

    function _publishRequisitionCall(LibTractor.Requisition calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.publishRequisition.selector, _input));
    }

    function _cancelBlueprintCall(LibTractor.Requisition calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.cancelBlueprint.selector, _input));
    }

    function _tractorCall(LibTractor.Requisition calldata _input1, bytes memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.tractor.selector, _input1, _input2));
    }

    function _sendTokenToInternalBalanceCall(IERC20 _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.sendTokenToInternalBalance.selector, _input1, _input2, _input3));
    }

    function _getCounterCall(address _input1, bytes32 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.getCounter.selector, _input1, _input2));
    }

    function _getPublisherCounterCall(bytes32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.getPublisherCounter.selector, _input1));
    }

    function _updatePublisherCounterCall(bytes32 _input1, LibTractor.CounterUpdateType _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.updatePublisherCounter.selector, _input1, _input2, _input3));
    }

    function _getBlueprintNonceCall(bytes32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.getBlueprintNonce.selector, _input1));
    }

    function _getBlueprintHashCall(LibTractor.Blueprint calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.getBlueprintHash.selector, _input1));
    }

    function _tractorUserCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.tractorUser.selector));
    }

    function _operatorCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TractorFacet.operator.selector));
    }

}