// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Twitter{

    uint16 public MAX_TWEET_LENGTH = 280;

    address public owner;

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    // Owner is who deploy the contract
    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "You are Not the Owner.");
        _;
    }

    function changeTweetLength(uint16 _newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = _newTweetLength;
    }

    function createTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long Bro!");

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet(uint256 _index) public view returns (Tweet memory) {
        return tweets[msg.sender][_index];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory){
        return tweets[_owner];
    }
}
