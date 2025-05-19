// SPDX-License-Identifier: UNTITLED
pragma solidity ^0.8.0;

import "./utils/FunctionCalls.sol";
import "@perimetersec/fuzzlib/src/FuzzBase.sol";

import {MockToken} from "contracts/mocks/MockToken.sol";
import {IMockFBeanstalk} from "contracts/interfaces/IMockFBeanstalk.sol";
import {MockSeasonFacet} from "contracts/mocks/mockFacets/MockSeasonFacet.sol";
import {MockChainlinkAggregator} from "contracts/mocks/MockChainlinkAggregator.sol";

///// TEST HELPERS //////
import {BeanstalkDeployer} from "test/foundry/utils/BeanstalkDeployer.sol";
import {BasinDeployer} from "test/foundry/utils/BasinDeployer.sol";
import {DepotDeployer} from "test/foundry/utils/DepotDeployer.sol";
import {OracleDeployer} from "test/foundry/utils/OracleDeployer.sol";
import {ShipmentDeployer} from "test/foundry/utils/ShipmentDeployer.sol";
import {IWell, IERC20} from "contracts/interfaces/basin/IWell.sol";
import {C} from "contracts/C.sol";

///// COMMON IMPORTED LIBRARIES //////
import {LibTransfer} from "contracts/libraries/Token/LibTransfer.sol";
import {LibConvertData} from "contracts/libraries/Convert/LibConvertData.sol";

///// ECOSYSTEM //////
import {Pipeline} from "contracts/pipeline/Pipeline.sol";

// OTHER INTERFACES //
import {IUSDC} from "contracts/interfaces/IUSDC.sol";

import {IDiamondCut} from "contracts/interfaces/IDiamondCut.sol";
import {LibDiamond} from "contracts/libraries/LibDiamond.sol";



