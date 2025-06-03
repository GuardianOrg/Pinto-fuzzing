// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../FuzzSetup.sol";

contract BeforeAfter is FuzzSetup {

    struct DepositData {
        uint256[] depositIds;
        mapping(uint256 => address) id2token;
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

    struct Plot {
        uint256 index;
        uint256 pods;
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
        mapping(address => mapping(uint256 fieldId => uint256)) userPodBalance;
        mapping(address => mapping(uint256 fieldId => Plot[])) userPlots;
        mapping(address user => mapping(address => uint256)) tokenBalances;
        mapping(uint256 fieldId => uint256) harvestable;
        mapping(uint256 fieldId => uint256) harvested;
        uint256 totalSiloDeposit;
        uint256 totalRoots;
        uint256 totalEarnedBeans;
        uint256 totalRainRoots;
        uint256 getTotalGerminatingStalk;
        uint256 matureGerminatingStalk;
        uint256 youngGerminatingStalk;
        uint256 remainingPods;
        uint256 activeField;
        uint256 beanSupply;
        uint256 currSeason;
        uint256 currSeasonTime;
    }

    mapping(uint8 => State) states;

    function _before(address[] memory actors) internal {
        _setStates(0, actors);

    }

    function _after(address[] memory actors) internal {
        _setStates(1, actors);
    }

    function _setStates(uint8 callNum, address[] memory actors) internal {
        _updateCommonState(callNum);
        _processActors(callNum, actors);
    }

    function _processActors(uint8 callNum, address[] memory actors) private {
        for (uint256 i = 0; i < actors.length; i++) {
            _setActorState(callNum, actors[i]);
        }
    }

    function _setActorState(uint8 callNum, address actor) internal virtual {
        _updateFieldData(callNum, actor);
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


        // update remainingPods
        (success, returnData) = _remainingPodsCall();
        states[callNum].remainingPods = abi.decode(returnData, (uint256));

        // update the active field
        (success, returnData) = _activeFieldCall();
        states[callNum].activeField = abi.decode(returnData, (uint256));

        // update bean totalSupply
        states[callNum].beanSupply = beanToken.totalSupply();

        // update current season
        (success, returnData) = _seasonTimeCall();
        states[callNum].currSeason = abi.decode(returnData, (uint256));

        // update current season timestamp
        (success, returnData) = _getSeasonTimestampCall();
        states[callNum].currSeasonTime = abi.decode(returnData, (uint256));

        // update harvestable for the season
        (success, returnData) = _totalHarvestableCall(states[callNum].activeField);
        states[callNum].harvestable[states[callNum].activeField] = abi.decode(returnData, (uint256));

        // update harvested for the season
        (success, returnData) = _totalHarvestedCall(states[callNum].activeField);
        states[callNum].harvested[states[callNum].activeField] = abi.decode(returnData, (uint256));

        // update token balances
        _updateAllTokenBalances(callNum);

        // _logicalCoverage(callNum);
    }

    // updates ERC-20 balances for significant addresses
    function _updateAllTokenBalances(uint8 callNum) internal {
        for(uint256 i; i < mockTokens.length; ++i) {
            for(uint256 j; j < USERS.length; ++j) {
                states[callNum].tokenBalances[USERS[j]][address(mockTokens[i])] = mockTokens[i].balanceOf(USERS[j]);
            }

            states[callNum].tokenBalances[address(diamond)][address(mockTokens[i])] = mockTokens[i].balanceOf(address(diamond));
            states[callNum].tokenBalances[address(beanEthWell)][address(mockTokens[i])] = mockTokens[i].balanceOf(address(beanEthWell));
            states[callNum].tokenBalances[address(beanWstEthWell)][address(mockTokens[i])] = mockTokens[i].balanceOf(address(beanWstEthWell));
        }
    }

    // updates field data for user
    function _updateFieldData(uint8 callNum, address actor) internal {
        (bool success, bytes memory returnData) = _balanceOfPodsCall(actor, states[callNum].activeField);
        states[callNum].userPodBalance[actor][states[callNum].activeField] = abi.decode(returnData, (uint256));

        (success, returnData) = _getPlotsFromAccountCall(actor, states[callNum].activeField);
        Plot[] memory plots = abi.decode(returnData, (Plot[]));
        delete states[callNum].userPlots[actor][states[callNum].activeField];

        for (uint256 i; i < plots.length; ++i) {
            states[callNum].userPlots[actor][states[callNum].activeField].push(plots[i]);
        }
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
                // map id to token
                states[callNum].depositData[actor].id2token[allDeposits[i].depositIds[j]] = allDeposits[i].token;
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