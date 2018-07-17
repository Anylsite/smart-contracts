package main

import (
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	"github.com/hyperledger/fabric/protos/peer"
)

type DeviceManager struct {
}

func main() {
	if err := shim.Start(new(DeviceManager)); err != nil {
		fmt.Printf("Error starting DeviceManager: %s", err)
	}
}

func (deviceManager *DeviceManager) Init(stub shim.ChaincodeStubInterface) peer.Response {
	return shim.Success(nil)
}

func (deviceManager *DeviceManager) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	fn, args := stub.GetFunctionAndParameters()

	var result string
	var err error
	
	if fn == "UpdateDeviceRegistration" {
		result, err = UpdateDeviceRegistration(stub, args)
	}

	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success([]byte(result))
}

func UpdateDeviceRegistration(stub shim.ChaincodeStubInterface, args []string) (string, error) {
	if len(args) != 2 {
		return "", fmt.Errorf("Incorrect arguments. Expecting a key and a value")
	}

	var deviceId, ipfsHash string

	deviceId = args[0]
	ipfsHash = args[1]

	err := stub.PutState(deviceId, []byte(ipfsHash))
	if err != nil {
		return "", fmt.Errorf("Failed to register device with Id: %s", deviceId)
	}

	return ipfsHash, nil
}
