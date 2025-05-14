// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract ClaimFacetCalls is FuzzBase, FuzzStorageVariables {

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


}