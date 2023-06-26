pragma solidity ^0.8.0;

contract QuadraticVoting {
    struct Proposal {
        uint256 id;
        string description;
        uint256 totalTokens;
        mapping(address => uint256) votes;
    }

    Proposal[] public proposals;
    mapping(address => uint256) public tokenBalances;

    function submitProposal(string memory _description) public {
        uint256 proposalId = proposals.length;
        proposals.push(Proposal(proposalId, _description, 0));
    }

    function vote(uint256 _proposalId, uint256 _tokens) public {
        require(_proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];
        require(_tokens <= tokenBalances[msg.sender], "Insufficient tokens");

        proposal.votes[msg.sender] = _tokens;
        proposal.totalTokens += _tokens;
        tokenBalances[msg.sender] -= _tokens;
    }

    function calculateVotes(uint256 _proposalId) public view returns (uint256) {
        require(_proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];
        uint256 totalVotes = 0;

        for (uint256 i = 0; i < proposals.length; i++) {
            totalVotes += sqrt(proposal.votes[i]);
        }

        return totalVotes;
    }

    function sqrt(uint256 x) internal pure returns (uint256) {
        uint256 z = (x + 1) / 2;
        uint256 y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
        return y;
    }
}
