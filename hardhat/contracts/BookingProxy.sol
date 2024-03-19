// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";



contract BookingProxy is Initializable {
    


    // Address of the current BookingLogic contract implementation
    uint256 public logicContract;


    function initialize(uint256 _logicContract) public initializer {
    
        logicContract = _logicContract;
    }


    // Function to upgrade the BookingLogic contract implementation
    function upgradeTo(uint256 newLogicContract) public {
        
        logicContract = newLogicContract;
    }

    // Override for UUPSUpgradeable authorization (optional)
    // Not for hardhat
    // function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    // Receive ether function to handle incoming ether
    receive() external payable {}
}