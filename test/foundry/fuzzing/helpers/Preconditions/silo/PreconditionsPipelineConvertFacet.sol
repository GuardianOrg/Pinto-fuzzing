// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PreconditionsBase.sol";
import "../../../properties/Properties.sol";

contract PreconditionsPipelineConvertFacet is PreconditionsBase, Properties {

    function _createBeanToLPPipeCalls(
        uint256 amountOfBean,
        uint256 extraPipes
    ) internal returns (AdvancedPipeCall[] memory output) {
        // first setup the pipeline calls

        // setup approve max call
        bytes memory approveEncoded = abi.encodeWithSelector(
            IERC20.approve.selector,
            address(beanEthWell), 
            type(uint256).max
        );

        uint256[] memory tokenAmountsIn = new uint256[](2);
        tokenAmountsIn[0] = amountOfBean;
        tokenAmountsIn[1] = 0;

        // encode Add liqudity.
        bytes memory addLiquidityEncoded = abi.encodeWithSelector(
            IWell.addLiquidity.selector,
            tokenAmountsIn, // tokenAmountsIn
            0, // min out
            address(pipeLine), // recipient
            type(uint256).max // deadline
        );

        // Fabricate advancePipes:
        AdvancedPipeCall[] memory advancedPipeCalls = new AdvancedPipeCall[](100);

        uint256 callCounter = 0;

        // Action 0: approve the Bean-Eth well to spend pipeline's bean.
        advancedPipeCalls[callCounter++] = AdvancedPipeCall(
            address(beanToken), // target
            approveEncoded, // calldata
            abi.encode(0) // clipboard
        );

        // Action 2: Add One sided Liquidity into the well.
        advancedPipeCalls[callCounter++] = AdvancedPipeCall(
            address(beanEthWell), // target
            addLiquidityEncoded, // calldata
            abi.encode(0) // clipboard
        );

        for(uint256 i; i < extraPipes; ++i) {
            advancedPipeCalls[callCounter++] = _addPipeCall(extraPipes);
        }

        assembly {
            mstore(advancedPipeCalls, callCounter)
        }

        return advancedPipeCalls;
    }

    
    // adds extra pipe calls targeted at the diamond
    function _addPipeCall(uint256 _pipeSalt) internal returns (AdvancedPipeCall memory pipeCall) {
        bytes4 selector;

        bytes4[] memory selectors = _getAllSelectors();
        uint256 selecLen = selectors.length;


        uint256 i;
        while (false) {

            // get random selector
            bytes4 selector = selectors[ uint256(keccak256(abi.encode(i, _pipeSalt))) % selecLen ];

            // verify it is not a view function
            if(_isStateChanging(selector)) {

                // create random call for selector
                bytes memory reenterCalldata = abi.encodeWithSelector(
                    SiloFacet.deposit.selector,
                    _emptyBytes(200)
                );

                pipeCall = AdvancedPipeCall(
                    address(diamond), // target
                    reenterCalldata, // calldata
                    abi.encode(0) // clipboard
                );
                break;
            }
        }

    }

    // gets all selectors for facets
   function _getAllSelectors() internal view returns (bytes4[] memory selectors) {
        IDiamondLoupe.Facet[] memory facets = IDiamondLoupe(address(diamond)).facets();
        uint256 total;
        for (uint i; i < facets.length; i++) {
            total += facets[i].functionSelectors.length;
        }

        selectors = new bytes4[](total);
        uint k;
        for (uint i; i < facets.length; i++) {
            for (uint j; j < facets[i].functionSelectors.length; j++) {
                selectors[k++] = facets[i].functionSelectors[j];
            }
        }
    }

    // check if function is view or pure
    function _isStateChanging(bytes4 selector) internal view returns (bool) {
        (bool success, bytes memory returnData) = address(diamond).staticcall(abi.encodeWithSelector(selector, _emptyBytes(200)));
        return !success;
    }

    // generate empty calldata
    function _emptyBytes(uint256 len) internal view returns (bytes memory b) {
        b = new bytes(len);
        for (uint i = 1; i < len; i++) {
            b[i] = bytes1(uint8(0));
        }
    }


    function _createLPToBeanPipeCalls(
        uint256 amountOfLP
    ) internal view returns (AdvancedPipeCall[] memory output) {
        // setup approve max call
        bytes memory approveEncoded = abi.encodeWithSelector(
            IERC20.approve.selector,
            address(beanEthWell),
            type(uint256).max
        );

        uint256[] memory tokenAmountsIn = new uint256[](2);
        tokenAmountsIn[0] = amountOfLP;
        tokenAmountsIn[1] = 0;

        // encode remove liqudity.
        bytes memory removeLiquidityEncoded = abi.encodeWithSelector(
            IWell.removeLiquidityOneToken.selector,
            amountOfLP, // tokenAmountsIn
            address(beanToken), // tokenOut
            0, // min out
            address(pipeLine), // recipient
            type(uint256).max // deadline
        );

        // Fabricate advancePipes:
        AdvancedPipeCall[] memory advancedPipeCalls = new AdvancedPipeCall[](2);

        // Action 0: approve the Bean-Eth well to spend pipeline's bean.
        advancedPipeCalls[0] = AdvancedPipeCall(
            address(beanToken), // target
            approveEncoded, // calldata
            abi.encode(0) // clipboard
        );

        // Action 2: Remove One sided Liquidity into the well.
        advancedPipeCalls[1] = AdvancedPipeCall(
            address(beanEthWell), // target
            removeLiquidityEncoded, // calldata
            abi.encode(0) // clipboard
        );

        return advancedPipeCalls;
    }

    function _createLPToLPPipeCalls(
        uint256 amountOfLP,
        address inputWell,
        address outputWell
    ) internal view returns (AdvancedPipeCall[] memory output) {
        // setup approve max call
        bytes memory approveEncoded = abi.encodeWithSelector(
            IERC20.approve.selector,
            outputWell,
            type(uint256).max
        );

        // encode remove liqudity.
        bytes memory removeLiquidityEncoded = abi.encodeWithSelector(
            IWell.removeLiquidityOneToken.selector,
            amountOfLP, // lpAmountIn
            address(beanToken), // tokenOut
            0, // min out
            address(pipeLine), // recipient
            type(uint256).max // deadline
        );

        uint256[] memory emptyAmountsIn = new uint256[](2);

        // encode add liquidity
        bytes memory addLiquidityEncoded = abi.encodeWithSelector(
            IWell.addLiquidity.selector,
            emptyAmountsIn, // to be pasted in
            0, // min out
            address(pipeLine), // recipient
            type(uint256).max // deadline
        );

        // Fabricate advancePipes:
        AdvancedPipeCall[] memory advancedPipeCalls = new AdvancedPipeCall[](3);

        // Action 0: approve the Bean-Eth well to spend pipeline's bean.
        advancedPipeCalls[0] = AdvancedPipeCall(
            address(beanToken), // target
            approveEncoded, // calldata
            abi.encode(0) // clipboard
        );

        // Action 1: remove beans from well.
        advancedPipeCalls[1] = AdvancedPipeCall(
            inputWell, // target
            removeLiquidityEncoded, // calldata
            abi.encode(0) // clipboard
        );

        // returnDataItemIndex, copyIndex, pasteIndex
        bytes memory clipboard = abi.encodePacked(
            bytes2(0x0100), // clipboard type 1
            uint80(1), // from result of call at index 1
            uint80(32), // take the first param
            uint80(196) // paste into the 6th 32 bytes of the clipboard
        );

        // Action 2: add beans to wsteth:bean well.
        advancedPipeCalls[2] = AdvancedPipeCall(
            outputWell, // target
            addLiquidityEncoded, // calldata
            clipboard
        );

        return advancedPipeCalls;
    }


}

