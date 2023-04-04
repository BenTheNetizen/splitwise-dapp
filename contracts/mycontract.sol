// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
    // DO NOT MODIFY ABOVE THIS

    // ADD YOUR CONTRACT CODE BELOW
    

    address[] public users;
    mapping (address => mapping (address => uint32)) public debts;


    function lookup(address debtor, address creditor) public view returns (uint32 ret) {
        ret = debts[debtor][creditor];
    }

    function add_IOU(address creditor, uint32 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(creditor != msg.sender, "Creditor cannot be the same as debtor");
        addDebt(msg.sender, creditor, amount);
    }

    function addDebt(address debtor, address creditor, uint32 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(creditor != debtor, "Creditor cannot be the same as debtor");
        debts[debtor][creditor] += amount;
        addUser(debtor);
        addUser(creditor);
    }

    function subtractDebt(address debtor, address creditor, uint32 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        debts[debtor][creditor] -= amount;
    }

    function addUser(address user) private {
        for (uint i = 0; i < users.length; i++) {
            if (users[i] == user) {
                return;
            }
        }
        users.push(user);
    }

    function getUsers() public view returns (address[] memory ret) {
        ret = new address[](users.length);
        for (uint i = 0; i < users.length; i++) {
            ret[i] = users[i];
        }
    }
}
