var DeviceManager = artifacts.require("./DeviceManager.sol");
var AccessControlManager = artifacts.require("./AccessControlManager.sol");

module.exports = function(deployer) {
  deployer.deploy(DeviceManager)
        .then(() => DeviceManager.deployed())
        .then(_instance => console.log(_instance.address));
  
  deployer.deploy(AccessControlManager)
        .then(() => AccessControlManager.deployed())
        .then(_instance => console.log(_instance.address));
};
