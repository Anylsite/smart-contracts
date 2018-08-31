pragma solidity ^0.4.23;

contract AccessControlManager {
    address private m_owner;

    
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

    modifier isOwner(address sender) {
        require(
            sender == m_owner,
            "only owner is allowed to call this function"
        );
        _;
    }
    modifier isNotEmpty(string str) {
        require(
            equals(str, "") == false,
            "string must not be empty"
        );
        _;
    }

    constructor(
        address owner
    )
        public
    {
        m_owner = owner;
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
        isOwner(msg.sender)
    public
    {
        require((permissions & ~(PERM_RWX)) == 0); // only rwx bits can be set
        bytes32 idx = hashIndex(msg.sender, resource_id);
        m_access_list[idx] = permissions & PERM_SET;
    }
        

    function hashIndex(address owner, bytes32 resource_id) internal pure returns (bytes32) {
        return keccak256(owner, resource_id);
    }

    function equals(string a, string b) internal pure returns (bool) {
        return keccak256(a) == keccak256(b);
    }
}
