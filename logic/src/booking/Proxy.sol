// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BookingProxy is Initializable, OwnableUpgradeable, UUPSUpgradeable {

    // Address of the current BookingLogic contract implementation
    address public logicContract;

    constructor() {
        _disableInitializers();
    }

    function initialize(address _logicContract) public initializer {
        // __Ownable_init();
        __UUPSUpgradeable_init();
        logicContract = _logicContract;
    }


    // Function to upgrade the BookingLogic contract implementation
    function upgradeTo(address newLogicContract) public onlyOwner {
        _authorizeUpgrade(newLogicContract);
        logicContract = newLogicContract;
    }

    // Override for UUPSUpgradeable authorization (optional)
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    // Receive ether function to handle incoming ether
    receive() external payable {}
}