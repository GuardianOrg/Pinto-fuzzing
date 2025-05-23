const { expect } = require("chai");
const { deploy } = require("../../scripts/deploy.js");
const { parseJson, to6, to18 } = require("./utils/helpers.js");
const { MAX_UINT32, BEAN, BEAN_WSTETH_WELL, WSTETH } = require("./utils/constants.js");
const { getAllBeanstalkContracts } = require("../../utils/contracts.js");
const { deployMockWellWithMockPump } = require("../../utils/well.js");
const { setEthUsdChainlinkPrice, setWstethUsdPrice } = require("../../utils/oracle.js");
const { advanceTime } = require("../../utils/helpers.js");

// // Set the test data
const [columns, tests] = parseJson("test/data/weather.json");
var numberTests = tests.length;
var startTest = 0;

const SOW_TIME_STEADY_LOWER = 100; // this should match the setting in LibEvaluate.sol
const SOW_TIME_STEADY_UPPER = 300; // this should match the setting in LibEvaluate.sol

async function setToSecondsAfterHour(seconds = 0) {
  const lastTimestamp = (await ethers.provider.getBlock("latest")).timestamp;
  const hourTimestamp = parseInt(lastTimestamp / 3600 + 1) * 3600 + seconds;
  await network.provider.send("evm_setNextBlockTimestamp", [hourTimestamp]);
}

