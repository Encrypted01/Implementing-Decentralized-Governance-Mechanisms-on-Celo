uint256 public constant PROPOSAL_SUBMISSION_PERIOD = 7 days;
uint256 public constant VOTING_PERIOD = 3 days;

function submitProposal(string memory _description) public {
    require(block.timestamp % PROPOSAL_SUBMISSION_PERIOD < PROPOSAL_SUBMISSION_PERIOD / 2, "Submission period ended");

    // Rest of the code for submitting a proposal
}

function vote(uint256 _proposalId, bool _support) public {
    require(block.timestamp % VOTING_PERIOD < VOTING_PERIOD / 2, "Voting period ended");

    // Rest of the code for voting on a proposal
}
