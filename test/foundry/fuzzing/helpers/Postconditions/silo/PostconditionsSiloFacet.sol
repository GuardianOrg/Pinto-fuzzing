// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PostconditionsBase.sol";

contract PostconditionsSiloFacet is PostconditionsBase {

    function _siloFacetPostCondition(bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {

        if (success) {
            _after(actorsToUpdate);

            onSuccessInvariantsGeneral(returnData);
        } else {
            onFailInvariantsGeneral(returnData);
        }

    }

}