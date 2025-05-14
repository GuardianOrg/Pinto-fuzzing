// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMultiFlowPump {
    
    function initialize(
        uint256 maxIncrease,
        uint256 maxDecrease,
        uint256 capInterval,
        uint256 alpha
    ) external;

    function update(uint256[] calldata reserves) external;

    function getFlowRate() external view returns (uint256 flowRate);

    function getLastUpdate() external view returns (uint256 lastUpdate);
}