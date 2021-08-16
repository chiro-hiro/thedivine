# The Divine

A smart contract that allowed us to generate and secure pseudo-random numbers for the lowest cost. All processes and algorithms are transparent and open to everyone. The algorithm is thus safe and acceptable for a wide range of PRNG applications and situations where the cost to manipulate outweigh the transaction value.

## Disclaimer

Do not use this algorithm in gambling and/or use it at your own risk. Do not use this algorithm in cryptography. We highly recommend it as an extra salt to improve your random result.

# What is the idea behind it?

## The idea

We get `blockhash` of 32nd older blocks from blockchain and combine with `immortal` by using `xor` operator then calculate its digest by using `keccak256` hash function. The new `immortal` value will be assigned with the given digest from the above step.

```
    immortal <- blockchain state
    currentBlock <- blockchain sate
    immortal <- keccak256(blockhash(currentBlock - 32) xor immortal)
    return immortal
```

We restrict the normal account to trigger this smart contract to prevent manipulation, the only way to trigger it is through a deployed smart contract. As long as there are many users of The Divine we could able to maintain an immortal chain of entropy.

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

## Compile opcode

I wrote my assembler, you would try and get the same result:

```
$ node ./assembler/index.js 
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

Output:          60203d333218600a57fd5b8181805482430340188152208155f3
Tx deploy data:  601a803d90600a8239f360203d333218600a57fd5b8181805482430340188152208155f3
```

## Ethereum

The Divine was deployed in [0xb2e8610f3c8710c07965f1de7d72345011c8be3b4bdfa9823168017d180754ac](https://etherscan.io/tx/0xb2e8610f3c8710c07965f1de7d72345011c8be3b4bdfa9823168017d180754ac) at [0xb7E5468671dEDaf316B73494B9bE73a5aDbA1cdf](https://etherscan.io/address/0xb7E5468671dEDaf316B73494B9bE73a5aDbA1cdf)

## Binance Smart Chain

The Divine was deployed in [0x73ca699adfe8ae9204dbe299ae2c1492f09999e51950df5278bf3a9f0164cb1a](https://bscscan.com/tx/0x73ca699adfe8ae9204dbe299ae2c1492f09999e51950df5278bf3a9f0164cb1a) at [0xF52a83a3B7d918B66BD9ae117519ddC436A82031](https://bscscan.com/address/0xF52a83a3B7d918B66BD9ae117519ddC436A82031)

## Polygon

The Divine was deployed in [0x7475de6549e9d4bd717f18972dcd1c57fea36d94cb5607a66ca92f33515f863a](https://polygonscan.com/tx/0x7475de6549e9d4bd717f18972dcd1c57fea36d94cb5607a66ca92f33515f863a) at [0x8F2F05d2A036C9AE279B333CAE12c9eC79f6C553](https://polygonscan.com/address/0x8f2f05d2a036c9ae279b333cae12c9ec79f6c553#code)

Data is:

```
0x601a803d90600a8239f360203d333218600a57fd5b8181805482430340188152208155f3
```

## What is `601a803d90600a8239f3` ?

This is code that was optimized to deploy a smart contract.

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
0xb7E5468671dEDaf316B73494B9bE73a5aDbA1cdf
```
- Binance Smart Chain: 
```
0xF52a83a3B7d918B66BD9ae117519ddC436A82031
```

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.5 <0.9.0;

interface TheDivine {
    function rand() external returns(uint256);
}

contract TestTheDivine{
    event Log(uint256 indexed _value);

    function testRand() public {
        emit Log(TheDivine(0xb7E5468671dEDaf316B73494B9bE73a5aDbA1cdf).rand());
    }
}
```

Gas cost is around `5190 Gas` each call.

# Testing

- Testing transaction on Binance Smart Chain: [0xf3b4e1a032904c61c617ec365e9c288d2e1fb8095f1298708974e14d4def2b1b](https://bscscan.com/tx/0xf3b4e1a032904c61c617ec365e9c288d2e1fb8095f1298708974e14d4def2b1b#eventlog)

# Reference

[A Pseudorandom Number Generator with KECCAK Hash Function ](http://www.ijcee.org/papers/439-JE503.pdf)

# License

This software distributed under [MIT License](https://github.com/chiro-hiro/thedivine/blob/master/LICENSE)
