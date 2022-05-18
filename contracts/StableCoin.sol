//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import { ERC20 } from "./ERC20.sol"; 
import { DepositorCoin } from "./DepositorCoin.sol";

contract StableCoin is ERC20 {
    DepositorCoin public depositorCoin;
    
    constructor() ERC20("StableCoin", "STC") {

    }
}