pragma solidity ^0.8.20;
import "@openzeppelin/upgrades-core/contracts/";
contract MyTokenV1 is ERC20Upgradeable {
    function initialize(string memory name, string memory symbol) external initializer {
        __ERC20_init(name, symbol);
        _mint(msg.sender, 1000000 * 10**decimals());
    }
}