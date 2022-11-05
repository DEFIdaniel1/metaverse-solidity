// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

error MyMetaverse__AccountIdArrayMismatch();

    /** 
    * @notice Contract for a basic metaverse with fixed values and limited contract functionality
    * @notice Use-cases best for an economy with fixed values and unchangeable assets amounts
    */
contract MyMetaverse is ERC1155 {
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

// Fixed asset value contract. Non-mintable
    constructor() ERC1155("https://game.example/api/item/{id}.json") {
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
            revert MyMetaverse__AccountIdArrayMismatch();
        }

        uint256[] memory batchBalances = new uint256[](playerAccounts.length);

        for (uint256 i = 0; i < playerAccounts.length; ++i) {
            batchBalances[i] = balanceOf(playerAccounts[i], itemIds[i]);
        }

        return batchBalances;
    }
}