// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@perimetersec/fuzzlib/src/FuzzBase.sol";
import "../../../helpers/FuzzStorageVariables.sol";

contract TokenSupportFacetCalls is FuzzBase, FuzzStorageVariables {

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

    

}