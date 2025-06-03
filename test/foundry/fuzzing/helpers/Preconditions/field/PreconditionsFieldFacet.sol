// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PreconditionsBase.sol";
import "../../../properties/Properties.sol";

contract PreconditionsFieldFacet is PreconditionsBase, Properties {

    function _addSoil() internal {
        uint256 mode = 0;

        address[] memory actorsToUpdate = new address[](1);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();
        _depositSilo(1000e6, currentActor);
        _addField(1e6);

        vm.warp(block.timestamp + 3600);


        (bool success, bytes memory returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);


        // _setWellLiquidity();
        // _depositSilo(1000e6, currentActor);

        // update prices
        _updateOraclePrice(cl_eth_usd, initialPrices[0], block.timestamp - 900, block.timestamp - 900);
        _updateOraclePrice(cl_wseth_eth, initialPrices[1], block.timestamp - 900, block.timestamp - 900);


        vm.warp(block.timestamp + 3600);

        (success, returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);

        // _setWellLiquidity();
        // _depositSilo(1000e6, currentActor);


        vm.warp(block.timestamp + 3600);

        // update prices
        _updateOraclePrice(cl_eth_usd, initialPrices[0], block.timestamp - 900, block.timestamp - 900);
        _updateOraclePrice(cl_wseth_eth, initialPrices[1], block.timestamp - 900, block.timestamp - 900);

        (success, returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);
    }

    // @note we need deltaB to become positive so we can harvest
    function _forceHarvestState() internal {
        uint256 mode = 0;
        _setWellLiquidity();
        _depositSilo(1000e6, currentActor);

        vm.warp(block.timestamp + 3600);

        _updateOraclePrice(cl_eth_usd, 100e6, block.timestamp - 900, block.timestamp - 900);

        vm.prank(ADMIN);
        weth.mint(address(beanEthWell), uint256(1e35));
        beanEthWell.shift(beanToken, 0, currentActor);
        beanEthWell.shift(beanToken, 0, currentActor);


        (bool success, bytes memory returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);

        vm.warp(block.timestamp + 3600);

        _updateOraclePrice(cl_eth_usd, 100e6, block.timestamp - 900, block.timestamp - 900);


        _setWellLiquidity();

        (success, returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);

        vm.warp(block.timestamp + 3600);

        _updateOraclePrice(cl_eth_usd, 100e6, block.timestamp - 900, block.timestamp - 900);

        (success, returnData) = _gmCall(currentActor, LibTransfer.To(mode));
        assert(success);
    }

}