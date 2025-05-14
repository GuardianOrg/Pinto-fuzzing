// SPDX-License-Identifier: UNTITLED
pragma solidity ^0.8.0;

import "../utils/FuzzActors.sol";
import {Pipeline} from "contracts/pipeline/Pipeline.sol";
import {IMockFBeanstalk} from "contracts/interfaces/IMockFBeanstalk.sol";
import {OperatorWhitelist} from "contracts/ecosystem/OperatorWhitelist.sol";
import {MockToken} from "contracts/mocks/MockToken.sol";
import {MockChainlinkAggregator} from "contracts/mocks/MockChainlinkAggregator.sol";
import {MockUniswapV3Pool} from "contracts/mocks/uniswap/MockUniswapV3Pool.sol";
import {MockUniswapV3Factory} from "contracts/mocks/uniswap/MockUniswapV3Factory.sol";

import {LibEvaluate} from "contracts/libraries/LibEvaluate.sol";
import "contracts/beanstalk/storage/System.sol";
import "contracts/interfaces/IPipeline.sol";
import "contracts/beanstalk/facets/market/abstract/Listing.sol";
import "contracts/beanstalk/facets/market/abstract/Order.sol";
import "contracts/libraries/LibFarm.sol";
import {LibConvert} from "contracts/libraries/Convert/LibConvert.sol";
import {SafeERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {LibTractor} from "contracts/libraries/LibTractor.sol";
import {LibTransfer} from "contracts/libraries/Token/LibTransfer.sol";

import {DepotFacet} from "contracts/beanstalk/facets/farm/DepotFacet.sol";
import {TokenFacet} from "contracts/beanstalk/facets/farm/TokenFacet.sol";
import {FarmFacet} from "contracts/beanstalk/facets/farm/FarmFacet.sol";
import {TokenFacet} from "contracts/beanstalk/facets/farm/TokenFacet.sol";
import {TokenSupportFacet} from "contracts/beanstalk/facets/farm/TokenSupportFacet.sol";
import {TractorFacet} from "contracts/beanstalk/facets/farm/TractorFacet.sol";

import {FieldFacet} from "contracts/beanstalk/facets/field/FieldFacet.sol";

import {MarketplaceFacet} from "contracts/beanstalk/facets/market/MarketplaceFacet.sol";

import {MetadataFacet} from "contracts/beanstalk/facets/metadata/MetadataFacet.sol";

import {ApprovalFacet} from "contracts/beanstalk/facets/silo/ApprovalFacet.sol";
import {BDVFacet} from "contracts/beanstalk/facets/silo/BDVFacet.sol";
import {ConvertFacet} from "contracts/beanstalk/facets/silo/ConvertFacet.sol";
import {ClaimFacet} from "contracts/beanstalk/facets/silo/ClaimFacet.sol";
import {ConvertGettersFacet} from "contracts/beanstalk/facets/silo/ConvertGettersFacet.sol";
import {PipelineConvertFacet} from "contracts/beanstalk/facets/silo/PipelineConvertFacet.sol";
import {SiloFacet} from "contracts/beanstalk/facets/silo/SiloFacet.sol";
import {SiloGettersFacet} from "contracts/beanstalk/facets/silo/SiloGettersFacet.sol";
import {WhitelistFacet} from "contracts/beanstalk/facets/silo/WhitelistFacet.sol";

import {GaugeFacet} from "contracts/beanstalk/facets/sun/GaugeFacet.sol";
import {GaugeGettersFacet} from "contracts/beanstalk/facets/sun/GaugeGettersFacet.sol";
import {LiquidityWeightFacet} from "contracts/beanstalk/facets/sun/LiquidityWeightFacet.sol";
import {OracleFacet} from "contracts/beanstalk/facets/sun/OracleFacet.sol";
import {SeasonFacet} from "contracts/beanstalk/facets/sun/SeasonFacet.sol";
import {SeasonGettersFacet} from "contracts/beanstalk/facets/sun/SeasonGettersFacet.sol";

import {DiamondCutFacet} from "contracts/beanstalk/facets/diamond/DiamondCutFacet.sol";
import {DiamondLoupeFacet} from "contracts/beanstalk/facets/diamond/DiamondLoupeFacet.sol";
import {OwnershipFacet} from "contracts/beanstalk/facets/diamond/OwnershipFacet.sol";
import {PauseFacet} from "contracts/beanstalk/facets/diamond/PauseFacet.sol";

import {InitDiamond} from "contracts/beanstalk/init/newInitDiamond.sol";
import {Diamond} from "contracts/beanstalk/Diamond.sol";

import {Junction} from "contracts/ecosystem/junction/Junction.sol";
import {LogicJunction} from "contracts/ecosystem/junction/LogicJunction.sol";
import {MathJunction} from "contracts/ecosystem/junction/MathJunction.sol";
import {LSDChainlinkOracle} from "contracts/ecosystem/oracles/LSDChainlinkOracle.sol";
import {BeanstalkPrice} from "contracts/ecosystem/price/BeanstalkPrice.sol";
import {WellPrice} from "contracts/ecosystem/price/WellPrice.sol";
import {Drafter} from "contracts/ecosystem/Drafter.sol";
import {OperatorWhitelist} from "contracts/ecosystem/OperatorWhitelist.sol";
import {GaugePriceThreshold} from "contracts/ecosystem/GaugePriceThreshold.sol";
import {PriceManipulation} from "contracts/ecosystem/PriceManipulation.sol";
import {ShipmentPlanner} from "contracts/ecosystem/ShipmentPlanner.sol";
import {SowBlueprintv0} from "contracts/ecosystem/SowBlueprintv0.sol";
import {TractorHelpers} from "contracts/ecosystem/TractorHelpers.sol";

import {MockPump} from "contracts/mocks/well/MockPump.sol";
import {IAquifer} from "contracts/interfaces/basin/IAquifer.sol";
import {IWellImpl} from "../interfaces/IWellImpl.sol";
import {ICP2} from "../interfaces/ICP2.sol";
import {IMultiFlowPump} from "../interfaces/IMultiFlowPump.sol";
import {IWell} from "contracts/libraries/Well/LibWell.sol";

import {MockPayback} from "contracts/mocks/MockPayback.sol";
import {MockBudget} from "contracts/mocks/MockBudget.sol";
import {ShipmentPlanner} from "contracts/ecosystem/ShipmentPlanner.sol";
import {IMockFBeanstalk as IBeanstalk} from "contracts/interfaces/IMockFBeanstalk.sol";
import {IShipmentPlanner} from "contracts/interfaces/IShipmentPlanner.sol";
import {Distribution} from "contracts/beanstalk/facets/sun/abstract/Distribution.sol";

import {Bean} from "contracts/tokens/Bean.sol";

contract FuzzStorageVariables is FuzzActors {
    // ==============================================================
    // FUZZING SUITE SETUP
    // ==============================================================

    struct initERC20paramsFuzz {
        string name;
        string symbol;
        uint8 decimals;
    }

    address currentActor;
    bool _setActor = true;

    uint256 internal constant PRIME = 2147483647;
    uint256 internal constant SEED = 22;
    uint256 iteration = 1; // fuzzing iteration
    uint256 lastTimestamp;

    //==============================================================
    // REVERTS CONFIGURATION
    //==============================================================

    bool internal constant CATCH_REQUIRE_REVERT = true; // Set to false to ignore require()/revert()
    bool internal constant CATCH_EMPTY_REVERTS = true; // Set to true to allow empty return data

    // ==============================================================
    // CONTRACTS
    // ==============================================================
    
    // Beanstalk Facets
    Diamond diamond;
    DiamondCutFacet diamondCutFacet;
    DiamondLoupeFacet diamondLoupeFacet;
    OwnershipFacet ownershipFacet;
    InitDiamond initDiamond;
    PauseFacet pauseFacet;

    // Farm
    DepotFacet depotFacet;
    FarmFacet farmFacet;
    TokenFacet tokenFacet;
    TokenSupportFacet tokenSupportFacet;
    TractorFacet tractorFacet;

    // Field
    FieldFacet fieldFacet;

    // Market
    MarketplaceFacet marketplaceFacet;

    // Metadata
    MetadataFacet metadataFacet;

    // Silo
    ApprovalFacet approvalFacet;
    BDVFacet bdvFacet;
    ClaimFacet claimFacet;
    ConvertFacet convertFacet;
    ConvertGettersFacet convertGettersFacet;
    PipelineConvertFacet pipelineConvertFacet;
    SiloFacet siloFacet;
    SiloGettersFacet siloGettersFacet;
    WhitelistFacet whitelistFacet;

    // Sun
    GaugeFacet gaugeFacet;
    GaugeGettersFacet gaugeGettersFacet;
    LiquidityWeightFacet liquidityWeightFacet;
    OracleFacet oracleFacet;
    SeasonFacet seasonFacet;
    SeasonGettersFacet seasonGettersFacet;


    // Ecosystem
    // junction
    Junction junction;
    MathJunction mathJunction;
    LogicJunction logicJunction;
    // oracles
    LSDChainlinkOracle lSDChainlinkOracle;
    // price
    BeanstalkPrice beanstalkPrice;
    WellPrice wellPrice;
    // main
    Drafter drafter;
    GaugePriceThreshold gaugePriceThreshold;
    OperatorWhitelist operatorWhitelist;
    PriceManipulation priceManipulation;
    ShipmentPlanner shipment_planner;
    SowBlueprintv0 sowBlueprintv0;
    TractorHelpers tractorHelpers;

    // Pipeline
    Pipeline pipeLine;

    // Tokens
    Bean beanToken;

    // Pipeline internal pipeline;
    IMockFBeanstalk internal beanstock;

    // MockToken internal bean;
    MockToken internal weth;
    MockToken internal wstEth;
    MockToken internal usdc;
    MockToken internal usdt;
    MockToken internal wbtc;

    // Chainlink
    MockChainlinkAggregator internal cl_eth_usd;
    MockChainlinkAggregator internal cl_wseth_eth;
    MockChainlinkAggregator internal cl_usdc_usd;
    MockChainlinkAggregator internal cl_wbtc_usd;

    // Uniswap
    MockUniswapV3Pool internal uni_wstEth_weth;
    MockUniswapV3Pool internal uni_wbtc_usdc;

    // Basin
    MockPump mockPump;
    IAquifer aquifier;
    IWellImpl wellImpl;
    IMultiFlowPump multiFlowPump;
    ICP2 cp2;

    IWell beanEthWell;
    IWell beanWstEthWell;

    // Routes
    MockBudget mockBudget;
    MockPayback mockPayback;
    ShipmentPlanner shipPlanner;
}
