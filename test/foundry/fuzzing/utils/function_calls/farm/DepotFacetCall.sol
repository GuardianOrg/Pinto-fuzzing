// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract DepotFacetCalls is FuzzBase, FuzzStorageVariables {

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

    function _advancedPipeCall(PipeCall[] calldata _input1, uint256 _input2) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(DepotFacet.advancedPipe.selector, _input1, _input2));
    }

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
    
}