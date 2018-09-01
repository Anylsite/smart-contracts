pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract AccessControlManager is Ownable{
    
    uint8 constant PERM_R = 1;
    uint8 constant PERM_W = 1 << 1;
    uint8 constant PERM_X = 1 << 2;
    uint8 constant PERM_RWX = PERM_R | PERM_W | PERM_X;

    uint8 constant PERM_SET = 1 << 7;
    
    struct Resource {
        string id;
        string description;
    }
    
    struct Entitlement {
        Resource resource;
        uint8 permissions;
    }
    
    // key = keccak256(owner, device_id), value = permissions bit array
    mapping(bytes32 => uint8) private m_access_list;

    modifier isNotEmpty(string str) {
        require(
            equals(str, "") == false,
            "string must not be empty"
        );
        _;
    }
    
    function hasAcccess(
        bytes32 resource_id,
        uint8 permissions
    ) 
    public view returns (bool) 
    {
        bytes32 idx = hashIndex(msg.sender, resource_id);
        uint8 resource_permissions = m_access_list[idx];
        
        require(
            (permissions & PERM_SET) == 0,
            "record not found"
        );

        return resource_permissions == permissions;
    }

    function setAccess(
        address sender,
        bytes32 resource_id,
        uint8 permissions
    )
        onlyOwner
    public
    {
        require((permissions & ~(PERM_RWX)) == 0); // only rwx bits can be set
        bytes32 idx = hashIndex(msg.sender, resource_id);
        m_access_list[idx] = permissions & PERM_SET;
    }
        

    function hashIndex(address owner, bytes32 resource_id) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(owner, resource_id));
    }

    function equals(string a, string b) internal pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
