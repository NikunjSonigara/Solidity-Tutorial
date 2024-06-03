// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auth{
    struct User{
        uint256 id;
        string email;
        string password; 
    }

    mapping(address => User) private users;
    uint256 private nextId = 1;

    event UserRegistered(address indexed userAddress, uint256 userId);
    event UserAuthenticated(address indexed userAddress, uint256 userId);

    function register(string memory _email, string memory _password) public {
        require(bytes(users[msg.sender].email).length == 0, "User Already Registered.");
        users[msg.sender] = User(nextId, _email, _password);
        emit UserRegistered(msg.sender, nextId);
        nextId++;
    }

    function authenticate(string memory _email, string memory _password) public returns (bool) {
        User memory user = users[msg.sender];
        if(keccak256(abi.encodePacked(user.email)) == keccak256(abi.encodePacked(_email)) && keccak256(abi.encodePacked(user.password)) == keccak256(abi.encodePacked(_password))){
            emit UserAuthenticated(msg.sender, user.id);
            return true;
        }
        return false;
    }

    function getUser(address _userAddress) public view returns (User memory) {
        return users[_userAddress];
    }
}
