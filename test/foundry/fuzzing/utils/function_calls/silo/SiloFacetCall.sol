// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract SiloFacetCalls is FuzzBase, FuzzStorageVariables {

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
}