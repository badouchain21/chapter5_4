pragma solidity ^0.4.19;

import "./AnimalHelper.sol";

contract AnimalAttack is AnimalHelper {

	uint randNonce = 0;
   
   function randMod(uint _modulus) internal returns(uint){
       randNonce++;
       return uint(keccak256(now,msg.sender,randNonce)) % _modulus;
   }
    
// 这个方法首先拿到 now 的时间戳、 msg.sender、 以及一个自增数 nonce （一个仅会被使用一次的数，这样我们就不会对相同的输入值调用一次以上哈希函数了）。

// 然后利用 keccak 把输入的值转变为一个哈希值, 再将哈希值转换为 uint, 然后利用 % 100 来取最后两位, 就生成了一个0到100之间随机数了。
 uint attackVictoryProbability = 75;
  function attack(uint _AnimalId,uint _targetId) external ownerOf(_AnimalId){
         Animal storage myAnimal = animals[_AnimalId];
         Animal storage enemyAnimal = animals[_targetId];
         uint rand = randMod(100);
		 //如果你是战斗发起方（先手），你将有 75%的几率获胜，防守方将有 25%的几率获胜。
         if(rand <= attackVictoryProbability){
			  //每一只宠物（攻守双方）都会有一个 winCount 和一个 lossCount，用来记录该宠物的战斗结果
              //若发起方获胜，这只宠物的 ATK 将增加。
			  myAnimal.winCount++;
              myAnimal.level++;
              enemyAnimal.lossCount++;
			  //无论输赢，当前宠物的战斗冷却时间都将被重置（很显然，饿了嘛）
                require(_isReady(myAnimal));
               _triggerCooldown(myAnimal);
         }else{
			  //如果攻击方失败，除了失败次数将加一外，什么都不会发生。
              myAnimal.lossCount++;
              enemyAnimal.winCount++;
			  //无论输赢，当前宠物的战斗冷却时间都将被重置（很显然，饿了嘛）
                require(_isReady(myAnimal));
              _triggerCooldown(myAnimal);
         }
    
    }

}
