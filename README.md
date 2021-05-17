# The Divine

A smart contract which allowed us to generate and secure pseudo-random numbers and for the lowest cost. All processes and algorithms are transparent and open to everyone. The algorithm is thus safe and acceptable for a wide range of PRNG applications and situations where the cost to manipulate outweigh the transaction value.

# Disclaimer

Do not use this algorithm in gambling and/or use at your own risk. Definitely do not use this algorithm in cryptography.

# What is The Divine?

The Divine is an immortality chain of randomness entropy, which is collected from the nonce of a sender's message . Each sender has a different nonce number they contribute to the entropy chain, thus ensuring a different. All users grow and maintain the immortality chain.

# What is the idea behidden it?

## The idea

We get `blockhash` of 32th older blocks from blockchain and combine with `immortal` by using `xor` operator.

```
    immortal <- blockchain state
    currentBlock <- blockchain sate
    immortal <- keccak256(blockhash(currentBlock) xor immortal)
    return immortal
```

We restrict normal account to trigger smart contract, the only way to trigger it is through a deployed smart contract

## Implementation

EVM assembly

```asm
60    PUSH1 0x20
3d    RETURNDATASIZE
33    CALLER
32    ORIGIN
18    XOR
60    PUSH1 0x0a
57    JUMPI
fd    REVERT
5b    JUMPDEST
81    DUP2
81    DUP2
80    DUP1
54    SLOAD
82    DUP3
43    NUMBER
03    SUB
40    BLOCKHASH
18    XOR
81    DUP2
52    MSTORE
20    SHA3
81    DUP2
55    SSTORE
f3    RETURN
```

Opcode:

```
60203d333218600a57fd5b8181805482430340188152208155f3
```

# How to use TheDivine?

**Usage:**

```
pragma solidity >=0.8.4 <0.9.0;


interface TheDivine {
    function rand() external returns(uint256);
}

contract TheDivineUser{

    event Log(uint256 indexed _value);

    function testRand() public {
        emit Log(TheDivineInterface(0x00...00).rand());
    }
}
```

# Reference

[A Pseudorandom Number Generator with KECCAK Hash Function ](http://www.ijcee.org/papers/439-JE503.pdf)

# License

This software distributed under [MIT License](https://github.com/chiro-hiro/thedivine/blob/master/LICENSE)