contract FuzzSetup is FunctionCalls {

    MockUniswapV3Factory public uniFactory;
    uint256[][] public uniPriceData = [[uint256(1e18), 18], [uint256(500e6), 8]];

    function fuzzSetup() internal {
        deploySampleContract();
        labelAll();
    }

    // facet selectors
    bytes4[] depotSelects = [bytes4(0xb452c7ae), bytes4(0x6e47d07b), bytes4(0xcabec62b), bytes4(0x08e1a0ab), bytes4(0xdd756c4f)];
    bytes4[] farmSelects = [bytes4(0x36bfafbd), bytes4(0x300dd6cf)];
    bytes4[] tokenSelects = [bytes4(0xda3e3397), bytes4(0x0bc33ce4), bytes4(0xfdb28811), bytes4(0xb6fc38f9), bytes4(0xd4fac45d), bytes4(0x6a385ae9), bytes4(0x4667fa3d), bytes4(0xc3714723), bytes4(0x8a65d2e0), bytes4(0xa98edb17), bytes4(0xb39062e6), bytes4(0xbc197c81), bytes4(0xf23a6e61), bytes4(0x8e8758d8), bytes4(0xd3f4ec6f), bytes4(0x6204aa43), bytes4(0xbd32fac3), bytes4(0x1c059365)];
    bytes4[] tokenSupportSelects = [bytes4(0xa9412a59), bytes4(0x0a7e880c), bytes4(0x1aca6376)];
    bytes4[] tractorSelects = [bytes4(0x563957a8), bytes4(0x5723cc60), bytes4(0x5ebc32e6), bytes4(0x5993514b), bytes4(0x2be32f6a), bytes4(0x91a45154), bytes4(0x454972dd), bytes4(0x570ca735), bytes4(0xcc8a429d), bytes4(0xca1e71ae), bytes4(0xfe414fc8), bytes4(0x507cea25), bytes4(0xdf8d26bb), bytes4(0x04cb49dc)];
    bytes4[] fieldSelects = [bytes4(0xd1eba544), bytes4(0xb94e871c), bytes4(0x9a337c1d), bytes4(0xbb485bbd), bytes4(0xd7254577), bytes4(0x253fcfb5), bytes4(0x91b24284), bytes4(0xe9bbb033), bytes4(0xb511654d), bytes4(0x5487cc45), bytes4(0x4bea67c4), bytes4(0x7907091f), bytes4(0x9ee7ea12), bytes4(0xccda40b9), bytes4(0x56ba3e24), bytes4(0x057c571b), bytes4(0x32ab68ce), bytes4(0x553030d0), bytes4(0xadccea12), bytes4(0x2e76f597), bytes4(0x352525a6), bytes4(0xf1e0a211), bytes4(0x3285008a), bytes4(0xf29ffe94), bytes4(0xb6032721)];
    bytes4[] marketplaceSelects = [bytes4(0xb151226a), bytes4(0x0711f012), bytes4(0x8d398973), bytes4(0x9ed2801b), bytes4(0x65865af6), bytes4(0x37b4d2ec), bytes4(0xf7f228a2), bytes4(0xed8c792f), bytes4(0x631076dd), bytes4(0x98c02432), bytes4(0x674a3e67), bytes4(0xceb39673), bytes4(0x31ed3796)];
    bytes4[] metadataSelects = [bytes4(0x18a51858), bytes4(0x06fdde03), bytes4(0x95d89b41), bytes4(0x0e89341c)];
    bytes4[] approvalSelects = [bytes4(0x1302afc2), bytes4(0xd9ee1269), bytes4(0x2a6a8ef5), bytes4(0x5793e485), bytes4(0xe985e9c5), bytes4(0xa22cb465)];
    bytes4[] bdvSelects = [bytes4(0x5a049a47), bytes4(0xc84c7727)];
    bytes4[] claimSelects = [bytes4(0xfa2e2617), bytes4(0x0d509999), bytes4(0x150d5173), bytes4(0x9d5e1f96), bytes4(0x74412e48), bytes4(0x7d44f5bb), bytes4(0xc5a13699), bytes4(0x779b3c5c)];
    bytes4[] convertSelects = [bytes4(0xb362a6e8)];
    bytes4[] convertGettersSelects = [bytes4(0xd052f0d5), bytes4(0xb325d2ef), bytes4(0x6842f2b3), bytes4(0x527ec6ba), bytes4(0x4aa06652), bytes4(0x24dd285c), bytes4(0xf66d5589), bytes4(0xb905065b), bytes4(0x3e8b56f1), bytes4(0xb267ea07), bytes4(0x24568abf)];
    bytes4[] pipelineConvertSelects = [bytes4(0xbb25c1c2)];
    bytes4[] siloSelects = [bytes4(0xf19ed6be), bytes4(0x2eb2c2d6), bytes4(0xf242432a), bytes4(0x081d77ba), bytes4(0xc56411f6), bytes4(0x297e6c69), bytes4(0xe348f82b), bytes4(0x27e047f1)];
    bytes4[] siloGettersSelects = [bytes4(0x00fdd58e), bytes4(0x4e1273f4), bytes4(0xbc8514cf), bytes4(0x3e465a2e), bytes4(0x341b94d5), bytes4(0xc063989e), bytes4(0x838082b5), bytes4(0x8915ba24), bytes4(0xcb65f1b1), bytes4(0x80c9084b), bytes4(0xb02e7162), bytes4(0x69fbad94), bytes4(0xba39dc02), bytes4(0xa7bf680f), bytes4(0x8eeae310), bytes4(0x0fb01e05), bytes4(0x8c1e6f22), bytes4(0xd31e4d66), bytes4(0x0b6413b0), bytes4(0x805a343f), bytes4(0xb592d450), bytes4(0x91a38626), bytes4(0x61449212), bytes4(0x98f2b8ad), bytes4(0x823ccbe9), bytes4(0xe73c165b), bytes4(0x1ca5f625), bytes4(0x96e7f21e), bytes4(0x4118140a), bytes4(0x9256dccd), bytes4(0xa953f06d), bytes4(0xe5b17f2a), bytes4(0xc25a156c), bytes4(0x9b3ec513), bytes4(0xff1b540f), bytes4(0x6a9c931d), bytes4(0x55d0807e), bytes4(0x7fc06e12), bytes4(0x047c92cf), bytes4(0xdc25a650), bytes4(0xf6225118), bytes4(0x85167e51), bytes4(0x9cf67d70), bytes4(0x54369b5b), bytes4(0xe49b77f5), bytes4(0x0c9c31bd), bytes4(0x9d6a924e), bytes4(0xb45ef2eb), bytes4(0x9dcf67f0), bytes4(0x7d4a51cb), bytes4(0xb13d3024), bytes4(0xbd637860), bytes4(0x5a8e63e3), bytes4(0x3a1b0606), bytes4(0xbe6547d2), bytes4(0xcb03fb1e), bytes4(0xedd2d167), bytes4(0xabed2d41), bytes4(0xe923e8d4), bytes4(0xfd9de166), bytes4(0xaea72f96), bytes4(0x46544166), bytes4(0x7b52fadf)];
    bytes4[] whitelistSelects = [bytes4(0x86b40a1b), bytes4(0x738cb80b), bytes4(0x8104d586), bytes4(0x56b7b49c), bytes4(0xe9522c08), bytes4(0xd9ba32fc), bytes4(0x170cf084), bytes4(0x9d1d2877), bytes4(0xe26f7900), bytes4(0x76a7bc84), bytes4(0x19b8f518), bytes4(0x4fb907a0), bytes4(0x85657e12), bytes4(0x874b87b9), bytes4(0x79325704), bytes4(0x4b6f418c), bytes4(0x52d7f632)];
    bytes4[] gaugeSelects = [bytes4(0x44811f70), bytes4(0x6c07c340), bytes4(0xd7b77ea4), bytes4(0xafa1704e), bytes4(0xc26072fe), bytes4(0x8bd47e79), bytes4(0x0333f5c1), bytes4(0xcbab033f), bytes4(0xaa229a47), bytes4(0x5117bef5), bytes4(0x3ad6d656), bytes4(0x925150c9)];
    bytes4[] gaugeGettersSelects = [bytes4(0x7046c9a6), bytes4(0x7ba6cbf8), bytes4(0xeb0e1215), bytes4(0x69aa7e02), bytes4(0xcc88d4f9), bytes4(0x673c75f0), bytes4(0x64b3496b), bytes4(0x93523425), bytes4(0x64887852), bytes4(0xb2b0556d), bytes4(0x141933bf), bytes4(0xf98da2de), bytes4(0x383f170f), bytes4(0x6bbf3305), bytes4(0xcb2d0a3c), bytes4(0x11242145), bytes4(0x6af8e5a4), bytes4(0x50539159)];
    bytes4[] liquidityWeightSelects = [bytes4(0x2c5fa218), bytes4(0x225f8659)];
    bytes4[] oracleSelects = [bytes4(0xd48274a0), bytes4(0x052c3990), bytes4(0x00593bcf), bytes4(0x054ce3bd), bytes4(0xc4c5140f), bytes4(0x8b7750c2), bytes4(0x399ff0b5), bytes4(0xdd455fbf)];
    bytes4[] seasonSelects = [bytes4(0xfd497a68), bytes4(0x64ee4b80), bytes4(0xca7b7d7b), bytes4(0xf1e2dfb0), bytes4(0xfc06d2a6)];
    bytes4[] seasonGettersSelects = [bytes4(0x2a27c499), bytes4(0x89a218d2), bytes4(0xe53b479e), bytes4(0x3cee5dea), bytes4(0x8097f0ca), bytes4(0x065cb594), bytes4(0x43e0156a), bytes4(0x57801d87), bytes4(0x70fd1b06), bytes4(0xda61af62), bytes4(0x44fb7cc3), bytes4(0x2507644c), bytes4(0xd1943f7f), bytes4(0x1eedbfbb), bytes4(0x1f48a553), bytes4(0x11a8d895), bytes4(0xab843b34), bytes4(0xb3c39ce5), bytes4(0xfd6d1483), bytes4(0xdd9330d2), bytes4(0x08fa96d3), bytes4(0x35870a7a), bytes4(0x4d65f762), bytes4(0x738ad142), bytes4(0xf07f0760), bytes4(0xcb677411), bytes4(0xbbf459a7), bytes4(0xf788b47c), bytes4(0xa13a3742), bytes4(0x93c9e531), bytes4(0xbf170533), bytes4(0x5c975abb), bytes4(0x3fccd20c), bytes4(0x8223eac8), bytes4(0x471bcdbe), bytes4(0xc1cf248f), bytes4(0x43def26e), bytes4(0xc50b0fb0), bytes4(0x3b2ecb70), bytes4(0x16ada547), bytes4(0x06c499d8), bytes4(0x0e3c557a), bytes4(0x4a2c357e), bytes4(0x686b6159), bytes4(0x597490c0)];
    bytes4[] ownershipSelects = [bytes4(0x4e71e0c8), bytes4(0x8da5cb5b), bytes4(0x5f504a82), bytes4(0xf2fde38b)];

    int256[] initialPrices = [
        int256(1000e6), // ETH/USD
        1e6, // wstETH/ETH
        1e6, // USDC/USD
        50000e6 // WBTC/USD
    ];


    // deploy smart contracts
    function deploySampleContract() internal {

        // Create Beanstalk Facets
        // farm
        depotFacet = new DepotFacet();
        farmFacet = new FarmFacet();
        tokenFacet = new TokenFacet();
        tokenSupportFacet = new TokenSupportFacet();
        tractorFacet = new TractorFacet();

        // field
        fieldFacet = new FieldFacet();

        // market
        marketplaceFacet = new MarketplaceFacet();

        // metadata
        metadataFacet = new MetadataFacet();

        // silo
        approvalFacet = new ApprovalFacet();
        bdvFacet = new BDVFacet();
        claimFacet = new ClaimFacet();
        convertFacet = new ConvertFacet();
        convertGettersFacet = new ConvertGettersFacet();
        pipelineConvertFacet = new PipelineConvertFacet();
        siloFacet = new SiloFacet();
        siloGettersFacet = new SiloGettersFacet();
        whitelistFacet = new WhitelistFacet();

        // sun
        gaugeFacet = new GaugeFacet();
        gaugeGettersFacet = new GaugeGettersFacet();
        liquidityWeightFacet = new LiquidityWeightFacet();
        oracleFacet = new OracleFacet();
        seasonFacet = new SeasonFacet();
        seasonGettersFacet = new SeasonGettersFacet();

        // Deploy Diamond
        diamondCutFacet = new DiamondCutFacet();
        diamondLoupeFacet = new DiamondLoupeFacet();
        ownershipFacet = new OwnershipFacet();
        pauseFacet = new PauseFacet();
        initDiamond = new MockInitDiamondFuzz();
        diamond = new Diamond(address(diamondCutFacet));

        IDiamondCut.FacetCut[] memory cuts = _getCuts();


        // Create Tokens
        // // @note uncomment for foundry tests
        // bytes memory bytecode = type(Bean).runtimeCode; // for foundry
        // vm.etch(0xBEA0000029AD1c77D3d5D23Ba2D8893dB9d1Efab, bytecode);
        beanToken = Bean(0xBEA0000029AD1c77D3d5D23Ba2D8893dB9d1Efab);
        beanMock = MockToken(0xBEA0000029AD1c77D3d5D23Ba2D8893dB9d1Efab);
        weth = _deployToken(initERC20paramsFuzz("Weth", "WETH", 18));
        wstEth = _deployToken(initERC20paramsFuzz("wstETH", "WSTETH", 18));
        usdc = _deployToken(initERC20paramsFuzz("USDC", "USDC", 6));
        usdt = _deployToken(initERC20paramsFuzz("USDT", "USDT", 6));
        wbtc = _deployToken(initERC20paramsFuzz("WBTC", "WBTC", 6));

        mockTokens = [beanMock, weth, wstEth, usdc, usdt, wbtc];

        // gives ADMIN default admin role & minter role
        bytes32 outerSlot = keccak256(abi.encode(beanToken.DEFAULT_ADMIN_ROLE(), uint256(5)));
        bytes32 memberSlot = keccak256(abi.encode(ADMIN, outerSlot));
        vm.store(address(beanToken), memberSlot, bytes32(uint256(1)));

        vm.prank(ADMIN);
        beanToken.grantRole(keccak256("MINTER_ROLE"), ADMIN);

        // Deploys CP2, Well Impl, Multi Flow Pump, Mock Pump, & Aquifier
        _deployBasin();

        // // Deploy bean eth well & bean wstEth well
        beanEthWell = IWell(_deployWell(weth));
        beanWstEthWell = IWell(_deployWell(wstEth));

        vm.prank(address(diamondCutFacet));
        IDiamondCut(address(diamond)).diamondCut(
            cuts,
            address(initDiamond),
            abi.encodeWithSignature("init(address,address)", address(beanEthWell), address(beanWstEthWell))
        );

        // Create Ecosystem
        junction = new Junction();
        mathJunction = new MathJunction();
        logicJunction = new LogicJunction();

        lSDChainlinkOracle = new LSDChainlinkOracle();

        beanstalkPrice = new BeanstalkPrice(address(diamond));
        wellPrice = new WellPrice(address(diamond));

        drafter = new Drafter();
        gaugePriceThreshold = new GaugePriceThreshold(address(diamond), address(weth), 1e6, 1e6); //@note look into better values for last two params
        operatorWhitelist = new OperatorWhitelist(ADMIN);
        priceManipulation = new PriceManipulation(address(diamond));
        shipment_planner = new ShipmentPlanner(address(diamond), address(beanToken));
        tractorHelpers = new TractorHelpers(address(diamond), address(beanstalkPrice), ADMIN, address(priceManipulation));
        sowBlueprintv0 = new SowBlueprintv0(address(diamond), ADMIN, address(tractorHelpers));

        // Create Pipeline
        pipeLine = new Pipeline();

        // Create Oracles & set initital price
        cl_eth_usd = _deployOracle(0);
        cl_wseth_eth = _deployOracle(1);
        cl_usdc_usd = _deployOracle(2);
        cl_wbtc_usd = _deployOracle(3);

        // Whitelist oracles
        _whitelistOracle();

        // // Initialize shipping
        _initShipping();
        
        uniFactory = new MockUniswapV3Factory();

        // Create Uniswap & set initital prices
        uni_wstEth_weth = _deployUniswapPool(address(wstEth), address(weth), 0);
        uni_wbtc_usdc = _deployUniswapPool(address(wbtc), address(usdc), 1);

    }

    // label contracts
    function labelAll() internal {
        //CONTRACTS
        vm.label(address(diamond), "PINTO");
        vm.label(address(depotFacet), "DEPOT_FACET");
        vm.label(address(farmFacet), "FARM_FACET");
        vm.label(address(tokenFacet), "TOKEN_FACET");
        vm.label(address(tokenSupportFacet), "TOKEN_SUPPORT_FACET");
        vm.label(address(tractorFacet), "TRACTOR_FACET");
        vm.label(address(fieldFacet), "FIELD_FACET");
        vm.label(address(marketplaceFacet), "MARKETPLACE_FACET");
        vm.label(address(metadataFacet), "METADATA_FACET");
        vm.label(address(approvalFacet), "APPROVAL_FACET");
        vm.label(address(bdvFacet), "BDV_FACET");
        vm.label(address(claimFacet), "CLAIM_FACET");
        vm.label(address(convertFacet), "CONVERT_FACET");
        vm.label(address(convertGettersFacet), "CONVERT_GETTERS_FACET");
        vm.label(address(pipelineConvertFacet), "PIPELINE_CONVERT_FACET");
        vm.label(address(siloFacet), "SILO_FACET");
        vm.label(address(siloGettersFacet), "SILO_GETTERS_FACET");
        vm.label(address(whitelistFacet), "WHITELIST_FACET");
        vm.label(address(gaugeFacet), "GAUGE_FACET");
        vm.label(address(gaugeGettersFacet), "GAUGE_GETTERS_FACET");
        vm.label(address(liquidityWeightFacet), "LIQ_WEIGHT_FACET");
        vm.label(address(oracleFacet), "ORACLE_FACET");
        vm.label(address(seasonFacet), "SEASON_FACET");
        vm.label(address(seasonGettersFacet), "SEASON_GETTERS_FACET");
        vm.label(address(junction), "JUNCTION");
        vm.label(address(mathJunction), "MATH_JUNCTION");
        vm.label(address(logicJunction), "LOGIC_JUNCTION");
        vm.label(address(lSDChainlinkOracle), "LSD_CHAINLINK_ORACLE");
        vm.label(address(beanstalkPrice), "BEANSTALK_PRICE");
        vm.label(address(wellPrice), "WELL_PRICE");
        vm.label(address(drafter), "DRAFTER");
        vm.label(address(gaugePriceThreshold), "GAUGE_PRICE_THRESHOLD");
        vm.label(address(operatorWhitelist), "OPERATOR_WHITELIST");
        vm.label(address(priceManipulation), "PRICE_MANIPULATION");
        vm.label(address(shipment_planner), "SHIPMENT_PLANNER");
        vm.label(address(tractorHelpers), "TRACTOR_HELPERS");
        vm.label(address(sowBlueprintv0), "SOW_BLUE_PRINT_V0");

        //USERS
        vm.label(USER1, "USER1");
        vm.label(USER2, "USER2");
        vm.label(USER3, "USER3");
        vm.label(ADMIN, "ADMIN");

        //TOKENS
        vm.label(address(beanToken), "BEAN");
        vm.label(address(weth), "WETH");
        vm.label(address(wstEth), "WSTETH");
        vm.label(address(usdc), "USDC");
        vm.label(address(usdt), "USDT");
        vm.label(address(wbtc), "WBTC");

        // ORACLES
        vm.label(address(cl_eth_usd), "CL_ETH_USD");
        vm.label(address(cl_wseth_eth), "CL_WSTETH_ETH");
        vm.label(address(cl_usdc_usd), "CL_USDC_USDT");
        vm.label(address(cl_wbtc_usd), "CL_WBTC_USD");

        // UNISWAP
        vm.label(address(uni_wstEth_weth), "UNI_WSTETH_WETH");
        vm.label(address(uni_wbtc_usdc), "UNI_WBTC_USDC");

        // BASIN
        vm.label(0xBA510C20FD2c52E4cb0d23CFC3cCD092F9165a6E, "CP2");
        vm.label(0xBA510f10E3095B83a0F33aa9ad2544E22570a87C, "MULTI_FLOW_PUMP");
        vm.label(address(mockPump), "MOCK_PUMP");
        vm.label(0xBA510e11eEb387fad877812108a3406CA3f43a4B, "WELL_IMPL");
        vm.label(0xBA51AAAA95aeEFc1292515b36D86C51dC7877773, "AQUIFIER");

        vm.label(address(beanEthWell), "BEAN_ETH_WELL");
        vm.label(address(beanWstEthWell), "BEAN_WSTETH_WELL");
              
    }

    // helper function to deploy ERC-20 tokens
    function _deployToken(initERC20paramsFuzz memory _token) internal returns(MockToken token) {
        token = new MockToken(_token.name, _token.symbol);
        MockToken(token).setDecimals(_token.decimals);
    }

    // helper function to deploy chainlink oracles
    function _deployOracle(uint256 _index) internal returns(MockChainlinkAggregator oracle) {
        oracle = new MockChainlinkAggregator();
        MockChainlinkAggregator(oracle).setDecimals(6);

        uint256 time;

        if (block.timestamp < 900) {
            time = 1; // min timestamp = 1.
        } else {
            time = block.timestamp - 900;
        }
        uint80 latestRound = MockChainlinkAggregator(oracle).getLatestRoundId();
        MockChainlinkAggregator(oracle).addRound(initialPrices[_index], time, time, latestRound + 1);
    }


    // helper function to deploy uniswap pools            
    function _deployUniswapPool(address _token0, address _token1, uint256 _index) internal returns(MockUniswapV3Pool pool) {
        address poolAddress = uniFactory.createPool(_token0, _token1, 100);
        pool = MockUniswapV3Pool(poolAddress);        

        uint256 price = _calcPrice(uniPriceData[_index][0], uniPriceData[_index][1]);
        pool.setOraclePrice(price, uint8(uniPriceData[_index][1]));

        pool.setToken0(_token0);
        pool.setToken1(_token1);
    }

    // helper function to format price calculation
    function _calcPrice(uint256 _price, uint256 decimal) internal pure returns (uint256 price) {
        uint256 x;
        if (decimal == 6) {
            x = 1e18;
        } else if (decimal == 18) {
            x = 1e36;
        } else if (decimal == 8) {
            x = 1e14;
        }
        price = x / (_price + 1);
    }

    // deploy CP2, Well, Multi Flow Pump, & Aquifier
    // @note uncomment these for foundry tests  
    function _deployBasin() internal {
        // get CP2 creation code & deploy
        // bytes memory cp2CreationCode = vm.getCode("./node_modules/@beanstalk/wells1.2/out/ConstantProduct2.sol/ConstantProduct2.json");

        // vm.etch(0xBA510C20FD2c52E4cb0d23CFC3cCD092F9165a6E, abi.encodePacked(cp2CreationCode, bytes("")));

        // (bool success, bytes memory runtimeBytecode) = 0xBA510C20FD2c52E4cb0d23CFC3cCD092F9165a6E.call("");
        
        // if (!success) {
        //     revert();
        // }
        // vm.etch(0xBA510C20FD2c52E4cb0d23CFC3cCD092F9165a6E, runtimeBytecode);
        cp2 = ICP2(0xBA510C20FD2c52E4cb0d23CFC3cCD092F9165a6E);

        // // get Multi Flow Pump creation code & deploy
        // bytes memory multiFlowPumpCreationCode = vm.getCode("./node_modules/@beanstalk/wells1.2/out/MultiFlowPump.sol/MultiFlowPump.json");
        // vm.etch(0xBA510f10E3095B83a0F33aa9ad2544E22570a87C, abi.encodePacked(multiFlowPumpCreationCode, abi.encode(bytes16(0x3ff50624dd2f1a9fbe76c8b439581062), bytes16(0x3ff505e1d27a3ee9bffd7f3dd1a32671), uint256(12), bytes16(0x3ffeef368eb04325c526c2246eec3e55))));
        // (success, runtimeBytecode) = 0xBA510f10E3095B83a0F33aa9ad2544E22570a87C.call("");

        // if (!success) {
        //     revert();
        // }
        // vm.etch(0xBA510f10E3095B83a0F33aa9ad2544E22570a87C, runtimeBytecode);
        multiFlowPump = IMultiFlowPump(0xBA510f10E3095B83a0F33aa9ad2544E22570a87C);
        
        mockPump = new MockPump();

        // get Well Implementation creation code & deploy
        // bytes memory wellImplementationCreationCode = vm.getCode("./node_modules/@beanstalk/wells1.2/out/Well.sol/Well.json");
        // vm.etch(0xBA510e11eEb387fad877812108a3406CA3f43a4B, abi.encodePacked(wellImplementationCreationCode, bytes("")));
        // (success, runtimeBytecode) = 0xBA510e11eEb387fad877812108a3406CA3f43a4B.call("");

        // if (!success) {
        //     revert();
        // }
        // vm.etch(0xBA510e11eEb387fad877812108a3406CA3f43a4B, runtimeBytecode);
        wellImpl = IWellImpl(0xBA510e11eEb387fad877812108a3406CA3f43a4B);
        
        // get aquifier creation code & deploy
        // bytes memory aquifierCreationCode = vm.getCode("./node_modules/@beanstalk/wells/out/Aquifer.sol/Aquifer.json");
        // vm.etch(0xBA51AAAA95aeEFc1292515b36D86C51dC7877773, abi.encodePacked(aquifierCreationCode, bytes("")));
        // (success, runtimeBytecode) = 0xBA51AAAA95aeEFc1292515b36D86C51dC7877773.call("");
        
        // if (!success) {
        //     revert();
        // }
        // vm.etch(0xBA51AAAA95aeEFc1292515b36D86C51dC7877773, runtimeBytecode);
        aquifier = IAquifer(0xBA51AAAA95aeEFc1292515b36D86C51dC7877773);
    }

    // deploy well
    function _deployWell(MockToken _pairToken) internal returns(address) {

        uint256[] memory _init0 = new uint256[](2);

        string memory wellName = string(
            abi.encodePacked(beanToken.name(), _pairToken.name(), "Well")
        );
        string memory wellSymbol = string(
            abi.encodePacked(beanToken.name(), _pairToken.name(), "Well")
        );

        address[] memory tokens = new address[](2);
        tokens[0] = address(beanToken);
        tokens[1] = address(weth);

        Call[] memory pumpData = new Call[](1);
        pumpData[0].target = address(mockPump);
        pumpData[0].data = new bytes(0);
        DeployWellData memory wellEncodedData = DeployWellData(
            tokens,            // tokens
            Call(              // wellFunction
                address(cp2),  // target
                new bytes(0)   // data
            ), 
            pumpData           // pumps
        ); 

        bytes memory packedPumpData;

        for (uint256 i; i < wellEncodedData.pumps.length; ++i) {
            Call memory pump = wellEncodedData.pumps[i];
            packedPumpData = abi.encodePacked(
                packedPumpData,
                pump.target,
                pump.data.length,
                pump.data
            );
        }

        bytes memory encodedWellParams = abi.encodePacked(
            address(aquifier),
            wellEncodedData.tokens.length,
            wellEncodedData.wellFunction.target,
            wellEncodedData.wellFunction.data.length,
            wellEncodedData.pumps.length,
            wellEncodedData.tokens,
            wellEncodedData.wellFunction.data,
            packedPumpData
        );

        (bool success, bytes memory val) = address(aquifier).call(abi.encodeWithSelector(IAquifer.boreWell.selector, 
            address(wellImpl),
            encodedWellParams,
            abi.encodeWithSignature("init(string,string)", wellName, wellSymbol),
            bytes32(0)
        ));

        

        address wellAddress = abi.decode(val, (address));

        return wellAddress;
    }

    function _copyContractState(address source, address target) internal {
        uint256 slot = 0;
        for (uint256 i = 0; i < 100; i++) {
            bytes32 value = vm.load(source, bytes32(slot));
            if (value != bytes32(0)) {
                vm.store(target, bytes32(slot), value);
            }
            slot++;
        }
    }

    // whitelist oracle for diamond
    function _whitelistOracle() internal {
        IMockFBeanstalk.Implementation memory oracleImplementation = IMockFBeanstalk.Implementation(
            address(cl_eth_usd),
            bytes4(0),
            bytes1(0x01),
            abi.encode(14400)
        );

        vm.prank(address(diamond));
        address(diamond).call(abi.encodeWithSelector(WhitelistFacet.updateOracleImplementationForToken.selector, address(weth), oracleImplementation));

        uint256 _ethTimeout = 3600 * 4;
        
        vm.prank(address(diamond));
        address(diamond).call(
            abi.encodeWithSelector(
                WhitelistFacet.updateOracleImplementationForToken.selector, 
                address(wstEth), 
                IMockFBeanstalk.Implementation(
                    address(lSDChainlinkOracle),
                    lSDChainlinkOracle.getPrice.selector,
                    bytes1(0x00),
                    abi.encode(address(cl_eth_usd), _ethTimeout, address(cl_wseth_eth), 14400)
                )
            )
        );
    }

    // initialize shipment routes
    function _initShipping() internal {

        vm.prank(address(diamondCutFacet));
        address(diamond).call(
            abi.encodeWithSelector(
                FieldFacet.addField.selector
            )
        );

        vm.prank(address(diamondCutFacet));
        address(diamond).call(
            abi.encodeWithSelector(
                FieldFacet.setActiveField.selector,
                0,
                1
            )
        );

        mockBudget = new MockBudget();
        mockPayback = new MockPayback(address(beanToken));

        shipPlanner = new ShipmentPlanner(address(diamond), address(beanToken));

        IBeanstalk.ShipmentRoute[] memory shipmentRoutes = new IBeanstalk.ShipmentRoute[](2);
        shipmentRoutes[0] = IBeanstalk.ShipmentRoute({
            planContract: address(shipPlanner),
            planSelector: IShipmentPlanner.getSiloPlan.selector,
            recipient: IBeanstalk.ShipmentRecipient.SILO,
            data: abi.encode("")
        });
        shipmentRoutes[1] = IBeanstalk.ShipmentRoute({
            planContract: address(shipPlanner),
            planSelector: IShipmentPlanner.getFieldPlan.selector,
            recipient: IBeanstalk.ShipmentRecipient.FIELD,
            data: abi.encode(uint256(0))
        });

        vm.prank(address(diamondCutFacet));
        address(diamond).call(
            abi.encodeWithSelector(
                Distribution.setShipmentRoutes.selector,
                shipmentRoutes
            )
        );

    }

    
    // helper function to get diamond cuts
    function _getCuts() internal returns (IDiamondCut.FacetCut[] memory cuts) {
        cuts = new IDiamondCut.FacetCut[](24);

        cuts[0] = IDiamondCut.FacetCut({
            facetAddress: address(depotFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: depotSelects
        });


        cuts[1] = IDiamondCut.FacetCut({
            facetAddress: address(farmFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: farmSelects
        });


        cuts[2] = IDiamondCut.FacetCut({
            facetAddress: address(tokenFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: tokenSelects
        });

        cuts[3] = IDiamondCut.FacetCut({
            facetAddress: address(tokenSupportFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: tokenSupportSelects
        });

        cuts[4] = IDiamondCut.FacetCut({
            facetAddress: address(tractorFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: tractorSelects
        });

        cuts[5] = IDiamondCut.FacetCut({
            facetAddress: address(fieldFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: fieldSelects
        });

        cuts[6] = IDiamondCut.FacetCut({
            facetAddress: address(marketplaceFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: marketplaceSelects
        });

        cuts[7] = IDiamondCut.FacetCut({
            facetAddress: address(metadataFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: metadataSelects
        });

        cuts[8] = IDiamondCut.FacetCut({
            facetAddress: address(approvalFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: approvalSelects
        });

        cuts[9] = IDiamondCut.FacetCut({
            facetAddress: address(bdvFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: bdvSelects
        });

        cuts[10] = IDiamondCut.FacetCut({
            facetAddress: address(claimFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: claimSelects
        });

        cuts[11] = IDiamondCut.FacetCut({
            facetAddress: address(convertFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: convertSelects
        });

        cuts[12] = IDiamondCut.FacetCut({
            facetAddress: address(convertGettersFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: convertGettersSelects
        });

        cuts[13] = IDiamondCut.FacetCut({
            facetAddress: address(pipelineConvertFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: pipelineConvertSelects
        });

        cuts[14] = IDiamondCut.FacetCut({
            facetAddress: address(siloFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: siloSelects
        });

        cuts[15] = IDiamondCut.FacetCut({
            facetAddress: address(siloGettersFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: siloGettersSelects
        });

        cuts[16] = IDiamondCut.FacetCut({
            facetAddress: address(whitelistFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: whitelistSelects
        });

        cuts[17] = IDiamondCut.FacetCut({
            facetAddress: address(gaugeFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: gaugeSelects
        });

        cuts[18] = IDiamondCut.FacetCut({
            facetAddress: address(gaugeGettersFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: gaugeGettersSelects
        });

        cuts[19] = IDiamondCut.FacetCut({
            facetAddress: address(liquidityWeightFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: liquidityWeightSelects
        });

        cuts[20] = IDiamondCut.FacetCut({
            facetAddress: address(oracleFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: oracleSelects
        });

        cuts[21] = IDiamondCut.FacetCut({
            facetAddress: address(seasonFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: seasonSelects
        });

        cuts[22] = IDiamondCut.FacetCut({
            facetAddress: address(seasonGettersFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: seasonGettersSelects
        });

        cuts[23] = IDiamondCut.FacetCut({
            facetAddress: address(ownershipFacet),
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: ownershipSelects
        });
    }


    
    
    
}


