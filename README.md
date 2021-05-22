# The Divine

A smart contract which allowed us to generate and secure pseudo-random numbers for the lowest cost. All processes and algorithms are transparent and open to everyone. The algorithm is thus safe and acceptable for a wide range of PRNG applications and situations where the cost to manipulate outweigh the transaction value.

## Disclaimer

Do not use this algorithm in gambling and/or use at your own risk. Definitely do not use this algorithm in cryptography. We're highly recommend as an extra salt to improve your random result.

# What is the idea behind it?

## The idea

We get `blockhash` of 32 th older blocks from blockchain and combine with `immortal` by using `xor` operator then calculate its digest by using `keccak256` hash function. The new `immortal` value will be assigned with given digest from above step.

```
    immortal <- blockchain state
    currentBlock <- blockchain sate
    immortal <- keccak256(blockhash(currentBlock - 32) xor immortal)
    return immortal
```

We restrict normal account to trigger smart contract to prevent manipulation, the only way to trigger it is through a deployed smart contract. As long as there are many users of TheDivine we could able to maintenance an immortality chain of entropy.

## Implementation

EVM assembly

```asm
60    PUSH1 0x20      ; [0x20]
3d    RETURNDATASIZE  ; [0x00, 0x20]
33    CALLER          ; [msg.sender, 0x00, 0x20]
32    ORIGIN          ; [tx.origin, msg.sender, 0x00, 0x20]
18    XOR             ; [tx.origin xor msg.sender, 0x00, 0x20]
60    PUSH1 0x0a      ; [jumpdest, tx.origin xor msg.sender, 0x00, 0x20]
57    JUMPI           ; [0x00, 0x20]
fd    REVERT          ; We do revert(0x00, 0x20), if tx.origin == msg.sender
5b    JUMPDEST        ; [0x00, 0x20]
81    DUP2            ; [0x20, 0x00, 0x20]
81    DUP2            ; [0x00, 0x20, 0x00, 0x20]
80    DUP1            ; [0x00, 0x00, 0x20, 0x00, 0x20]
54    SLOAD           ; [immortal, 0x00, 0x20, 0x00, 0x20]
82    DUP3            ; [0x20, immortal, 0x00, 0x20, 0x00, 0x20]
43    NUMBER          ; [block.number, 0x20, immortal, 0x00, 0x20, 0x00, 0x20]
03    SUB             ; [block.number - 0x20, immortal, 0x00, 0x20, 0x00, 0x20]
40    BLOCKHASH       ; [blockhash, immortal, 0x00, 0x20, 0x00, 0x20]
18    XOR             ; [blockhash xor immortal, 0x00, 0x20, 0x00, 0x20]
81    DUP2            ; [0x00, blockhash xor immortal, 0x00, 0x20, 0x00, 0x20]
52    MSTORE          ; [0x00, 0x20, 0x00, 0x20]
20    SHA3            ; [sha3(blockhash xor immortal), 0x00, 0x20]
81    DUP2            ; [0x00, sha3(blockhash xor immortal), 0x00, 0x20]
55    SSTORE          ; [0x00, 0x20]
f3    RETURN          ; []
```

Opcode:

```
60203d333218600a57fd5b8181805482430340188152208155f3
```

# Deployment

## Ethereum

The Divine was deployed in [0xb2e8610f3c8710c07965f1de7d72345011c8be3b4bdfa9823168017d180754ac](https://etherscan.io/tx/0xb2e8610f3c8710c07965f1de7d72345011c8be3b4bdfa9823168017d180754ac) at [0xb7e5468671dedaf316b73494b9be73a5adba1cdf](https://etherscan.io/address/0xb7e5468671dedaf316b73494b9be73a5adba1cdf)

## Binance Smart Chain

The Divine was deployed in [0x73ca699adfe8ae9204dbe299ae2c1492f09999e51950df5278bf3a9f0164cb1a](https://bscscan.com/tx/0x73ca699adfe8ae9204dbe299ae2c1492f09999e51950df5278bf3a9f0164cb1a) at [0xF52a83a3B7d918B66BD9ae117519ddC436A82031](https://bscscan.com/address/0xf52a83a3b7d918b66bd9ae117519ddc436a82031)


Data is:

```
0x601a803d90600a8239f360203d333218600a57fd5b8181805482430340188152208155f3
```

## What is `601a803d90600a8239f3` ?

It's code which was optimized to deploy a smart contract.

```asm
0000    60  PUSH1 0x1a      ; [divineCode.length]
0002    80  DUP1            ; [divineCode.length, divineCode.length]
0003    3D  RETURNDATASIZE  ; [0x00, divineCode.length, divineCode.length]
0004    90  SWAP1           ; [divineCode.length, 0x00, divineCode.length]
0005    60  PUSH1 0x0a      ; [0x0a, divineCode.length, 0x00, divineCode.length]
0007    82  DUP3            ; [0x00, 0x0a, divineCode.length, 0x00, divineCode.length]
0008    39  CODECOPY        ; [0x00, divineCode.length]
0009    F3  *RETURN         ; []
```

It will return a pointer to `memory[divineCode.offset:divineCode.length]`

# How to use TheDivine?

**Usage:**

- Ethereum Mainnet: 
```
0xb7e5468671dedaf316b73494b9be73a5adba1cdf
```
- Binance Smart Chain: 
```
0xF52a83a3B7d918B66BD9ae117519ddC436A82031
```

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

interface TheDivine {
    function rand() external returns(uint256);
}

contract TestTheDivine{
    event Log(uint256 indexed _value);

    function testRand() public {
        emit Log(TheDivine(0xb7e5468671dedaf316b73494b9be73a5adba1cdf).rand());
    }
}
```

Gas cost is around `5190 Gas` each call.

# Reference

[A Pseudorandom Number Generator with KECCAK Hash Function ](http://www.ijcee.org/papers/439-JE503.pdf)

# License

This software distributed under [MIT License](https://github.com/chiro-hiro/thedivine/blob/master/LICENSE)
