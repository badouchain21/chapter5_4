pragma solidity ^0.4.19;

contract  AnimalIncubators{
 
    uint dnaDigits = 16;   //宠物DNA位数
    uint dnaLength = 10**dnaDigits;
    
    struct Animal{
        
        string name;
        uint dna;
        
    }
    
    Animal [] public animals;
    
  
    //  孵化宠物函数 
    function hatchAnimal(string name,uint dna) public{
        animals.push(Animal(name,dna));
        
    }
    
    event NewAnimal(uint AnimalId,string name,uint dna);
    
    function _createAnimal(string _name,uint _dna) internal{
        uint animalId = animals.push(Animal(_name,_dna))-1;
        NewAnimal(animalId, _name, _dna);
    }
    
    function _generateRandomDna(string _str) private view returns(uint){
        uint rand = uint(keccak256(_str));
        return rand % dnaLength;
    }
    
    function createRandomAnimal(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createAnimal(_name, randDna);
    }
    
     
}
