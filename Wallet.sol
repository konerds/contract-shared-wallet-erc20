pragma solidity ^0.5.13;

import "./Allowance.sol";

contract Wallet is Allowance {
    event Sent(address indexed _receiver, uint _amount);
    event Received(address indexed _sender, uint _amount);
    function renounceOwnership() public onlyOwner {
        revert("This feature is restricted!");
    }
    function withdraw(address payable _to, uint _amount) public onlyAllowed(_amount) {
        require(_amount <= address(this).balance, "Not enough balance in wallet!");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit Sent(_to, _amount);
        _to.transfer(_amount);
    }
    function () external payable {
        emit Received(msg.sender, msg.value);
    }
}