// SPDX-License-Identifier: UNTITLED
pragma solidity ^0.8.0;

import "./fuzz_calls/farm/FuzzDepotFacet.sol";

contract FuzzGuided is FuzzDepotFacet {
    function fuzz_guided_Farm_Depot_Pipe() public setCurrentActor {
        // fuzz_pipe();
    }
}