// SPDX-License-Identifier: MIT
pragma solidity =0.8.15;

contract Payments {
    

    // @dev create a person: who want to donate in DAO(charity)
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    // @dev create user's payment
    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    // @dev database users = charitiers
    mapping(address => Balance) public balances;

    // @dev total value our treasury
    function currentBalance() public view returns(uint) {
        return address(this).balance;
    }

    // @dev information about user's payment 
    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }

    // @dev pay in charity
    function pay(string memory message) public payable {
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNum] = newPayment;
    }
}
