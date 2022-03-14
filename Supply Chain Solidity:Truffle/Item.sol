pragma solidity ^0.8.4;

import "./ItemManager.sol";

contract Item{
    uint index;
    uint priceInWei;
    uint pricePaid;
    ItemManager itemManager;


    constructor(uint _index, uint _price, ItemManager _itemManager) public {
        index = _index;
        priceInWei = _price;
        itemManager = _itemManager;
    }

    receive() external payable {
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value);
        pricePaid += msg.value;
        (bool succes, ) = address(itemManager).call{value: msg.value}(abi.encodeWithSignature("triggerPayment(uint256)",index));
        require(succes, "Transaction was't successful");
    }

    fallback() external {}

}