pragma solidity ^0.8.4;


contract Ownable {
    address payable owner;

    constructor() public{
        owner = payable(msg.sender);
    }

    modifier onlyOwner(){
        require(isOwner(), "You are not the Owner");
        _;
    }

    function isOwner() public view returns(bool) {
        return (msg.sender == owner);
    }

}