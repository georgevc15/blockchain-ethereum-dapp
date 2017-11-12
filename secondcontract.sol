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


contract MyContract is mortal {
    
    uint256 myVariable;
    
    mapping(address => Permission) myAddressMapping;
     
     struct Permission {
         bool isAllowed;
         uint maxTransferAmount;
     }
    
    
    function  MyContract() public payable {
        myVariable = 5;
        
        myAddressMapping[msg.sender] = Permission(true, 5);
    }
    
    function setMyVariable(uint myNewVariable) public onlyowner{
            myVariable = myNewVariable;
    }
    
    function getMyVariable() public constant returns(uint) {
        return myVariable;
    }
    
    function getMyContractBalance() public constant returns(uint256) {
        return this.balance;
    }
    

    function () payable public {
        
    }
}
