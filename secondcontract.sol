pragma solidity ^0.4.0;
contract MyContract {
    
    uint256 myVariable;
    
    address owner;

    function MyContract() payable {
        myVariable = 5;
        owner = msg.sender;
    }
    
    function setMyVariable(uint myNewVariable) {
        if(msg.sender == owner) {
            myVariable = myNewVariable;
        }
    }
    
    function getMyVariable() constant returns(uint) {
        return myVariable;
    }
    
    function getMyContractBalance() constant returns(uint256) {
        return this.balance;
    }
    
    function () payable {
        
    }
    
}