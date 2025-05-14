// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IWellImpl {
    function tokens() external view returns (address[] memory);

    function getReserves() external view returns (uint256[] memory);

    function addLiquidity(uint256[] calldata amounts, address recipient) external returns (uint256 lpTokensMinted);

    function removeLiquidity(uint256 lpAmount, address recipient) external returns (uint256[] memory amounts);

    function swapFrom(address tokenIn, address tokenOut, uint256 amountIn, address recipient) external returns (uint256 amountOut);

    function wellFunction() external view returns (address);

    function pumps() external view returns (address[] memory);
}