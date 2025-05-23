/*
 SPDX-License-Identifier: MIT
*/

pragma solidity ^0.8.20;

import {LibAppStorage} from "./LibAppStorage.sol";
import {AppStorage} from "contracts/beanstalk/storage/AppStorage.sol";
import {AssetSettings} from "contracts/beanstalk/storage/System.sol";
import {LibRedundantMath256} from "contracts/libraries/Math/LibRedundantMath256.sol";
import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";
import {LibWhitelistedTokens} from "contracts/libraries/Silo/LibWhitelistedTokens.sol";
import {LibWhitelist} from "contracts/libraries/Silo/LibWhitelist.sol";
import {LibRedundantMath32} from "contracts/libraries/Math/LibRedundantMath32.sol";
import {LibWell} from "contracts/libraries/Well/LibWell.sol";
import {IGaugeFacet} from "contracts/beanstalk/facets/sun/GaugeFacet.sol";
/**
 * @title LibGauge
 * @notice LibGauge handles functionality related to the seed gauge system.
 */
library LibGauge {
    using SafeCast for uint256;
    using LibRedundantMath256 for uint256;
    using LibRedundantMath32 for uint32;

    uint256 internal constant BDV_PRECISION = 1e6;
    uint256 internal constant GP_PRECISION = 1e18;
    uint256 internal constant GROWN_STALK_PER_GP_PRECISION = 1e6;
    uint256 internal constant OPTIMAL_DEPOSITED_BDV_PERCENT = 100e6;

    // The maximum value of beanToMaxLpGpPerBdvRatio.
    uint256 internal constant ONE_HUNDRED_PERCENT = 100e18;

    // 24 * 30 * 6
    // uint256 internal constant TARGET_SEASONS_TO_CATCHUP = 4320; //state
    uint256 internal constant STALK_BDV_PRECISION = 1e10;

    /**
     * @notice Emitted when the AverageGrownStalkPerBdvPerSeason Updates.
     */
    event UpdateAverageStalkPerBdvPerSeason(uint256 newStalkPerBdvPerSeason);

    struct LpGaugePointData {
        address lpToken;
        uint256 gpPerBdv;
    }
    /**
     * @notice Emitted when the gaugePoints for an LP silo token changes.
     * @param season The current Season
     * @param token The LP silo token whose gaugePoints was updated.
     * @param gaugePoints The new gaugePoints for the LP silo token.
     */
    event GaugePointChange(uint256 indexed season, address indexed token, uint256 gaugePoints);

    /**
     * @notice Updates the seed gauge system.
     * @dev Updates the GaugePoints for LP assets (if applicable)
     * and the distribution of grown Stalk to silo assets.
     *
     * If any of the LP price oracle failed,
     * then the gauge system should be skipped, as a valid
     * usd liquidity value cannot be computed.
     */
    function stepGauge() external {
        (
            uint256 maxLpGpPerBdv,
            LpGaugePointData[] memory lpGpData,
            uint256 totalGaugePoints,
            uint256 totalLpBdv
        ) = updateGaugePoints();

        // If totalLpBdv is max, it means that the gauge points has failed,
        // and the gauge system should be skipped.
        if (totalLpBdv == type(uint256).max) return;

        updateGrownStalkEarnedPerSeason(maxLpGpPerBdv, lpGpData, totalGaugePoints, totalLpBdv);
    }

    /**
     * @notice Evaluate the gauge points of each LP asset.
     * @dev `totalLpBdv` is returned as type(uint256).max when an Oracle failure occurs.
     */
    function updateGaugePoints()
        internal
        returns (
            uint256 maxLpGpPerBdv,
            LpGaugePointData[] memory lpGpData,
            uint256 totalGaugePoints,
            uint256 totalLpBdv
        )
    {
        AppStorage storage s = LibAppStorage.diamondStorage();
        address[] memory whitelistedLpTokens = LibWhitelistedTokens.getWhitelistedLpTokens();
        lpGpData = new LpGaugePointData[](whitelistedLpTokens.length);
        // If there is only one pool, there is no need to update the gauge points.
        if (whitelistedLpTokens.length == 1) {
            // If the usd price oracle failed, skip gauge point update.
            // Assumes that only Wells use USD price oracles.
            if (
                LibWell.isWell(whitelistedLpTokens[0]) &&
                s.sys.usdTokenPrice[whitelistedLpTokens[0]] == 0
            ) {
                return (maxLpGpPerBdv, lpGpData, totalGaugePoints, type(uint256).max);
            }
            uint256 gaugePoints = s.sys.silo.assetSettings[whitelistedLpTokens[0]].gaugePoints;

            lpGpData[0].lpToken = whitelistedLpTokens[0];
            // If nothing has been deposited, skip gauge point update.
            uint128 depositedBdv = s.sys.silo.balances[whitelistedLpTokens[0]].depositedBdv;
            if (depositedBdv == 0)
                return (maxLpGpPerBdv, lpGpData, totalGaugePoints, type(uint256).max);
            lpGpData[0].gpPerBdv = gaugePoints.mul(BDV_PRECISION).div(
                s.sys.silo.balances[whitelistedLpTokens[0]].depositedBdv
            );
            return (
                lpGpData[0].gpPerBdv,
                lpGpData,
                gaugePoints,
                s.sys.silo.balances[whitelistedLpTokens[0]].depositedBdv
            );
        }

        // Summate total deposited BDV across all whitelisted LP tokens.
        uint256 totalOptimalDepositedBdvPercent;
        for (uint256 i; i < whitelistedLpTokens.length; ++i) {
            // Assumes that only Wells use USD price oracles.
            if (
                LibWell.isWell(whitelistedLpTokens[i]) &&
                s.sys.usdTokenPrice[whitelistedLpTokens[i]] == 0
            ) {
                return (maxLpGpPerBdv, lpGpData, totalGaugePoints, type(uint256).max);
            }
            uint256 depositedBdv = s.sys.silo.balances[whitelistedLpTokens[i]].depositedBdv;
            if (depositedBdv > 0) {
                AssetSettings storage ss = s.sys.silo.assetSettings[whitelistedLpTokens[i]];
                totalLpBdv = totalLpBdv.add(depositedBdv);
                totalOptimalDepositedBdvPercent = totalOptimalDepositedBdvPercent.add(
                    ss.optimalPercentDepositedBdv
                );
            }
        }

        // If nothing has been deposited, skip gauge point update.
        if (totalLpBdv == 0) return (maxLpGpPerBdv, lpGpData, totalGaugePoints, type(uint256).max);
        // Calculate and update the gauge points for each LP.
        // If the depositedBdv is 0, then the gauge points are not included in the total.
        for (uint256 i; i < whitelistedLpTokens.length; ++i) {
            AssetSettings storage ss = s.sys.silo.assetSettings[whitelistedLpTokens[i]];
            uint256 depositedBdv = s.sys.silo.balances[whitelistedLpTokens[i]].depositedBdv;

            // 1e6 = 1%
            uint256 percentDepositedBdv = depositedBdv.mul(100e6).div(totalLpBdv);

            uint256 gpPerBdv;
            uint256 newGaugePoints = ss.gaugePoints;
            // If the token does not have any deposited BDV, the gauge points are not updated.
            if (depositedBdv > 0) {
                // Calculate the new gauge points of the token.
                newGaugePoints = calcGaugePoints(
                    ss,
                    percentDepositedBdv,
                    totalOptimalDepositedBdvPercent
                );
                // Increment totalGaugePoints and calculate the gaugePoints per BDV:
                totalGaugePoints = totalGaugePoints.add(newGaugePoints);
                gpPerBdv = newGaugePoints.mul(BDV_PRECISION).div(depositedBdv);
            }

            // Gauge points has 18 decimal precision (GP_PRECISION = 1%)
            // Deposited BDV has 6 decimal precision (1e6 = 1 unit of BDV)
            // gpPerBdv has 18 decimal precision.
            if (gpPerBdv > maxLpGpPerBdv) maxLpGpPerBdv = gpPerBdv;
            lpGpData[i] = LpGaugePointData({lpToken: whitelistedLpTokens[i], gpPerBdv: gpPerBdv});

            ss.gaugePoints = newGaugePoints.toUint128();
            emit GaugePointChange(s.sys.season.current, whitelistedLpTokens[i], newGaugePoints);
        }
    }

    /**
     * @notice calculates the new gauge points, given the silo settings and the percent deposited BDV.
     * @param ss siloSettings of the token.
     * @param percentDepositedBdv the current percentage of the total LP deposited BDV for the token.
     * @param totalOptimalDepositedBdvPercent the total optimal deposited BDV percent for all LP tokens.
     */
    function calcGaugePoints(
        AssetSettings memory ss,
        uint256 percentDepositedBdv,
        uint256 totalOptimalDepositedBdvPercent
    ) internal view returns (uint256 newGaugePoints) {
        // if the target is 0, use address(this).
        address target = ss.gaugePointImplementation.target;
        if (target == address(0)) {
            target = address(this);
        }
        // if no selector is provided, use defaultGaugePoints
        bytes4 selector = ss.gaugePointImplementation.selector;
        if (selector == bytes4(0)) {
            selector = IGaugeFacet.defaultGaugePoints.selector;
        }

        uint256 optimalPercentDepositedBdv = (ss.optimalPercentDepositedBdv *
            OPTIMAL_DEPOSITED_BDV_PERCENT) / totalOptimalDepositedBdvPercent;
        (bool success, bytes memory data) = target.staticcall(
            abi.encodeWithSelector(
                selector,
                ss.gaugePoints,
                optimalPercentDepositedBdv,
                percentDepositedBdv,
                ss.gaugePointImplementation.data
            )
        );

        if (!success) return ss.gaugePoints;
        assembly {
            newGaugePoints := mload(add(data, add(0x20, 0)))
        }
    }

    /**
     * @notice Updates the average grown stalk per BDV per Season for whitelisted Beanstalk assets.
     * @dev Called at the end of each Season.
     * The gauge system considers the total BDV of all whitelisted silo tokens.
     */
    function updateGrownStalkEarnedPerSeason(
        uint256 maxLpGpPerBdv,
        LpGaugePointData[] memory lpGpData,
        uint256 totalGaugePoints,
        uint256 totalLpBdv
    ) internal {
        AppStorage storage s = LibAppStorage.diamondStorage();
        uint256 beanDepositedBdv = s.sys.silo.balances[s.sys.bean].depositedBdv;
        uint256 totalGaugeBdv = totalLpBdv.add(beanDepositedBdv);

        // If nothing has been deposited, skip grown stalk update.
        if (totalGaugeBdv == 0) return;

        // Calculate the ratio between the bean and the max LP gauge points per BDV.
        // 18 decimal precision.
        uint256 beanToMaxLpGpPerBdvRatio = getBeanToMaxLpGpPerBdvRatioScaled(
            s.sys.seedGauge.beanToMaxLpGpPerBdvRatio
        );

        // Get the GaugePoints and GPperBDV for bean
        // BeanGpPerBdv and beanToMaxLpGpPerBdvRatio has 18 decimal precision.
        uint256 beanGpPerBdv = maxLpGpPerBdv.mul(beanToMaxLpGpPerBdvRatio).div(100e18);

        totalGaugePoints = totalGaugePoints.add(
            beanGpPerBdv.mul(beanDepositedBdv).div(BDV_PRECISION)
        );

        // update the average grown stalk per BDV per Season.
        updateAverageStalkPerBdvPerSeason();

        // Calculate grown stalk issued this season and GrownStalk Per GaugePoint.
        uint256 newGrownStalk = uint256(s.sys.seedGauge.averageGrownStalkPerBdvPerSeason)
            .mul(totalGaugeBdv)
            .div(BDV_PRECISION);

        // Gauge points has 18 decimal precision.
        uint256 newGrownStalkPerGp = newGrownStalk.mul(GP_PRECISION).div(totalGaugePoints);

        // Update stalkPerBdvPerSeason for bean.
        issueGrownStalkPerBdv(s.sys.bean, newGrownStalkPerGp, beanGpPerBdv);

        // Update stalkPerBdvPerSeason for LP
        // If there is only one pool, then no need to read gauge points.
        if (lpGpData.length == 1) {
            issueGrownStalkPerBdv(lpGpData[0].lpToken, newGrownStalkPerGp, lpGpData[0].gpPerBdv);
        } else {
            for (uint256 i; i < lpGpData.length; i++) {
                issueGrownStalkPerBdv(
                    lpGpData[i].lpToken,
                    newGrownStalkPerGp,
                    lpGpData[i].gpPerBdv
                );
            }
        }
    }

    /**
     * @notice issues the grown stalk per BDV for the given token.
     * @param token the token to issue the grown stalk for.
     * @param grownStalkPerGp the number of GrownStalk Per Gauge Point.
     * @param gpPerBdv the amount of GaugePoints per BDV the token has.
     */
    function issueGrownStalkPerBdv(
        address token,
        uint256 grownStalkPerGp,
        uint256 gpPerBdv
    ) internal {
        uint256 stalkEarnedPerSeason = grownStalkPerGp.mul(gpPerBdv).div(
            GP_PRECISION * GROWN_STALK_PER_GP_PRECISION
        );
        // cap the stalkEarnedPerSeason to the max value of a int40,
        // as deltaStalkEarnedPerSeason is an int40.
        if (stalkEarnedPerSeason > uint40(type(int40).max)) {
            stalkEarnedPerSeason = uint40(type(int40).max);
        }
        LibWhitelist.updateStalkPerBdvPerSeasonForToken(token, uint40(stalkEarnedPerSeason));
    }

    /**
     * @notice Updates the UpdateAverageStalkPerBdvPerSeason in the seed gauge.
     * @dev The function updates the targetGrownStalkPerBdvPerSeason such that
     * it will take 6 months for the average new depositer to catch up to the
     * current average grown stalk per BDV.
     *
     * When a new Beanstalk is deployed, the `avgGsPerBdvFlag` is set to false,
     * due to the fact that there is no data to calculate the average.
     * Once the averageGsPerBdv exceeds the initial value set during deployment,
     * `avgGsPerBdvFlag` is set to true, and the averageStalkPerBdvPerSeason is
     * updated moving forward.
     *
     * The averageStalkPerBdvPerSeason has a minimum value to prevent the
     * opportunity cost of Withdrawing from the Silo from being too low.
     */
    function updateAverageStalkPerBdvPerSeason() internal {
        AppStorage storage s = LibAppStorage.diamondStorage();
        // Will overflow if the average grown stalk per BDV exceeds 1.4e36,
        // which is highly improbable assuming consistent new deposits.
        // Thus, safeCast was determined is to be unnecessary.
        uint128 avgGsPerBdvPerSeason = uint128(
            getAverageGrownStalkPerBdv().mul(BDV_PRECISION).div(
                s.sys.evaluationParameters.targetSeasonsToCatchUp
            )
        );

        // if the flag is not set, check if the new average is greater than the initial value.
        // if it is, set the flag to true, and update the average.
        // otherwise, return early.
        if (!s.sys.seedGauge.avgGsPerBdvFlag) {
            if (avgGsPerBdvPerSeason > s.sys.seedGauge.averageGrownStalkPerBdvPerSeason) {
                s.sys.seedGauge.avgGsPerBdvFlag = true;
            } else {
                return;
            }
        }

        // If the new average is less than the minimum, set it to the minimum.
        if (avgGsPerBdvPerSeason < s.sys.evaluationParameters.minAvgGsPerBdv) {
            avgGsPerBdvPerSeason = s.sys.evaluationParameters.minAvgGsPerBdv;
        }
        s.sys.seedGauge.averageGrownStalkPerBdvPerSeason = avgGsPerBdvPerSeason;
        emit UpdateAverageStalkPerBdvPerSeason(s.sys.seedGauge.averageGrownStalkPerBdvPerSeason);
    }

    /**
     * @notice Returns the total BDV in beanstalk.
     * @dev The total BDV may differ from the instaneous BDV,
     * as BDV is asyncronous.
     * Note We get the silo Tokens, not the whitelisted tokens
     * to account for grown stalk from dewhitelisted tokens.
     */
    function getTotalBdv() internal view returns (uint256 totalBdv) {
        AppStorage storage s = LibAppStorage.diamondStorage();
        address[] memory siloTokens = LibWhitelistedTokens.getSiloTokens();
        for (uint256 i; i < siloTokens.length; ++i) {
            totalBdv = totalBdv.add(s.sys.silo.balances[siloTokens[i]].depositedBdv);
        }
    }

    /**
     * @notice Returns the average grown stalk per BDV.
     * @dev `totalBDV` refers to the total BDV deposited in the silo.
     */
    function getAverageGrownStalkPerBdv() internal view returns (uint256) {
        AppStorage storage s = LibAppStorage.diamondStorage();
        uint256 totalBdv = getTotalBdv();
        if (totalBdv == 0) return 0;
        return s.sys.silo.stalk.div(totalBdv).sub(STALK_BDV_PRECISION);
    }

    /**
     * @notice Returns the ratio between the bean and
     * the max LP gauge points per BDV.
     * @dev s.sys.seedGauge.beanToMaxLpGpPerBdvRatio is a number between 0 and 100e18,
     * where f(0) = MIN_BEAN_MAX_LPGP_RATIO and f(100e18) = MAX_BEAN_MAX_LPGP_RATIO.
     * At the minimum value (0), beans should have half of the
     * largest gauge points per BDV out of the LPs.
     * At the maximum value (100e18), beans should have the same amount of
     * gauge points per BDV as the largest out of the LPs.
     *
     * If the system is raining, use `rainingMinBeanMaxLpGpPerBdvRatio` instead of
     * `minBeanMaxLpGpPerBdvRatio`.
     */
    function getBeanToMaxLpGpPerBdvRatioScaled(
        uint256 beanToMaxLpGpPerBdvRatio
    ) internal view returns (uint256) {
        AppStorage storage s = LibAppStorage.diamondStorage();
        uint256 minBeanMaxLpGpPerBdvRatio = s.sys.evaluationParameters.minBeanMaxLpGpPerBdvRatio;
        if (s.sys.season.raining) {
            minBeanMaxLpGpPerBdvRatio = s.sys.evaluationParameters.rainingMinBeanMaxLpGpPerBdvRatio;
        }
        uint256 beanMaxLpGpRatioRange = s.sys.evaluationParameters.maxBeanMaxLpGpPerBdvRatio -
            minBeanMaxLpGpPerBdvRatio;
        return
            beanToMaxLpGpPerBdvRatio.mul(beanMaxLpGpRatioRange).div(ONE_HUNDRED_PERCENT).add(
                minBeanMaxLpGpPerBdvRatio
            );
    }
}
