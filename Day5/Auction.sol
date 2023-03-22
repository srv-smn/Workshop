// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


interface IERC721 {
    function safeTransferFrom(address from, address to, uint tokenId) external;

    function transferFrom(address, address, uint) external;
}

contract realstate {
    constructor() {
        // erc20 address
        //erc721 address
        //nft id
        // highest bid
        // seller

    }

    function start() external {
        // endtime
        // transfer NFT
        // start ?
    }

    function bid(uint _amount) external {
        // highest bidder
        // erc20 transfer
    }

    function withdraw() external {
        // token transer to user
    }

    function end() external {
        // highest bidder - erc721 transfer 
    }
}
