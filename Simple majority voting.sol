function executeProposal(uint256 _proposalId) public {
    require(_proposalId < proposals.length, "Invalid proposal ID");

    Proposal storage proposal = proposals[_proposalId];
    require(proposal.votesFor > proposal.votesAgainst, "Proposal rejected");

    proposal.executed = true;
    // Execute the proposal actions
}
