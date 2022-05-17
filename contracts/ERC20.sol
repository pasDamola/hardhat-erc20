//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract ERC20 {
    uint256 public totalSupply;
    string public name;
    string public symbol;
    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowances;
    
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);


    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;

        _mint(msg.sender, 100e18);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can perform this function");
        _;
    }

    function decimals () external pure returns(uint256) {
        return 18;
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        return _transfer(msg.sender, recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        uint256 currentAllowance = allowances[sender][msg.sender];

        require(currentAllowance >= amount, "Not enough funds!");

        allowances[sender][msg.sender] = currentAllowance - amount;

        uint256 resultAllowance = allowances[sender][msg.sender];

        return _transfer(sender, recipient, resultAllowance);

    }

    function approve(address spender, uint256 amount) external returns (bool) {
        require(spender != address(0), "Spender is a zero address");

        allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);

        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) private returns (bool) {
        require(recipient != address(0), "You are transferring to a zero address");

        uint256 senderBalance = balanceOf[msg.sender];

        require(senderBalance >= amount, "Not enough funds!");

        balanceOf[sender] = senderBalance - amount;
        balanceOf[recipient] += amount;

        emit Transfer(sender, recipient, amount);

        return true;
    }

    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "You are transferring to a zero address");
        totalSupply += amount;
        balanceOf[to] += amount;

        emit Transfer(address(0), to, amount);
    }

    // destroy tokens in circulation
    function _burn(address to, uint256 amount) private  {
        totalSupply -= amount;
        balanceOf[to] -= amount;

        emit Transfer(msg.sender, address(0), amount);
    }

       function deposit() external payable {
        console.log("message", msg.value);
        _mint(msg.sender, msg.value);
    }

     function redeem(uint256 amount) external {
        transferFrom(msg.sender, address(this), amount);
        _burn(address(this), amount);
    }

}