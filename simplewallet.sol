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
    
    mapping(address => Permission) permittedAddress;
    
    event someoneAddedSomeoneToTheSendersList(address thePersonWhoAdded, address thePersonWhoiIsAllowedNow, uint thisMuchHeCanSend);
     
     struct Permission {
         bool isAllowed;
         uint maxTransferAmount;
     }
    
    function addAddressToSendersList(address permitted, uint maxTransferAmount) onlyowner public {
        permittedAddress[permitted] = Permission(true, maxTransferAmount);
        someoneAddedSomeoneToTheSendersList(msg.sender, permitted, maxTransferAmount);
    }
    
    function sendFunds(address receiver, uint amountInWei) public {
        if(permittedAddress[msg.sender].isAllowed) {
                if(permittedAddress[msg.sender].maxTransferAmount >= amountInWei) {
                    bool isTheAmountReallySent = receiver.send(amountInWei);
                    if(!isTheAmountReallySent) {
                        revert();
                        }
                    } else {
                     revert();
                    }
                } else {
                    revert();
                }
            }
            
    function removeAddressFromSendersList(address theAddress) public {
        delete permittedAddress[theAddress];
    }        
      
    
    function () payable public {
        
    }
}