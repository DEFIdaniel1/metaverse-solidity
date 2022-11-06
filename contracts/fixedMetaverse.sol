// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

error FixedMetaverse__AccountIdArrayMismatch();

    /** 
    * @notice Contract for a basic metaverse with fixed values and limited contract functionality
    * @notice Use-cases best for an economy with fixed values and unchangeable assets amounts
    */
contract FixedMetaverse is ERC1155 {
    /** 
    * @dev uint values for itemIds
    */
    uint256 public constant GOLD = 0;
    uint256 public constant SILVER = 1;

    // Weapons
    uint256 public constant LANCELOTS_SWORD = 2;
    uint256 public constant COMMON_SWORD = 3;
    uint256 public constant COMMON_SHIELD = 4;

    // Magic Items
    uint256 public constant MERLINS_STAFF = 5;
    uint256 public constant BOOK_OF_NECROMANCY = 6;

    // Consumables
    uint256 public constant HEALTH_POTION = 7;
    uint256 public constant MANA_POTION = 8;

    // Rare Weapons
    uint256 public constant RARE_AXE = 9;
    uint256 public constant RARE_BOW = 10;

    ///////////////
    // Mappings ///
    //////////////
    mapping (uint256 => string) private s_tokenToURI; 

// Fixed asset value contract. Non-mintable
    constructor(string memory _tokenURIs) ERC1155(_tokenURIs) {
        _mint(msg.sender, GOLD, 1*1e9, ""); // 1,000,000,000
        _mint(msg.sender, SILVER, 10*1e9, ""); // 10,000,000,000
        _mint(msg.sender, LANCELOTS_SWORD, 1, ""); // 1
        _mint(msg.sender, COMMON_SWORD, 1*1e6, ""); // 1,000,000
        _mint(msg.sender, COMMON_SHIELD, 1*1e6, ""); // 1,000,000
        _mint(msg.sender, MERLINS_STAFF, 1, "");  // 1
        _mint(msg.sender, BOOK_OF_NECROMANCY, 10000, ""); // 10,000
        _mint(msg.sender, HEALTH_POTION, 1*1e6, ""); // 1,000,000
        _mint(msg.sender, MANA_POTION, 1*1e6, ""); // 1,000,000
        _mint(msg.sender, RARE_AXE, 1*1e5, ""); // 100,000
        _mint(msg.sender, RARE_BOW, 1*1e5, ""); // 100,000
    }


    ///////////////
    // Functions ///
    //////////////
    /** 
    * @dev get batch balances for multiple items/accounts, array values must match
    * @param playerAccounts is an array of owner accounts be wrapped in ""
    * @param itemIds is an array of tokenIds
    */
    function balanceOfBatch(address[] memory playerAccounts, uint256[] memory itemIds)
        public
        view
        override
        returns (uint256[] memory)
    {
        if(playerAccounts.length != itemIds.length){
            revert FixedMetaverse__AccountIdArrayMismatch();
        }

        uint256[] memory batchBalances = new uint256[](playerAccounts.length);

        for (uint256 i = 0; i < playerAccounts.length; ++i) {
            batchBalances[i] = balanceOf(playerAccounts[i], itemIds[i]);
        }

        return batchBalances;
    }

/**
 *  @notice BELOW are 2 methods for setting the URI for each token different to the method above.abi
    Method above requires the front-end to parse the string and replace {id} appropriately. 
    Above method is more gas efficient. Below are alternative methods to each uri.
 */
    /** 
    * @dev URI will follow the template below of link/tokenId.json
    * overrides the constructor URI
    */
    // function uri(uint256 tokenId) override public pure returns (string memory) {
    //     return string(abi.encodePacked(string.concat("http://link/", Strings.toString(tokenId), ".json")));
    // }

    /** 
    * @dev alternative URI retrieval method, uses mapping from tokenId => uri 
    * must also use the setTokenUri function to set the proper URI for each token
    */
    // function uri2(uint256 _tokenId) public view override returns (string memory) {
    //     return s_tokenToURI[_tokenId];
    // }
    // function setTokenUri(uint256 _tokenId, string memory _uri) public onlyOwner {
    //     s_tokenToURI[_tokenId] = _uri;
    // }
}