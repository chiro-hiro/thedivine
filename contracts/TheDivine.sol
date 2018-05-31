pragma solidity ^0.4.23;

contract TheDivine{

    /* Randomness chain */
    mapping (uint256 => bytes32) internal immotal;

    /* Address nonce */
    mapping (address => uint256) internal nonce;

    /* Total number of randomness in the chain */
    uint256 internal total;

    /* Complex of digest compute */
    uint256 internal constant complex = 12;
       
    /**
    * Construct function
    */
    constructor() public {
        immotal[total++] = keccak256(abi.encode(this));
        immotal[total++] = keccak256(abi.encode(immotal[0]));
    }
    

    /**
    * Get result from PRNG
    */
    function rand() public returns(bytes32){
        uint256 previous = uint256(keccak256(abi.encode(immotal[total-1])));
        uint256 pickUp = (previous >> 128) ^ (previous << 128);
        uint256 thePast = uint256(immotal[pickUp % total]);
        uint256 shift = pickUp % 256;
        bytes32 temporary;
        
        // Rotate previous value by shift operator
        previous = (previous >> shift) | (previous << (256 - shift));

        // Reverse rotate thePast value by shift operator
        thePast = (thePast >> (256 - shift)) | (thePast << shift);
        
        // Calculate digest by complex times
        temporary = keccak256(abi.encode(temporary, thePast, previous - thePast, total, nonce[msg.sender]));

        //Increase caller nonce
        nonce[msg.sender]++;

        for(uint256 c = 0; c < complex; c++){
            temporary = keccak256(abi.encode(temporary));
        }

        // Append number to the chain
        immotal[total] = temporary;
        total++;

        // Return last number of the chain
        return temporary;
    }

    /**
    * No Ethereum will be trapped
    */
    function () public payable {
        revert();
    }

}
