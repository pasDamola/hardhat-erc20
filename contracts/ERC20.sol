//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract ERC20 {
    uint256 public totalSupply;
    string public name;
    string public symbol;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) allowances;


    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function decimals () external pure returns(uint256) {
        return 18;
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        return _transfer(msg.sender, recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        uint256 currentAllowance = allowances[sender][msg.sender];

        require(currentAllowance >= amount, "Not enough funds!");

        allowances[sender][msg.sender] = currentAllowance - amount;

        return _transfer(sender, recipient, amount);

    }

    function approve(address spender, uint256 amount) external returns (bool) {
        require(spender != address(0), "Spender is a zero address");

        allowances[msg.sender][spender] = amount;

        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) private returns (bool) {
        require(recipient != address(0), "You are transferring to a zero address");

        uint256 senderBalance = balanceOf[msg.sender];

        require(senderBalance >= amount, "Not enough funds!");

        balanceOf[sender] = senderBalance - amount;
        balanceOf[recipient] += amount;

        return true;
    }

}