//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

// Imports and inherits from an Ownable

import "./Ownable.sol";

// Provides basic functionality for a token economy where tokens can be minted, burned, bought, 
// and transferred between users

contract Token is Owned {

    // tokenBalance: A mapping that tracks the balance of tokens for each address.
    // tokenPrice: The price of one token, set to 1 ether.

    mapping(address => uint) public tokenBalance;

    uint tokenPrice = 1 ether;

    // The constructor initializes the contract, setting the owner's token balance to 100 tokens.

    constructor() {
        tokenBalance[owner] = 100;
    }

    // This function allows the owner to create (mint) new tokens. Each time it's called, 
    // one token is added to the owner's balance.

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    // This function allows the owner to destroy (burn) tokens, reducing the total supply 
    // by one each time it's called.

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

    // This function allows anyone to purchase tokens from the owner. The amount of ether sent 
    // in the transaction (msg.value) is used to calculate how many tokens the sender will receive.
    // The require statement ensures that there are enough tokens available for purchase.
    // The owner's token balance is decreased, and the buyer's token balance is increased based 
    // on the ether sent.

    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    // This function allows a user to send tokens to another address.
    // The require statement ensures the sender has enough tokens to transfer.
    // The assert statements are used to check for integer overflow or underflow, ensuring the 
    // transaction is valid.
    // The sender's token balance is decreased, and the recipient's balance is increased by the 
    // specified amount.

    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }

}