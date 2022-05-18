//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import { ERC20 } from "./ERC20.sol";

contract DepositorCoin is ERC20 {
    address public override owner;
    constructor() ERC20("DepositorCoin", "DPS") {
        owner = msg.sender;
    }
}