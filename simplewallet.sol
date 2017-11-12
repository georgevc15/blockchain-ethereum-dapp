pragma solidity ^0.4.0;

contract owned {
     address owner;

     modifier onlyowner() {
        if(owner == msg.sender) {
        _;
        } else {
            revert();
            }
    }   
}


contract mortal is owned {

    function mortal() public {
        owner = msg.sender;
    }
    
    function destroy() onlyowner public {
        selfdestruct(owner);
    }
}


contract SimpleWallet is mortal {
    
    mapping(address => Permission) myAddressMapping;
     
     struct Permission {
         bool isAllowed;
         uint maxTransferAmount;
     }
    
    function addAddressToSendersList(address permitted, uint maxTransferAmount) onlyowner public {
        myAddressMapping[permitted] = Permission(true, maxTransferAmount);
    }
    
    function sendFunds(address receiver, uint amountInWei) public {
        if(myAddressMapping[msg.sender].isAllowed) {
            if(myAddressMapping[msg.sender].maxTransferAmount <= amountInWei) {
                receiver.send(amountInWei);
            }
        }
    }

    function () payable public {
        
    }
}