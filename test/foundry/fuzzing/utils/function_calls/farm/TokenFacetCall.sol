// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract TokenFacetCalls is FuzzBase, FuzzStorageVariables {

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

}