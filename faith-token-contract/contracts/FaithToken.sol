// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./ERC20Interface.sol";

/**
 * @title Faith ERC20 Token contract
 * @author Bytangle
 * @dev This is an experimental token
 */
 contract FaithToken is ERC20Interface {

     mapping(address => uint) private balances_;
     mapping(address => mapping(address => uint)) private allowances_;
     uint private totalSupply_;
     string private name_;
     string private symbol_;

     constructor(string memory _name, string memory _symbol, uint _initialOwnerBal) {
         name_ = _name;
         symbol_ = _symbol;
         balances_[msg.sender] = _initialOwnerBal;
     }

     function name() public view returns (string memory) {
         return name_;
     }

     function symbol() public view returns (string memory) {
         return symbol_;
     }
 }