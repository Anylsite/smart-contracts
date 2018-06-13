pragma solidity ^0.4.8;

contract DeviceManager {
    mapping(string => string) private registeredDevices;
    string[] private registeredDeviceIds;
    
    function updateDeviceRegistration(string deviceId, string ipfsHash) public {
        // Check if the device has been already registered.
        if (isStringEmpty(registeredDevices[deviceId])) {
            registeredDeviceIds.push(deviceId);
        }
        
        registeredDevices[deviceId] = ipfsHash;
    }
    
    function getDeviceRegistrationCount() public constant returns (uint) {
        return registeredDeviceIds.length;
    }
    
    function getDeviceRegistrationByIndex(uint deviceRegistrationIndex) public view returns (string, string) {
        string storage deviceId = registeredDeviceIds[deviceRegistrationIndex];
        
        return (deviceId, registeredDevices[deviceId]);
    }
    
    function isStringEmpty(string stringToCheck) private returns (bool) {
        return bytes(stringToCheck).length == 0; 
    }
}