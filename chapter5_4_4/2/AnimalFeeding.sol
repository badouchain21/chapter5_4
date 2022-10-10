pragma solidity ^0.4.19;
import "./AnimalIncubatorsV2.sol";

contract  AnimalFeeding is AnimalIncubatorsV2{
    
     //  实现进食功能    宠物   食物DNA 
    function feedAndGrow(uint _AnimalId,uint _targetDna)public {
        // 确保当前的宠物是自己的  
        require(msg.sender == AnimalToOwner[_AnimalId]);
        //  获取这个宠物的DNA
        Animal storage myAnimal = animals[_AnimalId];
        
         _targetDna = _targetDna % dnaLength;
         uint newDna = (myAnimal.dna + _targetDna) / 2;
         newDna = newDna - newDna % 100 + 99;
         _createAnimal("No-one", newDna);
    }
    
    function _catchFood(uint _name) internal pure returns (uint){
        uint rand = uint(keccak256(_name));
        return rand;
    }
    
    function feedOnFood(uint _AnimalId,uint _FoodId) public{
        uint foodDna = _catchFood(_FoodId);
        feedAndGrow(_AnimalId,foodDna);
    }
    
}
