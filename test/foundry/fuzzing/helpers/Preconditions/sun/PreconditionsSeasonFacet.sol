// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PreconditionsBase.sol";
import "../../../properties/Properties.sol";

contract PreconditionsSeasonFacet is PreconditionsBase, Properties {

    function _addField(uint32 _temp) internal returns (uint256 amount, int96 stem) {

        (bool success, bytes memory returnData) = _fieldCountCall();
        uint256 nextField = abi.decode(returnData, (uint256));
        
        vm.prank(address(diamond));
        (success, returnData) = address(diamond).call(abi.encodeWithSelector(FieldFacet.addField.selector));
        assert(success);

        vm.prank(address(diamond));
        (success, returnData) = address(diamond).call(abi.encodeWithSelector(FieldFacet.setActiveField.selector, nextField, _temp));
        assert(success);
    }
}