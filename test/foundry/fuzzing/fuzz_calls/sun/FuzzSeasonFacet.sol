// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/sun/PreconditionsSeasonFacet.sol";
import "../../helpers/postconditions/sun/PostconditionsSeasonFacet.sol";

contract FuzzSeasonFacet is PreconditionsSeasonFacet, PostconditionsSeasonFacet {

    function fuzz_gm_sun(uint256 _modeSalt) public setCurrentActor() {
        uint256 mode = fl.clamp(_modeSalt, 0, 1);

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _before(actorsToUpdate);

        _setWellLiquidity();
        _depositSilo(1000e6, currentActor);
        _addField(1e6);

        // vm.prank(ADMIN);
        // beanToken.mint(currentActor, 2000e6);
        // (bool success, bytes memory returnData) = _sowWithMinCall(2000e6, 0, 0, LibTransfer.From(0));
        // assert(success);
        // uint256 podsCount = abi.decode(returnData, (uint256));


        vm.warp(block.timestamp + 4900);

        (bool success, bytes memory returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);


        _setWellLiquidity();
        _depositSilo(1000e6, currentActor);

        // update prices
        _updateOraclePrice(cl_eth_usd, initialPrices[0], block.timestamp - 900, block.timestamp - 900);
        _updateOraclePrice(cl_wseth_eth, initialPrices[1], block.timestamp - 900, block.timestamp - 900);


        vm.warp(block.timestamp + 3600);

        (success, returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);

        _setWellLiquidity();
        _depositSilo(1000e6, currentActor);


        vm.warp(block.timestamp + 3600);

        // update prices
        _updateOraclePrice(cl_eth_usd, initialPrices[0], block.timestamp - 900, block.timestamp - 900);
        _updateOraclePrice(cl_wseth_eth, initialPrices[1], block.timestamp - 900, block.timestamp - 900);

        (success, returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);

    }


}