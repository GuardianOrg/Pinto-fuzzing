// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PostconditionsBase.sol";

contract PostconditionsFieldFacet is PostconditionsBase {

    function _fieldSowPostConditions(uint256 amount, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {

            _after(actorsToUpdate);

            address user = actorsToUpdate[0];

            uint256 pods = abi.decode(returnData, (uint256));

            // validates remaining pods decreases by new pod amount
            assert(states[1].remainingPods == states[0].remainingPods - pods);

            // validates user pod balance increases
            assert(states[0].userPodBalance[user][states[0].activeField] + pods == states[1].userPodBalance[user][states[1].activeField]);

            // validates bean balance decreases
            assert(states[0].beanSupply - amount == states[1].beanSupply);


        } else {
            onFailInvariantsGeneral(returnData);
        }
    }

    function _fieldAddFieldPostConditions(uint256 fieldAdded, bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {

            _after(actorsToUpdate);

            assert(states[1].activeField == fieldAdded);
            assert(states[0].activeField != states[1].activeField);

        } else {
            onFailInvariantsGeneral(returnData);
        }
    }


    function _fieldHarvestPostConditions(bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {

            _after(actorsToUpdate);

            address user = actorsToUpdate[0];
            uint256 beansHarvested = abi.decode(returnData, (uint256));

            // validate recieved beans
            assert(states[1].tokenBalances[user][address(beanToken)] == states[0].tokenBalances[user][address(beanToken)] + beansHarvested );

            // validate user's pods have decreased
            assert(states[1].userPodBalance[user][states[1].activeField] == states[0].userPodBalance[user][states[0].activeField] - beansHarvested);

            // validate harvestable has decreased
            assert(states[1].harvestable[states[1].activeField] == states[0].harvestable[states[0].activeField] - beansHarvested);

            // validate harvested has increased
            assert(states[1].harvested[states[1].activeField] == states[0].harvested[states[0].activeField] + beansHarvested);

        } else {
            onFailInvariantsGeneral(returnData);
        }
    }


}