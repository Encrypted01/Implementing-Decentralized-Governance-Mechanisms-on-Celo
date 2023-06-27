contract SimpleMajorityVoting {
    mapping(address => bool) public votes;
    uint256 public yesVotes;
    uint256 public noVotes;
    bool public proposalPassed;
    bool public votingEnded;

    function vote(bool _supportsProposal) public {
        require(!votingEnded, "Voting has ended");
        require(!votes[msg.sender], "Already voted");

        votes[msg.sender] = true;

        if (_supportsProposal) {
            yesVotes++;
        } else {
            noVotes++;
        }

        checkProposalMajority();
    }

    function checkProposalMajority() internal {
        uint256 totalVotes = yesVotes + noVotes;

        // Check if the proposal has achieved a simple majority
        if (totalVotes >= 3 && yesVotes > noVotes) {
            proposalPassed = true;
        } else {
            proposalPassed = false;
        }
    }

    function endVoting() public {
        require(!votingEnded, "Voting has already ended");

        votingEnded = true;
    }
}
