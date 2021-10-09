pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint public rate = 100;

    event TokenPurchase(
        address account,
        address token,
        uint amount,
        uint rate
    );

    constructor(Token _token) public {
        token = _token;
    }

    function buyTokens() public payable{
        // Amount of ethereum * redemption rate
        // Redemption rate = # of tokens received for 1 ether
        // Calculate the number of tokens to buy
        uint tokenAmount = msg.value * rate;
        token.transfer(msg.sender, tokenAmount);

        // check to ensure there are enough tokens in the exchange
        // TODO- test (not needed for now)
        require(token.balanceOf(address(this)) >= tokenAmount);

        // Emit an event
        emit TokenPurchase(msg.sender, address(token), tokenAmount, rate);
    }
}
