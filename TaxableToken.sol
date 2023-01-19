pragma solidity ^0.8.0;

contract TaxableToken {
    mapping(address => uint) public balances;
    uint public totalSupply;
    address public owner;

    event Transfer(address indexed from, address indexed to, uint value);
    event TaxCollected(address indexed from, uint value);

    constructor() public {
        owner = msg.sender;
        totalSupply = 1000000;
        balances[msg.sender] = totalSupply;
    }

    function transfer(address to, uint value) public {
        require(balances[msg.sender] >= value && value > 0);

        uint tax = value * 0.1; // 10% tax
        require(balances[msg.sender] >= value + tax);

        balances[msg.sender] -= value + tax;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        emit TaxCollected(msg.sender, tax);

        owner.transfer(tax);
    }

    function balanceOf(address account) public view returns (uint) {
        return balances[account];
    }
}
