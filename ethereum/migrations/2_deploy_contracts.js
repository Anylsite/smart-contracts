var DeviceManager = artifacts.require("./DeviceManager.sol");

module.exports = function(deployer) {
  deployer.deploy(DeviceManager)
        .then(() => DeviceManager.deployed())
        .then(_instance => console.log(_instance.address));
};
