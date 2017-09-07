pragma solidity ^0.4.11;

contract TheDivine{

    /* Randomness chain */
    mapping (uint => bytes32) public Immotal;

    /* Address nonce */
    mapping (address => uint) public Nonce;

    /* Total number of randomness in the chain */
    uint public Total;

    /* Complex of digest compute */
    uint constant Complex = 99;
       
    /**
    * Construct function
    */
    function TheDivine(){
        Immotal[Total++] = sha3(this);
        Immotal[Total++] = sha3(Immotal[0]);
    }
    

    /**
    * Get result from PRNG
    */
    function GetPower() public returns(bytes32){
        uint Previous = uint(sha3(Immotal[Total-1]));
        uint PickUp = (Previous >> 128) ^ (Previous << 128);
        uint ThePast = uint(Immotal[PickUp % Total]);
        uint Shift = PickUp % 256;
        bytes32 Temporary;
        
        // Rotate previous value by shift operator
        Previous = (Previous >> Shift) | (Previous << (256 - Shift));

        // Reverse rotate ThePast value by shift operator
        ThePast = (ThePast >> (256 - Shift)) | (ThePast << Shift);
        
        // Calculate digest by Complex times
        Temporary = sha3(Previous,                   // Previous
                         ThePast,                    // Random pickup value from the chain
                         Previous - ThePast,         // Distance
                         Total,                      // Total number of randomness in the chain
                         Nonce[msg.sender]++);       // Sender nonce

        for(uint Count = 0; Count < Complex; Count++){
            Temporary = sha3(Temporary);
        }

        // Append number to the chain
        Immotal[Total++] = Temporary;

        // Return last number of the chain
        return Immotal[Total-1];
    }

    /**
    * No Ethereum will be trapped
    */
    function (){
        throw;
    }

}
