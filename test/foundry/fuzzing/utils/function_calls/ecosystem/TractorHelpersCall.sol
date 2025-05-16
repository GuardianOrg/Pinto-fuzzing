// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract TractorHelpersCalls is FuzzBase, FuzzStorageVariables {

    function _getWithdrawalPlanExcludingPlanCall(address _input1,uint8[] memory _input2, uint256 _input3, uint256 _input4, LibTractorHelpers.WithdrawalPlan memory _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getWithdrawalPlanExcludingPlan.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _getWithdrawalPlanCall(address _input1,uint8[] memory _input2, uint256 _input3, uint256 _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getWithdrawalPlan.selector, _input1, _input2, _input3, _input4));
    }

    function _withdrawBeansFromSourcesCall(address _input1, uint8[] memory _input2, uint256 _input3, uint256 _input4, uint256 _input5, LibTransfer.To _input6, LibTractorHelpers.WithdrawalPlan memory _input7) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.withdrawBeansFromSources.selector, _input1, _input2, _input3, _input4, _input5, _input6, _input7));
    }

    function _getBeanstalkPriceCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getBeanstalkPrice.selector));
    }

    function _getSortedWhitelistedTokensBySeedsCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getSortedWhitelistedTokensBySeeds.selector));
    }

    function _getHighestSeedTokenCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getHighestSeedToken.selector));
    }

    function _getLowestSeedTokenCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getLowestSeedToken.selector));
    }

    function _getUserDepositedTokensCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getUserDepositedTokens.selector, _input1));
    }

    function _getUserDepositedTokensCall(address _input1, address _input2, uint256 _input3, int96 _input4, LibTractorHelpers.WithdrawalPlan memory _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getUserDepositedTokens.selector, _input1, _input2, _input3, _input4, _input5));
    }

    function _getDepositStemsAndAmountsToWithdrawCall(address _input1, address _input2, uint256 _input3, int96 _input4, LibTractorHelpers.WithdrawalPlan memory _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(0x0338e83e, _input1, _input2, _input3, _input4, _input5));
    }

    function _getDepositStemsAndAmountsToWithdrawCall(address _input1, address _input2, uint256 _input3, int96 _input4) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(0x3d29d115, _input1, _input2, _input3, _input4));
    }

    function _getAddressAndStemCall(uint256 _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getAddressAndStem.selector, _input1));
    }

    function _getLPTokensToWithdrawForBeansCall(uint256 _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getLPTokensToWithdrawForBeans.selector, _input1, _input2));
    }

    function _getTokensAscendingSeedsCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getTokensAscendingSeeds.selector));
    }

    function _getTokensAscendingPriceCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getTokensAscendingPrice.selector));
    }

    function _getSortedDepositsCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getSortedDeposits.selector, _input1, _input2));
    }

    function _getBeanAmountAvailableCall(address _input1, address _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getBeanAmountAvailable.selector, _input1, _input2));
    }

    function _getTokenIndexCall(address _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getTokenIndex.selector, _input1));
    }

    function _tipCall(address _input1, address _input2, address _input3, int256 _input4, LibTransfer.From _input5, LibTransfer.To _input6) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.tip.selector, _input1, _input2, _input3, _input4, _input5, _input6));
    }

    function _isOperatorWhitelistedCall(address[] calldata _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.isOperatorWhitelisted.selector, _input1));
    }

    function _combineWithdrawalPlansCall(LibTractorHelpers.WithdrawalPlan[] memory _input1) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.combineWithdrawalPlans.selector, _input1));
    }

    function _getWhitelistStatusAddressesCall() internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(tractorHelpers).call(abi.encodeWithSelector(TractorHelpers.getWhitelistStatusAddresses.selector));
    }
}