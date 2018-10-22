package main

import (
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	"github.com/hyperledger/fabric/protos/peer"
)

type DeviceManager struct {
}

var logger = shim.NewLogger("device_manager")

func main() {
	if err := shim.Start(new(DeviceManager)); err != nil {
		fmt.Printf("Error starting DeviceManager: %s", err)
	}
}

func (deviceManager *DeviceManager) Init(stub shim.ChaincodeStubInterface) peer.Response {
	logger.Info("########### Device Manager Init ###########")
	return shim.Success(nil)
}

func (deviceManager *DeviceManager) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	logger.Info("########### Device Manager Invoke ###########")
	fn, args := stub.GetFunctionAndParameters()

	if fn == "UpdateDeviceRegistration" {
		return deviceManager.UpdateDeviceRegistration(stub, args)
	} else if fn == "GetDeviceRegistration" {
		return deviceManager.GetDeviceRegistration(stub, args)
	}

	logger.Errorf("Received unknown function invocation")
	return shim.Error(fmt.Sprintf("Received unknown function invocation"))
}

/*
	This function creates/updates a key for Device to store IPFS hash value against it.
	Arguments : Device-Id, IPFS-hash
*/
func (deviceManager *DeviceManager) UpdateDeviceRegistration(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	if len(args) != 2 {
		errResp := "Incorrect arguments. Expecting a key and a value"
		logger.Errorf(errResp)
		return shim.Error(errResp)
	}

	var deviceId, ipfsHash string

	deviceId = args[0]
	ipfsHash = args[1]

	err := stub.PutState(deviceId, []byte(ipfsHash))
	if err != nil {
		errResp := fmt.Sprintf("Failed to register device with Id: %s", deviceId)
		logger.Errorf(errResp)
		return shim.Error(errResp)
	}

	return shim.Success([]byte(ipfsHash))
}

/*
	This function returns last stored IPFS hash for a Device
	Arguments : Device-Id
*/
func (deviceManager *DeviceManager) GetDeviceRegistration(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	var deviceId string // key to read

	if len(args) != 1 {
		errResp := "Incorrect no of arguments. Expecting a device Id"
		logger.Errorf(errResp)
		return shim.Error(errResp)
	}

	deviceId = args[0]

	// Get the state from the ledger
	deviceInfo, err := stub.GetState(deviceId)
	if err != nil {
		errResp := "Failed to get state for device with Id: " + deviceId
		logger.Errorf(errResp)
		return shim.Error(errResp)
	}

	if deviceInfo == nil {
		errResp := "Nil value for device Id: " + deviceId
		logger.Errorf(errResp)
		return shim.Error(errResp)
	}

	logger.Infof("GetDeviceRegistration Response:%s\n", string(deviceInfo))
	return shim.Success(deviceInfo)
}
