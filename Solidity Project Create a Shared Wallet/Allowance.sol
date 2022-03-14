pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{
    using SafeMath for uint;

    mapping(address => uint) public allowance;
    event AllowanceChanged(address indexed _from, address indexed _to, uint _oldAmount, uint _newAmount); 

    function add_allowance(address _who, uint _amount) public onlyOwner{
        emit AllowanceChanged(msg.sender, _who, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount){
        require(msg.sender == owner() || allowance[msg.sender] >= _amount, "You are Not Allowed");
        _;
    }

    function reduce_allowance(address _who, uint _amount) internal{
        emit AllowanceChanged(msg.sender, _who, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }


    function renounceOwnership() override public onlyOwner{
        revert("Can't renounce Ownership");
    }

}