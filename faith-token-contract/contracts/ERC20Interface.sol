// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

/**
 * @title ERC20Interface
 * @dev the doc can be found here: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
 * @notice This interface is used to implement the FAITH ERC20 Token
 */
interface ERC20Interface {
    /// @return name of the TOKEN [string]
    function name() external view returns (string memory);

    /// @return symbol of token [string]
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the number of decimals the token uses 
     * - e.g. 8, means to divide the token amount by 100000000 to get its user representation
     * @return decimals in uint8
     */
    function decimals() external view returns (uint8);

    /**
     * @dev returns total token supply
     * @return total token supply in uint
     */
    function totalSupply() external view returns (uint);

    /**
     * @dev Returns the account balance of another account with address _owner
     * @param _owner the address of the entity whose balance is to be retrieved
     * @return balance in uint retrieved using the owner's address
     */
    function balanceOf(address _owner) external view returns (uint balance);

    /**
     * @dev Transfers _value amount of tokens to address _to, and MUST fire the Transfer event
     * @param _to address of the account to be transferred
     * @param _value amount to be transferred to _to address
     * @return success of the transfer operation
     */
    function transfer(address _to, uint _value) external returns (bool success);

    /**
     * @dev Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.
     * @param _from address of the source account
     * @param _to address of the destination account
     * @return success of the transfer operation (true/false)
     */
    function transferFrom(address _from, address _to, uint _value) external returns (bool success);

    /**
     * @dev Allows _spender to withdraw from your account multiple times, up to the _value amount
     * @param _spender address of the spender
     * @param _value value to be able to spend from entity balance
     * @return success status of the approval operation 
     */
    function approve(address _spender, uint _value) external returns (bool success);

    /**
     * @dev Returns the amount which _spender is still allowed to withdraw from _owner
     * @param _owner address of the balance owner
     * @param _spender address of the spender
     * @return remaining balance that can be spent by _spender from _owner balance
     */
    function allowance(address _owner, address _spender) external returns (uint remaining);

    /**
     * @dev event that MUST trigger when tokens are transferred, including zero value transfers.
     * @param _from address of source account
     * @param _to address of destination account
     * @param _value amount transferred
     */
    event Transfer(address indexed _from, address indexed _to, uint _value);

    /**
     * @dev event that must trigger when approve function is called
     * @param _owner address of owner
     * @param _spender address of spender
     * @param _value amount approved to be spent by _spender
     */
    event Approval(address indexed _owner, address indexed _spender, uint _value);

}