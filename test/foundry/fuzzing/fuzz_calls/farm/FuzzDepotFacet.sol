// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/farm/PreconditionsDepotFacet.sol";
import "../../helpers/postconditions/farm/PostconditionsDepotFacet.sol";

contract FuzzDepotFacet is PreconditionsDepotFacet, PostconditionsDepotFacet {

    function fuzz_pipe() public {

        
        // (bool success, bytes memory returnData) = _pipeCall();
    }

}