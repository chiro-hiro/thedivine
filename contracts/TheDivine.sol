pragma solidity ^0.4.24;


contract TheDivine{

    /* Randomness value */
    bytes32 immotal;

    /* Address nonce */
    mapping (address => uint256) internal nonce;

    /* Complex of digest compute */
    uint256 internal constant complex = 10;
       
    /**
    * Construct function
    */
    constructor() public {
        immotal = keccak256(abi.encode(this));
    }
    
    /**
    * Get result from PRNG
    */
    function rand() public returns(bytes32 result){
        result = keccak256(abi.encode(immotal, nonce[msg.sender]++));
        // Calculate digest by complex times
        for(uint256 c = 0; c < complex; c++){
            result = keccak256(abi.encode(result));
        }
        //Update new immotal result
        immotal = result;
        return;
    }

    /**
    * No Ethereum will be trapped
    */
    function () public payable {
        revert();
    }

}