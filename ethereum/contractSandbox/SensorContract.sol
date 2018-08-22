pragma solidity ^0.4.18;

// Skeleton of simple sensor interaction with IPFS

contract SensorContract {

    address public manifacturer; // Address of the Company building the sensors
    address public sender; // Address of the creator of the contract
    address public recipient; // Address of the final recipient

    bool contractCondition; // If true the contract condition is satisfied
    address contractAddress =  ;// address referring to this particular instance, hardcoded for now

    mapping(address => DataAggregate) public sensors;

    struct DataPoint {
    	uint timestamp;
    	string data; //e.g. temperature
    	address sensorAccountable; // accountable for the sensors at the DataPoint timestamp
    }

    struct DataAggregate {
      uint timestamp;
    	string dataAggregate;  //e.g. max of temperature
      address contract_address;
    }

    function SensorContract(address recipient_address) public {
        sender = msg.sender;
        recipient = recipient_address;
	      contractCondition = True;
    }

    // verify that starting sensor are equal to final sensors
    //function registerSensor(address deviceAddress){
    //  sensors[deviceAddress] = DataAggregate(0,"",contractAddress);
    //}

    // take the hash of a sensordata from IPFS
    function uploadSensorData(address sensorAddress, uint timestamp, string IPFSHash) onlyRecipient {
            dataAggregate = computeDataAggregate(IPFSHash);
            sensors[sensorAddress] = DataAggregate(timestamp,dataAggregate,contractAddress);
    }

    // Application specific
    // Talk to an external oracle to perform computations on the data stored in IPFS and identified by IPFSHash
    function computeDataAggregate(string IPFSHash) return (string dataAggregate){

    }

    // Application specific
    function checkCondition(address sensorAddress) public {

    }



    function closeContract(address sensorAddress, uint timestamp, string IPFSHash) public onlyRecipient{
        uploadSensorData(address sensorAddress, uint timestamp, string IPFSHash)
        checkCondition(sensorAddress);
    }


    modifier onlySender() {
        require(msg.sender == sender);
        _;
    }

    modifier onlyRecipient() {
        require(msg.sender == recipient);
        _;
    }

}
