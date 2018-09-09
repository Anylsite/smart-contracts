var TraceabilitySupplyChain = artifacts.require("./TraceabilitySupplyChain.sol");

module.exports = function(deployer) {
  deployer.deploy(TraceabilitySupplyChain, "0x3d7342d400aa70d1dd48ce09fd82db006ed21eee");
};
