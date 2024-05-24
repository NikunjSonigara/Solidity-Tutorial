// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint256 public candidatesCount;

    event votedEvent (
        uint256 indexed _candidateId
    );

    constructor() {
        addCandidate('A');
        addCandidate('B');
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint256 _candidateId) public {
        require(!voters[msg.sender], "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid Candidate Id");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        emit votedEvent(_candidateId);
    }

    function winner() public view returns (uint256, string memory, uint256) {
        uint256 winningVoteCount = 0;
        uint256 winningCandidateId = 0;

        for(uint256 i = 1; i <= candidatesCount; i++){
            if(candidates[i].voteCount > winningVoteCount){
                winningVoteCount = candidates[i].voteCount;
                winningCandidateId = candidates[i].id;
            }
        }

        Candidate memory winningCandidate = candidates[winningCandidateId];
        return (winningCandidate.id, winningCandidate.name, winningCandidate.voteCount);
    }
}


