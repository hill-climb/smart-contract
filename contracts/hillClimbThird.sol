// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC721Drop.sol";
import "@thirdweb-dev/contracts/extension/Permissions.sol";

contract Contract is ERC721Drop, Permissions {
    // An array of notes.
    mapping(uint256 => string) public notes;

    constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps,
        address _primarySaleRecipient
    )
        ERC721Drop(
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps,
            _primarySaleRecipient
        )
    {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /**
     *  A function that allows writing notes to the owner of the NFT.
     */
    function writeNote(uint256 _tokenId, string memory _msg) public {
        require(
            msg.sender == ownerOf(_tokenId),
            "You are not the token owner."
        );
        notes[_tokenId] = _msg;
    }

    /**
     *  A function that allows notes update only to holders of the NFT that has the `DEFAULT_ADMIN_ROLE` permission.
     */
    function updateNote(
        uint256 _tokenId,
        string memory _msg
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        notes[_tokenId] = _msg;
    }
}
