// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract MarketplaceFacetCalls is FuzzBase, FuzzStorageVariables {

    function _createPodListingCall(Listing.PodListing calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.createPodListing.selector, _input1));
    }

    function _createPodListingCall(Listing.PodListing calldata _input1, uint256 _input2, LibTransfer.From _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.fillPodListing.selector, _input1, _input2, _input3));
    }

    function _cancelPodListingCall(uint256 _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.cancelPodListing.selector, _input1, _input2));
    }

    function _getPodListingCall(uint256 _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.getPodListing.selector, _input1, _input2));
    }

    function _createPodOrderCall(Order.PodOrder calldata _input1, uint256 _input2, LibTransfer.From _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.createPodOrder.selector, _input1, _input2, _input3));
    }

    function _createPodOrderCall(Order.PodOrder calldata _input1, uint256 _input2, uint256 _input3, uint256 _input4, LibTransfer.To _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.createPodOrder.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _cancelPodOrderCall(Order.PodOrder calldata _input1, LibTransfer.To _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.cancelPodOrder.selector, _input1, _input2));
    }

    function _getOrderIdCall(Order.PodOrder calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.getOrderId.selector, _input1));
    }

    function _getPodOrderCall(bytes32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.getPodOrder.selector, _input1));
    }

    function _transferPlotCall(address _input1, address _input2, uint256 _input3, uint256 _input4, uint256 _input5, uint256 _input6) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.transferPlot.selector, _input1, _input2, _input3, _input4, _input5, _input6));
    }

    function _transferPlotsCall(address _input1, address _input2, uint256 _input3, uint256[] calldata _input4, uint256[] calldata _input5, uint256[] calldata _input6) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.transferPlots.selector, _input1, _input2, _input3, _input4, _input5, _input6));
    }

    function _approvePodsCall(address _input1, uint256 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MarketplaceFacet.approvePods.selector, _input1, _input2, _input3));
    }

}