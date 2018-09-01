pragma solidity ^0.4.18;

// shipper, producer of the perishable shipment, end customer, insurer are the entities

contract SupplychainContract {

    address public producer; // Address of the producer of perishableItem
    address public shipper;  // Address of the the shipment party 
    address public customer; // Address of the end customer receiving shipment
    address public insurer;  // Address of the insurer

    //Min and Max Temp Range, which will be initialized during contract deployment, degree Celsisus/Farhenight
    uint min_temp = 10; 
    uint max_temp = 200;


    //Error Messages
    string cus_err = "Assigned Customer Required";
    string shipp_err = "Assigned Shipper Required";


    struct PerishableItem{
        uint id;
        string name;
        uint cost;
        address producer;
        address shipper;
        address customer;
        uint tempitem; //Max Temperature of the Product during the transition updated regularly by sensor
    }

    PerishableItem[] public items; // array of the type of PerishableItem

    mapping (uint => address) productToInsurer; // Mapping perishable Item Product Id to Insurance address 
    
    
    // Below method will check whether the temperature falls under the valid range during transition
    function validTempRange(uint temp) public view returns (bool){           

        if(temp > min_temp && temp < max_temp){
            return true;
        }
        else{
            return false;
        }
    }


    // When Product is shipped,
    function shipProduct(uint id, string name,uint cost, address producer_add, address shipper_add, address customer_add) public{
        require(msg.sender == items[id].shipper,shipp_err);
        items.push(PerishableItem(id,name,cost,producer_add,shipper_add,customer_add,0));

    }


    //When a customer receive the product, this function gets called
    function customerReceive(uint id, address Insurer) public{ 
        require(msg.sender == items[id].customer,cus_err);

        if( !validTempRange(items[id].tempitem) ){
            productToInsurer[id] = Insurer;
        }

    }

    //product creation from producer end

    function produceProduct(uint id) public{

    }


}
