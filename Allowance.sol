pragma solidity ^0.5.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint;
    event AllowanceChanged(address indexed _forWho, address indexed _fromWhom, uint _amountOld, uint _amountNew);
    mapping(address => uint) public allowances;
    function putAllowance(address _key, uint _value) public onlyOwner {
        emit AllowanceChanged(_key, msg.sender, allowances[_key], _value);
        allowances[_key] = _value;
    }
    modifier onlyAllowed(uint _amount) {
        require(isOwner() || allowances[msg.sender] >= _amount, "Not enough balance allowed!");
        _;
    }
    function reduceAllowance(address _key, uint _value) internal {
        emit AllowanceChanged(_key, msg.sender, allowances[_key], allowances[_key].sub(_value));
        allowances[_key] = allowances[_key].sub(_value);
    }
}