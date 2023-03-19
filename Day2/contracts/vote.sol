`
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Voting {
    uint public liked;
    uint public disliked;
    mapping(address => bool) check;

    modifier onlyOnce(){
        require(!check[msg.sender], "already voted");
        _;
    }

    function iLiked() public onlyOnce{
        liked = liked+1;
        check[msg.sender] = true;
    }

    function idisLiked() public onlyOnce{
        disliked = disliked+1;
        check[msg.sender] = true;
    }
}
`
