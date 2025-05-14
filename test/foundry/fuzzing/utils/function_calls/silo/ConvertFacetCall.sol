// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract ConvertFacetCalls is FuzzBase, FuzzStorageVariables {

    function _convertCall(bytes calldata _input1, int96[] memory _input2, uint256[] memory _input3) internal returns (bool success, bytes memory returnData) {

        vm.prank(currentActor);
        (success, returnData) =
            address(diamond).call(abi.encodeWithSelector(ConvertFacet.convert.selector, _input1, _input2, _input3));
    }
}