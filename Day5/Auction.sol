// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IERC721 {
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function transferFrom(
        address,
        address,
        uint256
    ) external;
}

contract realstate {
    IERC20 erc20;
    IERC721 erc721;
    uint256 nftid;
    uint256 highestbid;
    address seller;
    bool started;
    address highestBidder;
    uint256 endtime;
    mapping(address => uint256) public bids;

    constructor(
        address _erc20,
        address _erc721,
        uint256 _nftid,
        uint256 _highestBid
    ) {
        // erc20 address

        erc20 = IERC20(_erc20);

        //erc721 address
        erc721 = IERC721(_erc721);
        //nft id
        nftid = _nftid;
        // highest bid
        highestbid = _highestBid;
        // seller
        seller = msg.sender;
    }

    function start() external {
        require(!started, "alreadstarted");
        require(msg.sender == seller, "You are not seller.");
        erc721.transferFrom(msg.sender, address(this), nftid);
        started = true;
        endtime = block.timestamp + 900;

        // endtime
        // transfer NFT
        // start ?
    }

    function bid(uint256 _amount) external {
        //start or not
        require(started, "not started");
        require(block.timestamp < endtime, "ended");
        if (highestBidder != address(0)) {
            bids[highestBidder] += highestbid;
        }

        // highest bidder
        require(_amount > highestbid, "you cannot bid");
        highestbid = _amount;

        highestBidder = msg.sender;
        // erc20 transfer
        erc20.transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw() external {
        // token transer to user
        
        uint256 bal = bids[msg.sender];
        bids[msg.sender] = 0;
        erc20.transfer(msg.sender, bal);
    }

    function end() external {
        // highest bidder - erc721 transfer
        require(block.timestamp > endtime, "not ended");
        if (highestBidder != address(0)) {
            erc721.safeTransferFrom(address(this), highestBidder, nftid);
            erc20.transfer(seller, highestbid);
        } else {
            erc721.safeTransferFrom(address(this), seller, nftid);
        }
    }
}
