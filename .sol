pragma solidity ^0.8.0;

contract Governance {
    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;

    function submitProposal(string memory _description) public {
        uint256 proposalId = proposals.length;
        proposals.push(Proposal(proposalId, msg.sender, _description, 0, 0, false));
    }

    function vote(uint256 _proposalId, bool _support) public {
        require(!hasVoted[msg.sender], "Already voted");
        require(_proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];
        hasVoted[msg.sender] = true;

        if (_support) {
            proposal.votesFor++;
        } else {
            proposal.votesAgainst++;
        }
    }

    function executeProposal(uint256 _proposalId) public {
        require(_proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];
        require(proposal.votesFor > proposal.votesAgainst, "Proposal rejected");

        proposal.executed = true;
        // Execute the proposal actions
    }
}
