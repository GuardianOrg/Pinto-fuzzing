// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../PostconditionsBase.sol";

contract PostconditionsSeasonFacet is PostconditionsBase {

    function _gmPostConditions(bool success, bytes memory returnData, address[] memory actorsToUpdate) internal {
        if (success) {
            _after(actorsToUpdate);

            uint256 incentiveAmount = abi.decode(returnData, (uint256));

            // validate user gets reward for gm call
            assert(states[0].tokenBalances[actorsToUpdate[0]][address(beanToken)] + incentiveAmount == states[1].tokenBalances[actorsToUpdate[0]][address(beanToken)]);

            // validate the bean supply increases
            assert(states[1].beanSupply > states[0].beanSupply);

            // validate season incremented
            assert(states[1].currSeason == states[0].currSeason + 1);

            // validate timestamp for season is incremented
            assert(states[1].currSeasonTime > states[0].currSeasonTime);

        } else {
            onFailInvariantsGeneral(returnData);
        }
    }


}