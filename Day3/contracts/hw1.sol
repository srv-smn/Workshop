/**
 *Submitted for verification at polygonscan.com on 2023-03-19
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import './Votingtoken.sol';

contract Voting {
    uint public liked;
    uint public disliked;
    mapping(address => bool) check;
    VotingToken vt; 

    modifier onlyOnce(){
        require(!check[msg.sender], "already voted");
        _;
    }

    constructor(address _vt) {
        vt = VotingToken(_vt);
    }

    function iLiked() public onlyOnce{
        liked = liked+1;
        check[msg.sender] = true;
        vt.mint(msg.sender,1 * 10 ** vt.decimals());
    }

    function idisLiked() public onlyOnce{
        disliked = disliked+1;
        check[msg.sender] = true;
        vt.mint(msg.sender,1 * 10 ** vt.decimals());

    }
}
