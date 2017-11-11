pragma solidity ^0.4.0;
contract MyContract {
    
    uint256 myVariable;
    
    address owner;
    
    modifier onlyowner() {
        if(owner == msg.sender) {
        _;
        } else {
            revert();
            }
        }

     function  MyContract() public payable {
        myVariable = 5;
        owner = msg.sender;
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
    
    function destroy() public onlyowner {
        selfdestruct(owner);

    }
    
    function () payable public {
        
    }
    
}