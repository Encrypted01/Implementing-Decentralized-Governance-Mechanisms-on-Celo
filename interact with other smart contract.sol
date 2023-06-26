pragma solidity ^0.8.0;

import "@celo/contractkit/contracts/registry/AddressResolver.sol";

contract Governance is AddressResolver {
    // ... Rest of the contract code

    function interactWithContract(address _contractAddress) public {
        IERC20 token = IERC20(getAddressFor(CeloContract.ERC20));
        // Perform interactions with the ERC20 contract
    }
}
