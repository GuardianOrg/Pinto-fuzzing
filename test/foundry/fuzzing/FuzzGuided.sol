// SPDX-License-Identifier: UNTITLED
pragma solidity ^0.8.0;

import "./fuzz_calls/farm/FuzzDepotFacet.sol";
import "./fuzz_calls/silo/FuzzSiloFacet.sol";

contract FuzzGuided is FuzzDepotFacet, FuzzSiloFacet {
    function fuzz_guided_deposit_silo(uint256 x, uint256 y) public setCurrentActor {
        fuzz_deposit_silo_facet(x, y);
    }

    function fuzz_guided_withdraw_silo_facet(uint256 x, uint256 y) public setCurrentActor {
        fuzz_withdraw_silo_facet(x, y);
    }
    function fuzz_guided_multi_withdraw_silo_facet(uint256 x, uint256 y, uint256 z) public setCurrentActor {
        fuzz_multi_withdraw_silo_facet(x, y, z);
    }
    function fuzz_guided_transfer_deposit_silo_facet(uint256 x, uint256 y, uint256 z) public setCurrentActor {
        fuzz_transfer_deposit_silo_facet(x, y, z);
    }


    function fuzz_guided_multi_transfer_silo_facet(uint256 w, uint256 x, uint256 y, uint256 z) public setCurrentActor {
        fuzz_multi_transfer_silo_facet(w, x, y, z);
    }
}