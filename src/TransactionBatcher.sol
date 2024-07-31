// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;
pragma experimental ABIEncoderV2;

import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

contract TransactionBatcher is Ownable {
    function batchSend(address[] memory targets, uint[] memory values, bytes[] memory datas) public payable onlyOwner {
        for (uint i = 0; i < targets.length; i++) {
            (bool success,) = targets[i].call{value: values[i]}(datas[i]);
            if (!success) revert('transaction failed');
        }
    }
}
