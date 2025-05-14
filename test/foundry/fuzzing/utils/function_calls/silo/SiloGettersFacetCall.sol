// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract SiloGettersFacetCalls is FuzzBase, FuzzStorageVariables {

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
}