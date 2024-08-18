//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract Owned {

    // owner: This state variable stores the address of the owner of the contract. 
    // It is an address type, which is a fundamental data type in Solidity used to store 
    // Ethereum addresses.

    address owner;

    // The constructor is a special function that is executed once when the contract is deployed.
    // msg.sender: This global variable represents the address of the entity (either an external 
    // account or another contract) that is deploying the contract.
    // In this case, the owner variable is set to the address of the entity that deploys the 
    // contract, effectively making that address the owner of the contract.

    constructor() {
        owner = msg.sender;
    }

    // A modifier in Solidity is a way to change the behavior of functions. It is a piece of code 
    // that can be applied to functions to enforce specific rules before the function's code 
    // is executed.
    // The onlyOwner modifier checks if the msg.sender (the address calling the function) is the 
    // same as the owner.
    // If the check fails (i.e., if msg.sender is not the owner), the function call will 
    // revert with the error message "You are not allowed."

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
}