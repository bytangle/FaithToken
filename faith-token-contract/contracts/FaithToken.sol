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
     uint private decimals_;

     constructor(
         string memory _name, 
         string memory _symbol, 
         uint _decimals,  
         uint _initialOwnerBal) {
         name_ = _name;
         symbol_ = _symbol;
         balances_[msg.sender] = _initialOwnerBal;
     }

    /**
     * @notice returns the name of the token
     * @dev getter function for name property
     * @return name of the the token [string]
     */
     function name() public view returns (string memory) {
         return name_;
     }

    /**
     * @notice returns the token symbol
     * @dev getter function for symbol property
     * @return symbol of token [string]
     */
     function symbol() public view returns (string memory) {
         return symbol_;
     }

    /**
     * @notice returns total token supply
     * @dev getter function for totalSupply property
     * @return total supply of token
     */
     function totalSupply() public view returns (uint) {
         return totalSupply_;
     }

    /**
     * @dev returns the balance stored using the provided address
     * @notice returns the balance of the owner using the provided address
     * @param _owner address to be used to lookup the balance
     * @return balance retrieved using the provided address
     */
     function balanceOf(address _owner) public view returns (uint) {
         return balances_[_owner];
     }
 }