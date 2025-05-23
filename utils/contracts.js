const beanstalkABI = require("../abi/Beanstalk.json");
const mockBeanstalkABI = require("../abi/MockBeanstalk.json");
const { BEANSTALK, BEAN, USDC, PRICE, WETH } = require("../test/hardhat/utils/constants");

async function getBeanstalk(contract = BEANSTALK) {
  return await ethers.getContractAt(beanstalkABI, contract);
}

async function getMockBeanstalk(contract = BEANSTALK) {
  return await ethers.getContractAt(mockBeanstalkABI, contract);
}

async function getAllBeanstalkContracts(contract = BEANSTALK) {
  return [
    await ethers.getContractAt(beanstalkABI, contract),
    await ethers.getContractAt(mockBeanstalkABI, contract)
  ];
}

async function getBeanstalkAdminControls() {
  return await ethers.getContractAt("MockAdminFacet", BEANSTALK);
}

async function getBean() {
  return await ethers.getContractAt("Bean", BEAN);
}

async function getWeth() {
  return await ethers.getContractAt("contracts/interfaces/IWETH.sol:IWETH", WETH);
}

async function getUsdc() {
  return await ethers.getContractAt("IBean", USDC);
}

async function getPrice() {
  return await ethers.getContractAt("BeanstalkPrice", PRICE);
}

exports.getBeanstalk = getBeanstalk;
exports.getBean = getBean;
exports.getWeth = getWeth;
exports.getUsdc = getUsdc;
exports.getPrice = getPrice;
exports.getBeanstalkAdminControls = getBeanstalkAdminControls;
exports.getBeanstalk = getBeanstalk;
exports.getMockBeanstalk = getMockBeanstalk;
exports.getAllBeanstalkContracts = getAllBeanstalkContracts;
