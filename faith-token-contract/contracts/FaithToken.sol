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
     uint8 private decimals_;

    /// @dev error to emit when zero address is provided
     error ZeroAddrException();

    /**
     * @dev error describing insufficient balance
     * @param _balance balance of the account
     * @param _requestedAmount amount requested
     */
     error InsufficientBalance(uint _balance, uint _requestedAmount);

    /**
     * @dev checks to see that provided address is not 0x00
     * @param _addr address provided to the function
     */
     modifier isNotZeroAddr(address _addr) {
         if(_addr == address(0)) revert ZeroAddrException();
         _;
     }

    /**
     * @dev checks for enough balance before transfer
     * @param _addr address of the entity requesting a transfer
     * @param _requestedAmount amount to be transferred from _addr balance
     */
     modifier hasEnoughBalance(address _addr, uint _requestedAmount) {
         uint bal = balances_[_addr];
         if (bal < _requestedAmount) revert InsufficientBalance(bal, _requestedAmount);
         _;
     }

     constructor(
         string memory _name, 
         string memory _symbol, 
         uint8 _decimals,  
         uint _initialOwnerBal) {
         name_ = _name;
         symbol_ = _symbol;
         decimals_ = _decimals;
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

    /**
     @notice returns the number of decimal places of the token (e.g 5 means .xxxxxx)
     @dev returns the token decimals
     @return decimals of the token 
     */
     function decimals() public view returns (uint8) {
         return decimals_;
     }

     function allowance(address _owner, address _spender) 
        public view isNotZeroAddr(_owner) isNotZeroAddr(_spender) returns (uint allowances) {
            allowances = allowances_[_owner][_spender];
        }

    /**
     * @notice transfer the token to the address provided
     * @dev transfer _value to _to address
     * @param _to address to be transferred to
     * @param _value amount to be transferred
     * @return success status of the transfer operation
     */
     function transfer(address _to, uint _value) public returns (bool) {
        return _transfer(msg.sender, _to, _value);
     }

    /**
     * @notice transfer the token to the address provided
     * @dev transfer _value to _to address
     * @param _from address of the source account
     * @param _to address to be transferred to
     * @param _value amount to be transferred
     * @return success status of the transfer operation
     */
     function transferFrom(address _from, address _to, uint _value) public returns (bool) {
        // ensure the amount to be transferred is exactly or below the approved allowance
        require(_value <= allowances_[_from][msg.sender]); 
        return _transfer(_from, _to, _value);
     }

    /**
     * @notice transfer the token to the address provided
     * @dev transfer _value to _to address
     * @param _from address of the source account
     * @param _to address to be transferred to
     * @param _value amount to be transferred
     * @return success status of the transfer operation
     */
     function _transfer(address _from, address _to, uint _value) private
        isNotZeroAddr(_from) isNotZeroAddr(_to) hasEnoughBalance(_from, _value) returns (bool success) {
            balances_[_from] -= _value;
            balances_[_to] += _value;
            success = true;
            emit Transfer(_from, _to, _value); // emit event
     }

    /**
     * @dev this function allocates specific allowance to spender from owner's balance
     * @param _spender address of the spender
     * @param _value amount to be allocated
     * @return success status [bool]
     */
     function approve(address _spender, uint _value) public returns (bool) {
         return _approve(msg.sender, _spender, _value);
     }

    /**
     * @dev this function allocates specific allowance to spender from owner's balance
     * @param _owner address of the owner
     * @param _spender address of the spender
     * @param _value amount to be allocated
     * @return success status [bool]
     */
     function _approve(address _owner, address _spender, uint _value) 
        private isNotZeroAddr(_owner) isNotZeroAddr(_spender) returns (bool success) {
            allowances_[_owner][_spender] = _value;
            success = true;
            emit Approval(_owner, _spender, _value);
     }

    /**
     * @dev add _value to the given _acct 
     * and emit necessary event but with a 0x00 address as the source
     * @param _acct address whose balance is to be increased by _value
     * @param _value amount to be added
     * @return success status of the minting
     */
     function _mint(address _acct, uint _value) internal isNotZeroAddr(_acct) returns (bool success) {
        totalSupply_ += _value;
        balances_[_acct] += _value;
        success = true;
        emit Transfer(address(0), _acct, _value); // emit event
     }

    /**
     * @dev deduct _value from the given _acct
     * @param _acct address of the balance to be deducted
     * @param _value amount to be deducted from _acct
     * @return success status of the minting
     */
     function _burn(address _acct, uint _value) internal isNotZeroAddr(_acct) returns (bool success) {
         totalSupply_ -= _value;
         balances_[_acct] -= _value;
         success = true;
         emit Transfer(_acct, address(0), _value); // emit event
     }
 }