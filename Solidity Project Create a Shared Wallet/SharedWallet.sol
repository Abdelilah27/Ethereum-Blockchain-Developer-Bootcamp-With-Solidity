pragma solidity ^0.8.0;
import "./Allowance.sol";
//Ether To Wei 1000000000000000000

contract SharedWallet is Allowance{

    event moneySend(address indexed _to, uint _amount); 
    event moneyReceived(address indexed _from, uint _amount);

    function withdraw_money(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount < address(this).balance, "No money in the smart Contract");
        if(msg.sender != owner()){
            reduce_allowance(msg.sender, _amount);
        }
        emit moneySend(_to, _amount);
        _to.transfer(_amount);
    }

    receive () external payable {
        emit moneyReceived(msg.sender, msg.value);
    }



}