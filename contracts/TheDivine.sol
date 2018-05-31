pragma solidity ^0.4.23;

contract TheDivine{

    /* Randomness chain */
    mapping (uint256 => bytes32) internal Immotal;

    /* Address nonce */
    mapping (address => uint256) internal Nonce;

    /* Total number of randomness in the chain */
    uint256 internal Total;

    /* Complex of digest compute */
    uint256 internal constant Complex = 12;
       
    /**
    * Construct function
    */
    constructor() public {
        Immotal[Total++] = keccak256(this);
        Immotal[Total++] = keccak256(Immotal[0]);
    }
    

    /**
    * Get result from PRNG
    */
    function rnd() public returns(bytes32){
        uint256 Previous = uint256(keccak256(Immotal[Total-1]));
        uint256 PickUp = (Previous >> 128) ^ (Previous << 128);
        uint256 ThePast = uint256(Immotal[PickUp % Total]);
        uint256 Shift = PickUp % 256;
        bytes32 Temporary;
        
        // Rotate previous value by shift operator
        Previous = (Previous >> Shift) | (Previous << (256 - Shift));

        // Reverse rotate ThePast value by shift operator
        ThePast = (ThePast >> (256 - Shift)) | (ThePast << Shift);
        
        // Calculate digest by Complex times
        Temporary = keccak256(Previous, ThePast, Previous - ThePast, Total, Nonce[msg.sender]++);

        for(uint256 Count = 0; Count < Complex; Count++){
            Temporary = keccak256(Temporary);
        }

        // Append number to the chain
        Immotal[Total++] = Temporary;

        // Return last number of the chain
        return Immotal[Total-1];
    }

    /**
    * No Ethereum will be trapped
    */
    function () public payable {
        revert();
    }

}
