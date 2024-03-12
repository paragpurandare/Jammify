pragma solidity ^0.8.0;
import "@opcd ..enzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
contract MyTokenV1 is ERC20Upgradeable {
    function initialize(string memory name, string memory symbol) external initializer {
        __ERC20_init(name, symbol);
        _mint(msg.sender, 1000000 * 10**decimals());
    }
}