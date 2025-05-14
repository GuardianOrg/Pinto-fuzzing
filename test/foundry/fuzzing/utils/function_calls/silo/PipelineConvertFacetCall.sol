// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract PipelineConvertFacetCalls is FuzzBase, FuzzStorageVariables {

    function _pipelineConvertCall(address _input1, int96[] calldata _input2, uint256[] calldata _input3, address _input4, AdvancedPipeCall[] memory  _input5) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(PipelineConvertFacet.pipelineConvert.selector, _input1, _input2, _input3, _input4, _input5));
    }
}