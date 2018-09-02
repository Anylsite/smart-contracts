pragma solidity ^0.4.8;

contract AccessControlManager {
    address private deviceOwner = 0x7d9ae42dd0B5c458D15a2DC4d52459C3CD554d8B;
    
    // Using struct instead of Enum due to gas costs when iterating over an array with Permissions
    struct Permissions { 
        bool canRead;
        bool canWrite;
        bool canExecute;
    }
    
    struct Resource {
        string id;
        string description;
    }
    
    struct Entitlement {
        Resource resource;
        Permissions permissions;
    }
    
    mapping(address => Entitlement[]) private entitlements;
    
    function hasAcccess(string resourceId, bool canWrite, bool canRead, bool canExecute) public view returns (bool) {
        // Device owner has Administrator level access
        if (msg.sender == deviceOwner)
            return true;
        
        Entitlement[] storage currentEntitlements = entitlements[msg.sender];
        
        if (currentEntitlements.length == 0)
            return false;

        // Iterate over all Entitlements   
        for (uint entitlementIndex = 0; entitlementIndex < currentEntitlements.length; entitlementIndex++) {

            // Check if there is a matching Resource with the requested Resource Id
            if (compareStrings(currentEntitlements[entitlementIndex].resource.id, resourceId)) {

                // Check if the requested permissions are matching the allowed ones
                if (canRead == currentEntitlements[entitlementIndex].permissions.canRead &&
                    canWrite == currentEntitlements[entitlementIndex].permissions.canWrite &&
                    canExecute == currentEntitlements[entitlementIndex].permissions.canExecute) {
                        return true;
                    }
                
                return false;
            }
        }
        
        return false;
    }
    
    function compareStrings(string firstString, string secondString) public pure returns (bool) {
        return keccak256(firstString) == keccak256(secondString);
    }
}