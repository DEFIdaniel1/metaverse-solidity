// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

    /** 
    * @notice Contract for a basic metaverse that mints an initial supply of assets but can be changed
    * @notice Can increase supply of current items and add new items
    * @custom:security-contact security@mymetaverse.com
    */
contract DynamicMetaverse is ERC1155, Pausable, Ownable {
    // For on-chain tracking
    struct Item {
        string name;
        uint256 quantity;
    }
    mapping(uint256 => Item) public idToItem;
    uint256 public s_allItems = 0;    

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

    constructor() ERC1155("https://myMetaverse.com/itemURIs/{id}.json") {
        // Initial supply. Can be increased with mint function
        mint("GOLD", GOLD, 1000, "");
        mint("SILVER", SILVER, 10000, "");
        mint("LANCELOTS_SWORD", LANCELOTS_SWORD, 1, ""); 
        mint("COMMON_SWORD", COMMON_SWORD, 1000, ""); 
        mint("COMMON_SHIELD", COMMON_SHIELD, 1000, ""); 
        mint("MERLINS_STAFF", MERLINS_STAFF, 1, "");
        mint("BOOK_OF_NECROMANCY", BOOK_OF_NECROMANCY, 100, ""); 
        mint("HEALTH_POTION", HEALTH_POTION, 500, ""); 
        mint("MANA_POTION", MANA_POTION, 500, ""); 
        mint("RARE_AXE", RARE_AXE, 100, ""); 
        mint("RARE_BOW", RARE_BOW, 100, "");
    }

    /**
     * @dev Pausing the contract functionality. Cannot mint or transfer/batchTransfer
     * @dev Adjusted for only owner to mint and can only use when not paused
     */
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * @dev Mint new items or increase supply of current items
     * @dev Adjusted for only owner to mint and can only use when not paused
     */
    function mint(string memory itemName, uint256 id, uint256 amount, bytes memory data)
        public
        whenNotPaused
        onlyOwner
    {
        _mint(msg.sender, id, amount, data);

        Item memory newItem = Item(itemName, amount);
        idToItem[id] = newItem;
        s_allItems += 1;
    }
    /**
     * @dev Mint a batch of NFTs
     * @dev Adjusted for only owner to mint and can only use when not paused
     */
    function mintBatch(uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        whenNotPaused
        onlyOwner
    {
        _mintBatch(msg.sender, ids, amounts, data);
    }

    function _beforeTokenTransfer(
        address operator, 
        address from, 
        address to, 
        uint256[] memory ids, 
        uint256[] memory amounts, 
        bytes memory data
    )
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    /**
     * @dev Contract owner can update the base URI
     */
    function setURI(string memory newuri) public onlyOwner whenNotPaused {
        _setURI(newuri);
    }
}