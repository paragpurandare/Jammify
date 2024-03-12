// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BookingProxy} from "../src/booking/Proxy.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployContractA is Script {
    function run() external returns (address) {
        address proxy = deployContractA();
        return proxy;
    }

    function deployContractA() public returns (address) {
        vm.startBroadcast();
        BookingProxy ContractA = new BookingProxy(); //Our implementation(logic).Proxy will point here to delegate call/borrow the functions
        ERC1967Proxy proxy = new ERC1967Proxy(address(ContractA), "");
        vm.stopBroadcast();
        return address(proxy);
    }
}