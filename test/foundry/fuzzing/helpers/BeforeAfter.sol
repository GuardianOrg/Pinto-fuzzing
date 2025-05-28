// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../FuzzSetup.sol";

contract BeforeAfter is FuzzSetup {

    struct DepositData {
        uint256[] depositIds;
        mapping(address token => mapping(uint256 => Deposit)) deposit;
        uint256 matureGerminatingStalk;
        uint256 youngGerminatingStalk;
        uint256 stalk;
        uint256 grownStalk;
        uint256 roots;
        uint256 grownRoots;
        uint256 germinatingStalk;
        uint256 lastUpdate;
        uint256 earnedBeans;
        uint256 earnedStalk;
        uint256 plantableSeeds;
    }

    struct Deposit {
        uint128 amount;
        uint128 bdv;
    }

    struct DepositTotals {
        uint256 totalTokenDeposited;
        uint256 totalBDV;
        uint256 totalGerminatingDeposited;
        uint256 totalGerminatingAmount;
        uint256 totalGerminatingBDV;
        int96 totalGerminatingStem;
    }

    struct State {
        mapping(address => DepositData) depositData;
        mapping(address => DepositTotals) tokenDepositTotals;
        uint256 totalSiloDeposit;
        uint256 totalRoots;
        uint256 totalEarnedBeans;
        uint256 totalRainRoots;
        uint256 getTotalGerminatingStalk;
        uint256 matureGerminatingStalk;
        uint256 youngGerminatingStalk;
    }

    mapping(uint8 => State) states;

    function _before(address[] memory actors) internal {
        _setStates(0, actors);

    }

    function _after(address[] memory actors) internal {
        _setStates(1, actors);
    }

    function _setStates(uint8 callNum, address[] memory actors) internal {
        _processActors(callNum, actors);
        _updateCommonState(callNum);
    }

    function _processActors(uint8 callNum, address[] memory actors) private {
        for (uint256 i = 0; i < actors.length; i++) {
            _setActorState(callNum, actors[i]);
        }
    }

    function _setActorState(uint8 callNum, address actor) internal virtual {
        _updateDepositData(callNum, actor);
    }

    // updates common state for protocol
    function _updateCommonState(uint8 callNum) private {
        (bool success, bytes memory returnData) = _getTotalSiloDepositedCall();
        states[callNum].totalSiloDeposit = abi.decode(returnData, (uint256));

        for (uint256 i; i < depositTokens.length; ++i) {

            address token = depositTokens[i];

            // update deposit state
            (success, returnData) = _getTotalDepositedCall(token);
            states[callNum].tokenDepositTotals[token].totalTokenDeposited = abi.decode(returnData, (uint256));

            // update bdv
            (success, returnData) = _getTotalDepositedBdvCall(token);
            states[callNum].tokenDepositTotals[token].totalBDV = abi.decode(returnData, (uint256));

            // update germinating deposited
            (success, returnData) = _getGerminatingTotalDepositedCall(token);
            states[callNum].tokenDepositTotals[token].totalGerminatingDeposited = abi.decode(returnData, (uint256));
            
            // update germinating amount
            (success, returnData) = _getTotalGerminatingAmountCall(token);
            states[callNum].tokenDepositTotals[token].totalGerminatingAmount = abi.decode(returnData, (uint256));

            // update germinating bdv
            (success, returnData) = _getTotalGerminatingBdvCall(token);
            states[callNum].tokenDepositTotals[token].totalGerminatingBDV = abi.decode(returnData, (uint256));

            // update germinating stem
            (success, returnData) = _getGerminatingStemCall(token);
            states[callNum].tokenDepositTotals[token].totalGerminatingStem = abi.decode(returnData, (int96));
        }

        // update roots
        (success, returnData) = _totalRootsCall();
        states[callNum].totalRoots = abi.decode(returnData, (uint256));

        // update earned beans
        (success, returnData) = _totalEarnedBeansCall();
        states[callNum].totalEarnedBeans = abi.decode(returnData, (uint256));

        // update rain roots
        (success, returnData) = _totalRainRootsCall();
        states[callNum].totalRainRoots = abi.decode(returnData, (uint256));

        // update germinating stalk
        (success, returnData) = _getTotalGerminatingStalkCall();
        states[callNum].getTotalGerminatingStalk = abi.decode(returnData, (uint256));

        // update young & mature germinating stalk
        (success, returnData) = _getYoungAndMatureGerminatingTotalStalkCall();
        (
            states[callNum].matureGerminatingStalk, 
            states[callNum].youngGerminatingStalk
        ) = abi.decode(returnData, (uint256, uint256));

        // _logicalCoverage(callNum);
    }

    // updates state for usre's deposits
    function _updateDepositData(uint8 callNum, address actor) internal {
        // delete previous stored depositIds
        delete states[callNum].depositData[actor].depositIds;
        // get deposits for user
        (bool success, bytes memory returnData) = _getDepositsForAccountCall(actor);
        assert(success);

        SiloGettersFacet.TokenDepositId[] memory allDeposits = abi.decode(returnData, (SiloGettersFacet.TokenDepositId[]));
        for (uint256 i; i < allDeposits.length; ++i) {
            for (uint256 j; j < allDeposits[i].depositIds.length; ++j) {
                // add deposit id
                states[callNum].depositData[actor].depositIds.push(allDeposits[i].depositIds[j]);
                // map deposit data to id
                states[callNum]
                    .depositData[actor]
                    .deposit[allDeposits[i].token][allDeposits[i].depositIds[j]]
                    .amount = allDeposits[i].tokenDeposits[j].amount;

                states[callNum]
                    .depositData[actor]
                    .deposit[allDeposits[i].token][allDeposits[i].depositIds[j]]
                    .bdv = allDeposits[i].tokenDeposits[j].bdv;
            } 
        }

        // updates user stalk data
        _updateUserStalkData(callNum, actor);

        // get last update
        (success, returnData) = _lastUpdateCall(actor);
        states[callNum].depositData[actor].lastUpdate = abi.decode(returnData, (uint256));

        _updateBalances(callNum, actor);

    }

    // update user balances across tokens
    function _updateBalances(uint8 callNum, address actor) internal {
        // update earned beans
        (bool success, bytes memory returnData) = _balanceOfEarnedBeansCall(actor);
        states[callNum].depositData[actor].earnedBeans = abi.decode(returnData, (uint256));

        // update earned beans
        (success, returnData) = _balanceOfEarnedStalkCall(actor);
        states[callNum].depositData[actor].earnedStalk = abi.decode(returnData, (uint256));

        // update plantable seeds
        (success, returnData) = _balanceOfPlantableSeedsCall(actor);
        states[callNum].depositData[actor].plantableSeeds = abi.decode(returnData, (uint256));

    }

    function _updateUserStalkData(uint8 callNum, address actor) internal {
        // update young and mature germinating stalk
        (bool success, bytes memory returnData) = _balanceOfYoungAndMatureGerminatingStalkCall(actor);
        (
            states[callNum].depositData[actor].matureGerminatingStalk,
            states[callNum].depositData[actor].youngGerminatingStalk
        ) = abi.decode(returnData, (uint256, uint256));

        (success, returnData) = _balanceOfRootsCall(actor);
        states[callNum].depositData[actor].roots = abi.decode(returnData, (uint256));

        // update stalk amount
        (success, returnData) = _balanceOfStalkCall(actor);
        assert(success);
        states[callNum].depositData[actor].stalk = abi.decode(returnData, (uint256));

        // update germinating stalk
        (success, returnData) = _balanceOfGerminatingStalkCall(actor);
        assert(success);
        states[callNum].depositData[actor].germinatingStalk = abi.decode(returnData, (uint256));

        // update matured gStalks or gRoots
        (success, returnData) = _balanceOfFinishedGerminatingStalkAndRootsCall(actor);
        assert(success);
        (
            states[callNum].depositData[actor].grownStalk, 
            states[callNum].depositData[actor].grownRoots
        ) = abi.decode(returnData, (uint256, uint256));
    }



}