// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/sun/PreconditionsSeasonFacet.sol";
import "../../helpers/postconditions/sun/PostconditionsSeasonFacet.sol";

contract FuzzSeasonFacet is PreconditionsSeasonFacet, PostconditionsSeasonFacet {

    function fuzz_gm_sun(uint256 _seasonsSalt) public setCurrentActor() {
        uint256 itterations = fl.clamp(_seasonsSalt, 0, 8766);
        uint256 mode = 0;
        

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();
        _depositSilo(1000e6, currentActor);
        _addField(1e6);

        for (uint256 i; i < itterations; ++i) {
            vm.warp(block.timestamp + 3600);
            // update prices
            _updateOraclePrice(cl_eth_usd, initialPrices[0], block.timestamp - 900, block.timestamp - 900);
            _updateOraclePrice(cl_wseth_eth, initialPrices[1], block.timestamp - 900, block.timestamp - 900);
            (bool success, bytes memory returnData) = _gmCall(currentActor, LibTransfer.To(mode));
            assert(success);
        }

        _before(actorsToUpdate);
        vm.warp(block.timestamp + 3600);
        // update prices
        _updateOraclePrice(cl_eth_usd, initialPrices[0], block.timestamp - 900, block.timestamp - 900);
        _updateOraclePrice(cl_wseth_eth, initialPrices[1], block.timestamp - 900, block.timestamp - 900);
        (bool success, bytes memory returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        
        _gmPostConditions(success, returnData, actorsToUpdate);
    }


}