// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../helpers/FuzzStorageVariables.sol";

contract FunctionCalls is FuzzBase, FuzzStorageVariables {

    function _pipeCall(PipeCall calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(DepotFacet.pipe.selector, _input));
    }

    function _multiPipeCall(PipeCall[] calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(DepotFacet.multiPipe.selector, _input));
    }

    //@TODO look into this being payable
    function _advancedPipeCall(PipeCall[] calldata _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(DepotFacet.advancedPipe.selector, _input1, _input2));
    }


    //@TODO look into this being payable
    function _etherPipeCall(PipeCall[] calldata _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(DepotFacet.etherPipe.selector, _input1, _input2));
    }

    function _readPipeCall(PipeCall[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(DepotFacet.readPipe.selector, _input1));
    }

    function _farmCall(bytes[] calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FarmFacet.farm.selector, _input));
    }

    function _advancedFarmCall(AdvancedFarmCall[] calldata _input) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(FarmFacet.advancedFarm.selector, _input));
    }

    function _transferTokenCall(IERC20 _input1, address _input2, address _input3, LibTransfer.From _input4, LibTransfer.To _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.transferToken.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _transferInternalTokenFromCall(IERC20 _input1, address _input2, address _input3, uint256 _input4, LibTransfer.To _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.transferInternalTokenFrom.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _approveTokenCall(address _input1, IERC20 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.approveToken.selector, _input1, _input2, _input3));
    }


    function _increaseTokenAllowanceCall(address _input1, IERC20 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.increaseTokenAllowance.selector, _input1, _input2, _input3));
    }

    function _decreaseTokenAllowanceCall(address _input1, IERC20 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.decreaseTokenAllowance.selector, _input1, _input2, _input3));
    }

    function _tokenAllowanceCall(address _input1, address _input2, IERC20 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.tokenAllowance.selector, _input1, _input2, _input3));
    }

    function _onERC1155ReceivedCall(address _input1, address _input2, uint256 _input3, uint256 _input4, bytes calldata _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.onERC1155Received.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _onERC1155BatchReceivedCall(address _input1, address _input2, uint256[] calldata _input3, uint256[] calldata _input4, bytes calldata _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.onERC1155BatchReceived.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _wrapEthCall(uint256 _input1, LibTransfer.To _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.wrapEth.selector, _input1, _input2));
    }

    function _unwrapEthCall(uint256 _input1, LibTransfer.From _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.unwrapEth.selector, _input1, _input2));
    }

    function _getInternalBalanceCall(address _input1, IERC20 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.getInternalBalance.selector, _input1, _input2));
    }

    function _getInternalBalancesCall(address _input1, IERC20[] memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.getInternalBalances.selector, _input1, _input2));
    }

    function _getExternalBalanceCall(address _input1, IERC20 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.getExternalBalance.selector, _input1, _input2));
    }

    function _getExternalBalancesCall(address _input1, IERC20[] memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.getExternalBalances.selector, _input1, _input2));
    }

    function _getBalanceCall(address _input1, IERC20 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.getBalance.selector, _input1, _input2));
    }

    function _getBalancesCall(address _input1, IERC20[] memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.getBalances.selector, _input1, _input2));
    }

    function _getAllBalanceCall(address _input1, IERC20 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.getAllBalance.selector, _input1, _input2));
    }

    function _getAllBalancesCall(address _input1, IERC20[] memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenFacet.getAllBalances.selector, _input1, _input2));
    }

    function _transferERC721Call(IERC721 _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenSupportFacet.transferERC721.selector, _input1, _input2, _input3));
    }

    function _transferERC1155Call(IERC1155 _input1, address _input2, uint256 _input3, uint256 _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenSupportFacet.transferERC1155.selector, _input1, _input2, _input3, _input4));
    }

    function _batchTransferERC1155Call(IERC1155 _input1, address _input2, uint256[] calldata _input3, uint256[] calldata _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(TokenSupportFacet.batchTransferERC1155.selector, _input1, _input2, _input3, _input4));
    }

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

    function _uriCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MetadataFacet.uri.selector, _input1));
    }

    function _nameCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MetadataFacet.uri.selector));
    }

    function _symbolCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(MetadataFacet.symbol.selector));
    }

    function _approveDepositCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.approveDeposit.selector, _input1, _input2, _input3));
    }

    function _increaseDepositAllowanceCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.increaseDepositAllowance.selector, _input1, _input2, _input3));
    }

    function _decreaseDepositAllowanceCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.decreaseDepositAllowance.selector, _input1, _input2, _input3));
    }

    function _depositAllowanceCall(address _input1, address _input2, address _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.depositAllowance.selector, _input1, _input2, _input3));
    }

    function _setApprovalForAllCall(address _input1, bool _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.setApprovalForAll.selector, _input1, _input2));
    }

    function _isApprovedForAllCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ApprovalFacet.isApprovedForAll.selector, _input1, _input2));
    }

    function _beanToBDVCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(BDVFacet.beanToBDV.selector, _input1));
    }

    function _wellBdvCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(BDVFacet.beanToBDV.selector, _input1, _input2));
    }

    function _claimPlentyCall(uint256 _input1, LibTransfer.To _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ClaimFacet.claimPlenty.selector, _input1, _input2));
    }

    function _claimAllPlentyCall(LibTransfer.To _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ClaimFacet.claimAllPlenty.selector, _input1));
    }

    function _mowCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ClaimFacet.mow.selector, _input1, _input2));
    }

    function _mowMultipleCall(address _input1, address[] calldata _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ClaimFacet.mowMultiple.selector, _input1, _input2));
    }

    function _mowAllCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ClaimFacet.mowAll.selector, _input1));
    }

    function _mowMultipleAccountsCall(address[] calldata _input1, address[][] calldata _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ClaimFacet.mowMultipleAccounts.selector, _input1, _input2));
    }


    function _mowMultipleAccountsCall(address[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ClaimFacet.mowMultipleAccounts.selector, _input1));
    }

    function _plantCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ClaimFacet.plant.selector));
    }

    function _convertCall(bytes calldata _input1, int96[] memory _input2, uint256[] memory _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertFacet.convert.selector, _input1, _input2, _input3));
    }

    function _getMaxAmountInCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.getMaxAmountIn.selector, _input1, _input2));
    }

    function _getAmountOutCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.getAmountOut.selector, _input1, _input2, _input3));
    }

    function _overallCappedDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.overallCappedDeltaB.selector));
    }

    function _overallCurrentDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.overallCurrentDeltaB.selector));
    }

    function _scaledDeltaBCall(uint256 _input1, uint256 _input2, int256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.scaledDeltaB.selector, _input1, _input2, _input3));
    }

    function _cappedReservesDeltaBCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.cappedReservesDeltaB.selector, _input1));
    }

    function _calculateDeltaBFromReservesCall(address _input1, uint256[] memory _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.calculateDeltaBFromReserves.selector, _input1, _input2, _input3));
    }

    function _getOverallConvertCapacityCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.getOverallConvertCapacity.selector));
    }

    function _getWellConvertCapacityCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.getWellConvertCapacity.selector, _input1));
    }

    function _calculateStalkPenaltyCall(LibConvert.DeltaBStorage memory _input1, uint256 _input2, uint256 _input3, address _input4, address _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.calculateStalkPenalty.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _downPenalizedGrownStalkCall(address _input1, uint256 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertGettersFacet.downPenalizedGrownStalk.selector, _input1, _input2, _input3));
    }

    function _pipelineConvertCall(address _input1, int96[] calldata _input2, uint256[] calldata _input3, address _input4, AdvancedPipeCall[] memory  _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(PipelineConvertFacet.pipelineConvert.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _depositCall(address _input1, uint256 _input2, LibTransfer.From _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloFacet.deposit.selector, _input1, _input2, _input3));
    }

    function _withdrawDepositCall(address _input1, int96 _input2, uint256 _input3, LibTransfer.To _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloFacet.withdrawDeposit.selector, _input1, _input2, _input3));
    }

    function _withdrawDepositsCall(address _input1, int96[] calldata _input2, uint256[] calldata _input3, LibTransfer.To _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloFacet.withdrawDeposit.selector, _input1, _input2, _input3, _input4));
    }

    function _transferDepositCall(address _input1, address _input2, address _input3, int256 _input4, uint256 _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloFacet.transferDeposit.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _transferDepositsCall(address _input1, address _input2, address _input3, int256[] calldata _input4, uint256[] calldata _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloFacet.transferDeposits.selector, _input1, _input2, _input3, _input4, _input5));
    }


    function _safeTransferFromCall(address _input1, address _input2, uint256 _input3, uint256 _input4, bytes calldata _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloFacet.safeTransferFrom.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _safeBatchTransferFromCall(address _input1, address _input2, uint256[] calldata _input3, uint256[] calldata _input4, bytes calldata _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloFacet.safeBatchTransferFrom.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _updateSortedDepositIdsCall(address _input1, address _input2, uint256[] calldata _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloFacet.updateSortedDepositIds.selector, _input1, _input2, _input3));
    }

    function _getBeanTokenCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getBeanToken.selector));
    }

    function _getDepositCall(address _input1, address _input2, int96 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getDeposit.selector, _input1, _input2, _input3));
    }

    function _getTotalDepositedCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTotalDeposited.selector, _input1));
    }

    function _getTotalSiloDepositedCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTotalSiloDeposited.selector));
    }

    function _getTotalDepositedBdvCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTotalDepositedBdv.selector, _input1));
    }

    function _getTotalSiloDepositedBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTotalSiloDepositedBdv.selector));
    }

    function _getGerminatingTotalDepositedCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getGerminatingTotalDeposited.selector, _input1));
    }

    function _getGerminatingTotalDepositedBdvCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getGerminatingTotalDepositedBdv.selector, _input1));
    }

    function _tokenSettingsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.tokenSettings.selector, _input1));
    }

    function _balanceOfCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOf.selector, _input1, _input2));
    }

    function _balanceOfBatchCall(address[] calldata _input1, uint256[] calldata _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfBatch.selector, _input1, _input2));
    }


    function _getDepositIdCall(address _input1, int96 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getDepositId.selector, _input1, _input2));
    }

    function _getAddressAndStemCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getAddressAndStem.selector, _input1));
    }

    function _bdvCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.bdv.selector, _input1, _input2));
    }

    function _bdvsCall(address[] calldata _input1, uint256[] calldata _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.bdvs.selector, _input1, _input2));
    }

    function _lastUpdateCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.lastUpdate.selector, _input1));
    }


    function _totalStalkCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.totalStalk.selector));
    }

    function _getGerminatingStalkAndRootsForSeasonCall(uint32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getGerminatingStalkAndRootsForSeason.selector, _input1));
    }

    function _getGerminatingRootsForSeasonCall(uint32 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getGerminatingRootsForSeason.selector, _input1));
    }

    function _getTotalGerminatingStalkCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTotalGerminatingStalk.selector));
    }

    function _getYoungAndMatureGerminatingTotalStalkCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getYoungAndMatureGerminatingTotalStalk.selector));
    }

    function _getTotalGerminatingAmountCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTotalGerminatingAmount.selector, _input1));
    }

    function _getTotalGerminatingBdvCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTotalGerminatingBdv.selector, _input1));
    }

    function _getOddGerminatingCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getOddGerminating.selector, _input1));
    }

    function _getEvenGerminatingCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getEvenGerminating.selector, _input1));
    }

    function _balanceOfFinishedGerminatingStalkAndRootsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfFinishedGerminatingStalkAndRoots.selector, _input1));
    }

    function _totalRootsCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.totalRoots.selector));
    }

    function _totalEarnedBeansCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.totalEarnedBeans.selector));
    }

    function _balanceOfStalkCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfStalk.selector, _input1));
    }

    function _balanceOfGerminatingStalkCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfGerminatingStalk.selector, _input1));
    }

    function _balanceOfYoungAndMatureGerminatingStalkCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfYoungAndMatureGerminatingStalk.selector, _input1));
    }


    function _balanceOfRootsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfRoots.selector, _input1));
    }

    function _balanceOfGrownStalkCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfGrownStalk.selector, _input1, _input2));
    }

    function _balanceOfGrownStalkMultipleCall(address _input1, address[] calldata _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfGrownStalkMultiple.selector, _input1, _input2));
    }

    function _grownStalkForDepositCall(address _input1, address _input2, int96 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.grownStalkForDeposit.selector, _input1, _input2, _input3));
    }

    function _balanceOfEarnedBeansCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfEarnedBeans.selector, _input1));
    }

    function _balanceOfEarnedStalkCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfEarnedStalk.selector, _input1));
    }

    function _balanceOfPlantableSeedsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfPlantableSeeds.selector, _input1));
    }

    function _stalkEarnedPerSeasonCall(address[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.stalkEarnedPerSeason.selector, _input1));
    }

    function _balanceOfDepositedBdvCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfDepositedBdv.selector, _input1, _input2));
    }

    function _getLastMowedStemCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getLastMowedStem.selector, _input1, _input2));
    }

    function _getMowStatusCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(bytes4(0x113c0f9b), _input1, _input2));
    }

    function _getMowStatusCall(address _input1, address[] calldata _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(bytes4(0x4b5483e3), _input1, _input2));
    }

    function _lastSeasonOfPlentyCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.lastSeasonOfPlenty.selector));
    }

    function _balanceOfPlentyCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfPlenty.selector, _input1, _input2));
    }

    function _balanceOfRainRootsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfRainRoots.selector, _input1));
    }

    function _balanceOfSopCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.balanceOfSop.selector, _input1));
    }

    function _totalRainRootsCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.totalRainRoots.selector));
    }

    function _stemTipForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.stemTipForToken.selector, _input1));
    }

    function _getStemTipsCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getStemTips.selector));
    }

    function _calculateStemForTokenFromGrownStalkCall(address _input1, uint256 _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.calculateStemForTokenFromGrownStalk.selector, _input1, _input2, _input3));
    }

    function _getGerminatingStemCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getGerminatingStem.selector, _input1));
    }

    function _getHighestNonGerminatingStemCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getHighestNonGerminatingStem.selector, _input1));
    }

    function _getGerminatingStemsCall(address[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getGerminatingStems.selector, _input1));
    }

    function _getHighestNonGerminatingStemsCall(address[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getHighestNonGerminatingStems.selector, _input1));
    }

    function _getDepositsForAccountCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(bytes4(0x0c8d13f8), _input1));
    }

    function _getDepositsForAccountCall(address _input1, address[] calldata _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(bytes4(0xced2e3e8), _input1, _input2));
    }

    function _getTokenDepositsForAccountCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTokenDepositsForAccount.selector, _input1, _input2));
    }

    function _getTokenDepositIdsForAccountCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getTokenDepositIdsForAccount.selector, _input1, _input2));
    }

    function _getIndexForDepositIdCall(address _input1, address _input2, uint256 _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getIndexForDepositId.selector, _input1, _input2, _input3));
    }

    function _getBeanIndexCall(IERC20[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getBeanIndex.selector, _input1));
    }

    function _getNonBeanTokenAndIndexFromWellCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SiloGettersFacet.getNonBeanTokenAndIndexFromWell.selector, _input1));
    }

    function _dewhitelistTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.dewhitelistToken.selector, _input1));
    }

    function _whitelistTokenCall(address _input1, bytes4 _input2, uint48 _input3, uint40 _input4, bytes1 _input5, uint128 _input6, uint64 _input7, Implementation memory _input8, Implementation memory _input9, Implementation memory _input10) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.whitelistToken.selector, _input1, _input2, _input3, _input4, _input5, _input6, _input7, _input8, _input9, _input10));
    }

    function _updateStalkPerBdvPerSeasonForTokenCall(address _input1, uint40 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateStalkPerBdvPerSeasonForToken.selector, _input1, _input2));
    }


    function _updateGaugeForTokenCall(address _input1, uint64 _input2,Implementation memory _input3, Implementation memory _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateGaugeForToken.selector, _input1, _input2, _input3, _input4));
    }

    function _updateOracleImplementationForTokenCall(address _input1, Implementation memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateOracleImplementationForToken.selector, _input1, _input2));
    }

    function _updateLiquidityWeightImplementationForTokenCall(address _input1, Implementation memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateLiquidityWeightImplementationForToken.selector, _input1, _input2));
    }

    function _updateGaugePointImplementationForTokenCall(address _input1, Implementation memory _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateGaugePointImplementationForToken.selector, _input1, _input2));
    }

    function _updateSeedGaugeSettingsCall(EvaluationParameters memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateSeedGaugeSettings.selector, _input1));
    }

    function _getOracleImplementationForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.getOracleImplementationForToken.selector, _input1));
    }

    function _getGaugePointImplementationForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.getGaugePointImplementationForToken.selector, _input1));
    }

    function _getLiquidityWeightImplementationForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(WhitelistFacet.getLiquidityWeightImplementationForToken.selector, _input1));
    }

    function _cultivationFactorCall(bytes memory _input1, bytes memory _input2, bytes memory _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.cultivationFactor.selector, _input1, _input2, _input3));
    }

    function _convertDownPenaltyGaugeCall(bytes memory _input1, bytes memory _input2, bytes memory _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.convertDownPenaltyGauge.selector, _input1, _input2, _input3));
    }

    function _getGaugeCall(GaugeId _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.getGauge.selector, _input1));
    }

    function _getGaugeValueCall(GaugeId _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.getGaugeValue.selector, _input1));
    }

    function _getGaugeDataCall(GaugeId _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeFacet.getGaugeData.selector, _input1));
    }

    function _getAverageGrownStalkPerBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getAverageGrownStalkPerBdv.selector));
    }

    function _getTotalBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getTotalBdv.selector));
    }

    function _getSeedGaugeCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getSeedGauge.selector));
    }

    function _getAverageGrownStalkPerBdvPerSeasonCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getAverageGrownStalkPerBdvPerSeason.selector));
    }

    function _getBeanToMaxLpGpPerBdvRatioCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getBeanToMaxLpGpPerBdvRatio.selector));
    }

    function _getBeanToMaxLpGpPerBdvRatioScaledCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getBeanToMaxLpGpPerBdvRatioScaled.selector));
    }

    function _getGaugePointsPerBdvForTokenCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGaugePointsPerBdvForToken.selector, _input1));
    }

    function _getGaugePointsPerBdvForWellCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGaugePointsPerBdvForWell.selector, _input1));
    }

    function _getLargestGpPerBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getLargestGpPerBdv.selector));
    }

    function _getBeanGaugePointsPerBdvCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getBeanGaugePointsPerBdv.selector));
    }

    function _getGrownStalkIssuedPerSeasonCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGrownStalkIssuedPerSeason.selector));
    }

    function _getGrownStalkIssuedPerGpCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGrownStalkIssuedPerGp.selector));
    }

    function _getPodRateCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getPodRate.selector, _input1));
    }

    function _getLiquidityToSupplyRatioCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getLiquidityToSupplyRatio.selector));
    }

    function _getDeltaPodDemandCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getDeltaPodDemand.selector));
    }

    function _getGaugePointsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGaugePoints.selector, _input1));
    }

    function _calcGaugePointsWithParamsCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.calcGaugePointsWithParams.selector, _input1, _input2));
    }

    function _getGaugePointsWithParamsCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(GaugeGettersFacet.getGaugePointsWithParams.selector, _input1));
    }

    function _maxWeightCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(LiquidityWeightFacet.maxWeight.selector, _input1));
    }

    function _noWeightCall(bytes memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(LiquidityWeightFacet.noWeight.selector, _input1));
    }

    function _getUsdTokenPriceCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getUsdTokenPrice.selector, _input1));
    }

    function _getUsdTokenTwapCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getUsdTokenTwap.selector, _input1, _input2));
    }

    function _getTokenUsdPriceCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getTokenUsdPrice.selector, _input1));
    }

    function _getTokenUsdTwapCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getTokenUsdTwap.selector, _input1, _input2));
    }

    function _getUsdTokenPriceFromExternalCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getUsdTokenPriceFromExternal.selector, _input1, _input2));
    }

    function _getTokenUsdPriceFromExternalCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getTokenUsdPriceFromExternal.selector, _input1, _input2));
    }

    function _getRatiosAndBeanIndexCall(IERC20[] memory _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getRatiosAndBeanIndex.selector, _input1, _input2));
    }

    function _getMillionUsdPriceCall(address _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(OracleFacet.getMillionUsdPrice.selector, _input1, _input2));
    }

    function _sunriseCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonFacet.sunrise.selector));
    }

    function _gmCall(address _input1, LibTransfer.To _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonFacet.gm.selector, _input1, _input2));
    }

    function _seasonTimeCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonFacet.seasonTime.selector));
    }

    function _seasonCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.season.selector));
    }

    function _pausedCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.paused.selector));
    }

    function _timeCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.time.selector));
    }

    function _abovePegCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.abovePeg.selector));
    }

    function _sunriseBlockCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.sunriseBlock.selector));
    }

    function _weatherCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.weather.selector));
    }

    function _rainCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.rain.selector));
    }

    function _plentyPerRootCall(uint32 _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.plentyPerRoot.selector, _input1, _input2));
    }

    function _totalDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.totalDeltaB.selector));
    }

    function _totalDeltaBNoCapCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.totalDeltaBNoCap.selector));
    }


    function _poolDeltaBCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.plentyPerRoot.selector, _input1));
    }

    function _poolDeltaBNoCapCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.poolDeltaBNoCap.selector, _input1));
    }

    function _poolCurrentDeltaBCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.poolCurrentDeltaB.selector, _input1));
    }

    function _cumulativeCurrentDeltaBCall(address[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.cumulativeCurrentDeltaB.selector, _input1));
    }

    function _totalInstantaneousDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.totalInstantaneousDeltaB.selector));
    }

    function _wellOracleSnapshotCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.wellOracleSnapshot.selector, _input1));
    }

    function _getTwaLiquidityForWellCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getTwaLiquidityForWell.selector, _input1));
    }

    function _getWeightedTwaLiquidityForWellCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getWeightedTwaLiquidityForWell.selector, _input1));
    }

    function _getTotalUsdLiquidityCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getTotalUsdLiquidity.selector));
    }

    function _getTotalWeightedUsdLiquidityCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getTotalWeightedUsdLiquidity.selector));
    }

    function _getLargestLiqWellCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getLargestLiqWell.selector));
    }

    function _getCasesCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getCases.selector));
    }

    function _getCaseDataCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getCaseData.selector, _input1));
    }

    function _getChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getChangeFromCaseId.selector, _input1));
    }

    function _getAbsTemperatureChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getAbsTemperatureChangeFromCaseId.selector, _input1));
    }

    function _getRelTemperatureChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getRelTemperatureChangeFromCaseId.selector, _input1));
    }

    function _getAbsBeanToMaxLpRatioChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getAbsBeanToMaxLpRatioChangeFromCaseId.selector, _input1));
    }

    function _getRelBeanToMaxLpRatioChangeFromCaseIdCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getRelBeanToMaxLpRatioChangeFromCaseId.selector, _input1));
    }

    function _getSeasonStructCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getSeasonStruct.selector));
    }

    function _getSeasonTimestampCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getSeasonTimestamp.selector));
    }

    function _getEvaluationParametersCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getEvaluationParameters.selector));
    }

    function _getExtEvaluationParametersCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getExtEvaluationParameters.selector));
    }

    function _getMaxBeanMaxLpGpPerBdvRatioCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getMaxBeanMaxLpGpPerBdvRatio.selector));
    }

    function _getMinBeanMaxLpGpPerBdvRatioCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getMinBeanMaxLpGpPerBdvRatio.selector));
    }

    function _getTargetSeasonsToCatchUpCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getTargetSeasonsToCatchUp.selector));
    }

    function _getPodRateLowerBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getPodRateLowerBound.selector));
    }

    function _getPodRateOptimalCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getPodRateOptimal.selector));
    }

    function _getPodRateUpperBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getPodRateUpperBound.selector));
    }

    function _getDeltaPodDemandLowerBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getDeltaPodDemandLowerBound.selector));
    }

    function _getDeltaPodDemandUpperBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getDeltaPodDemandUpperBound.selector));
    }

    function _getLpToSupplyRatioUpperBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getLpToSupplyRatioUpperBound.selector));
    }

    function _getLpToSupplyRatioOptimalCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getLpToSupplyRatioOptimal.selector));
    }

    function _getLpToSupplyRatioLowerBoundCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getLpToSupplyRatioLowerBound.selector));
    }

    function _getExcessivePriceThresholdCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getExcessivePriceThreshold.selector));
    }

    function _getWellsByDeltaBCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(SeasonGettersFacet.getWellsByDeltaB.selector));
    }


}