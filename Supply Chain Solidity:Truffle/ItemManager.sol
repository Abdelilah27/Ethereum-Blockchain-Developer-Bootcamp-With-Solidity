pragma solidity ^0.8.4;
import "./Ownable.sol";
import "./Item.sol";

contract ItemManager is Ownable{

    uint item_index;
    mapping(uint=>S_item) items;

    enum item_State{Created, Paid, Delivered}

    struct S_item{
        Item item;
        string identify;
        uint price;
        ItemManager.item_State state;
    }

    event SupplyStep(uint _item_index, uint _step, address _item_address);
    

    function createItem(string memory _identify, uint _price) public onlyOwner{
        Item item = new Item(item_index, _price, this);
        items[item_index].item = item;
        items[item_index].identify = _identify;
        items[item_index].price = _price;
        items[item_index].state = item_State.Created;
        emit SupplyStep(item_index, uint(items[item_index].state), address(item));
        item_index++;
    }


    function triggerPayment(uint _item_index) public payable{
        require(items[_item_index].price == msg.value, "Only FULL Payment");
        require(items[_item_index].state == item_State.Created, "Not in Stock");
        items[_item_index].state = item_State.Paid;
        emit SupplyStep(_item_index, uint(items[_item_index].state), address( items[_item_index].item));
    }

    function triggerDelivery(uint _item_index) public onlyOwner{
        require(items[_item_index].state == item_State.Paid, "Not PAID");
        items[_item_index].state = item_State.Delivered;
        emit SupplyStep(_item_index, uint(items[_item_index].state), address( items[_item_index].item));
    }



}