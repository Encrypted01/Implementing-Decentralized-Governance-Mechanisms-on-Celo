pragma solidity ^0.8.0;

contract QuadraticFunding {
    struct Proposal {
        uint256 id;
        string description;
        uint256 totalDonations;
        mapping(address => uint256) donations;
    }

    Proposal[] public proposals;
    mapping(address => uint256) public matchingPool;

    function submitProposal(string memory _description) public {
        uint256 proposalId = proposals.length;
        proposals.push(Proposal(proposalId, _description, 0));
    }

    function donate(uint256 _proposalId, uint256 _amount) public {
        require(_proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];

        proposal.donations[msg.sender] += _amount;
        proposal.totalDonations += _amount;
        matchingPool[msg.sender] += (_amount * _amount);
    }

    function calculateMatch(uint256 _proposalId, address _donor) public view returns (uint256) {
        require(_proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];
        uint256 matchingAmount = matchingPool[_donor] / proposal.totalDonations;

        return sqrt(proposal.donations[_donor]) * matchingAmount;
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