describe("Complex Weather", function () {
  before(async function () {
    [owner, user, user2] = await ethers.getSigners();

    user2.address = user2.address;
    const contracts = await deploy((verbose = false), (mock = true), (reset = true));
    ownerAddress = contracts.account;
    this.diamond = contracts.beanstalkDiamond;

    bean = await ethers.getContractAt("MockToken", BEAN);

    // `beanstalk` contains all functions that the regular beanstalk has.
    // `mockBeanstalk` has functions that are only available in the mockFacets.
    [beanstalk, mockBeanstalk] = await getAllBeanstalkContracts(this.diamond.address);

    // wells
    [this.well, this.wellFunction, this.pump] = await deployMockWellWithMockPump();
    await this.well.setReserves([to6("1000000"), to18("1000")]);
    [this.beanWstethWell, this.wellFunction, this.pump] = await deployMockWellWithMockPump(
      BEAN_WSTETH_WELL,
      WSTETH
    );
    await this.beanWstethWell.setReserves([to6("1000000"), to18("1000")]);
    await this.beanWstethWell.setReserves([to6("1000000"), to18("1000")]);
    await this.well.setReserves([to6("1000000"), to18("1000")]);
    await this.well.setReserves([to6("1000000"), to18("1000")]);
    await advanceTime(3600);
    await owner.sendTransaction({ to: user.address, value: 0 });
    await setToSecondsAfterHour(0);
    await owner.sendTransaction({ to: user.address, value: 0 });
    await this.well.connect(user).mint(user.address, to18("1000"));
    await beanstalk.connect(user).sunrise();
    await mockBeanstalk.captureWellE(this.well.address);
    await mockBeanstalk.captureWellE(this.beanWstethWell.address);

    await setEthUsdChainlinkPrice("1000");
    await setWstethUsdPrice("1000");

    // temporary override to allow testing of 0 soil sown until PI-9.
    await mockBeanstalk.setMinSoilSownDemand(0);
  });

  [...Array(numberTests).keys()]
    .map((i) => i + startTest)
    .forEach(function (v) {
      const testStr = "Test #";
      describe(testStr.concat(v), function () {
        before(async function () {
          this.testData = {};
          columns.forEach((key, i) => (this.testData[key] = tests[v][i]));
          await mockBeanstalk.setUsdEthPrice(to18("0.001"));
          await mockBeanstalk.setYieldE(this.testData.startingWeather);
          await mockBeanstalk.setBeanToMaxLpGpPerBdvRatio(to18(this.testData.initialPercentToLp));
          bean.connect(user).burn(await bean.balanceOf(user.address));
          this.dsoil = this.testData.lastSoil;
          this.startSoil = this.testData.startingSoil;
          this.endSoil = this.testData.endingSoil;
          this.deltaB = this.testData.deltaB;
          this.pods = this.testData.unharvestablePods;
          this.aboveQ = this.testData.aboveQ;
          this.L2SRState = this.testData.L2SR;
          this.newPercentToLp = to18(this.testData.newPercentToLp);

          await bean.mint(user.address, this.testData.totalOutstandingBeans);
          await mockBeanstalk.setLastSowTimeE(this.testData.lastSowTime);
          await mockBeanstalk.setNextSowTimeE(this.testData.thisSowTime);
          this.result = await mockBeanstalk.calcCaseIdWithParams(
            this.pods,
            this.dsoil, // lastDeltaSoil
            this.startSoil - this.endSoil, // beanSown
            this.endSoil, // endSoil
            this.deltaB, // deltaB
            this.testData.wasRaining,
            this.testData.rainStalk,
            this.aboveQ, // aboveQ
            this.L2SRState // L2SR
          );
        });
        it("Checks New Weather", async function () {
          expect(await mockBeanstalk.getT()).to.eq(this.testData.newWeather);
        });

        it("Emits The Correct Case Weather", async function () {
          if (this.testData.totalOutstandingBeans !== 0)
            await expect(this.result)
              .to.emit(beanstalk, "TemperatureChange")
              .withArgs(
                await beanstalk.season(),
                this.testData.Code,
                this.testData.newWeather - this.testData.startingWeather,
                0
              );
        });

        it("Checks New Percent To LP", async function () {
          expect(await beanstalk.getBeanToMaxLpGpPerBdvRatio()).to.eq(
            to18(this.testData.newPercentToLp)
          );
        });

        it("Emits The Correct LP Case", async function () {
          if (this.testData.totalOutstandingBeans !== 0)
            await expect(this.result)
              .to.emit(beanstalk, "BeanToMaxLpGpPerBdvRatioChange")
              .withArgs(await beanstalk.season(), this.testData.Code, to18(this.testData.bL));
        });
      });
    });

  describe("Extreme Weather", async function () {
    before(async function () {
      await mockBeanstalk.setLastDSoilE("100000");
      await bean.mint(user.address, "1000000000");
      await mockBeanstalk.incrementTotalPodsE(0, "100000000000");
    });

    beforeEach(async function () {
      await mockBeanstalk.setYieldE("10000000");
    });

    it("thisSowTime immediately", async function () {
      await mockBeanstalk.setLastSowTimeE("1");
      await mockBeanstalk.setNextSowTimeE("10");
      await mockBeanstalk.calcCaseIdE(ethers.utils.parseEther("1"), "1");
      const weather = await beanstalk.weather();
      expect(weather.temp).to.equal(7000000);
      expect(weather.thisSowTime).to.equal(parseInt(MAX_UINT32));
      expect(weather.lastSowTime).to.equal(10);
    });

    it("lastSowTime max sow time decrease from max", async function () {
      await mockBeanstalk.setLastSowTimeE(MAX_UINT32);
      await mockBeanstalk.setNextSowTimeE("1000");
      await mockBeanstalk.calcCaseIdE(ethers.utils.parseEther("1"), "1");
      const weather = await beanstalk.weather();
      expect(weather.temp).to.equal(7000000);
      expect(weather.thisSowTime).to.equal(parseInt(MAX_UINT32));
      expect(weather.lastSowTime).to.equal(1000);
    });

    it("lastSowTime max sow time decrease more than steady const", async function () {
      await mockBeanstalk.setLastSowTimeE(1000 + SOW_TIME_STEADY_LOWER + 1);
      await mockBeanstalk.setNextSowTimeE("1000");
      await mockBeanstalk.calcCaseIdE(ethers.utils.parseEther("1"), "1");
      const weather = await beanstalk.weather();
      expect(weather.temp).to.equal(7000000);
      expect(weather.thisSowTime).to.equal(parseInt(MAX_UINT32));
      expect(weather.lastSowTime).to.equal(1000);
    });

    it("lastSowTime max sow time decrease less than steady const", async function () {
      await mockBeanstalk.setLastSowTimeE(1000 + SOW_TIME_STEADY_LOWER - 1);
      await mockBeanstalk.setNextSowTimeE("1000");
      await mockBeanstalk.calcCaseIdE(ethers.utils.parseEther("1"), "1");
      const weather = await beanstalk.weather();
      expect(weather.temp).to.equal(7000000);
      expect(weather.thisSowTime).to.equal(parseInt(MAX_UINT32));
      expect(weather.lastSowTime).to.equal(1000);
    });

    it("lastSowTime max sow time increase less than steady const", async function () {
      await mockBeanstalk.setLastSowTimeE("1000");
      await mockBeanstalk.setNextSowTimeE(1000 + SOW_TIME_STEADY_UPPER);
      await mockBeanstalk.calcCaseIdE(ethers.utils.parseEther("1"), "1");
      const weather = await beanstalk.weather();
      expect(weather.temp).to.equal(7000000);
      expect(weather.thisSowTime).to.equal(parseInt(MAX_UINT32));
      expect(weather.lastSowTime).to.equal(1000 + SOW_TIME_STEADY_UPPER);
    });

    it("lastSowTime max sow time increase more than steady const", async function () {
      await mockBeanstalk.setLastSowTimeE("1000");
      await mockBeanstalk.setLastSeasonAndThisSeasonBeanSown(to6("100"), to6("100"));
      await mockBeanstalk.setNextSowTimeE(1000 + SOW_TIME_STEADY_UPPER + 1);
      await mockBeanstalk.calcCaseIdE(ethers.utils.parseEther("1"), "1");
      const weather = await beanstalk.weather();
      expect(weather.temp).to.equal(9000000);
      expect(weather.thisSowTime).to.equal(parseInt(MAX_UINT32));
      expect(weather.lastSowTime).to.equal(1000 + SOW_TIME_STEADY_UPPER + 1);
    });

    it("lastSowTime max sow time increase more than steady const to max", async function () {
      await mockBeanstalk.setLastSowTimeE("900");
      await mockBeanstalk.setNextSowTimeE(MAX_UINT32);
      await mockBeanstalk.calcCaseIdE(ethers.utils.parseEther("1"), "1");
      const weather = await beanstalk.weather();
      expect(weather.temp).to.equal(7000000);
      expect(weather.thisSowTime).to.equal(parseInt(MAX_UINT32));
      expect(weather.lastSowTime).to.equal(parseInt(MAX_UINT32));
    });
  });
});
