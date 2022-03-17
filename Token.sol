// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IfeToken is ERC20, Ownable {
    uint token_per_ETH = 1000 * 10 ** decimals();
    event Buy (address buyer, uint amount);
    constructor() ERC20("IfeToken", "IFT") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function buyTokens () payable public returns (uint token_amount) {
        require (msg.value > 0, "You need to enter a valid number of tokens");
        uint amount_of_token = msg.value * token_per_ETH;
        mint(msg.sender, amount_of_token);
        emit Buy (msg.sender, amount_of_token);
        return amount_of_token;
    }
}
