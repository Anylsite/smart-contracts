pragma solidity ^0.4.8;

contract DeviceManager {
    string public lastRegistration;
    
    function setLastRegistration(string tempLastRegistration) public {
        lastRegistration = tempLastRegistration;
    }
}