[![Build Status](https://travis-ci.org/chiro-hiro/thedivine.svg?branch=master)](https://travis-ci.org/chiro-hiro/thedivine)

# The Divine
A smart contract is allow us to generate and secure pseudo-random numbers and for the lowest cost. All processes and algorithms are transparent and open to everyone. The algorithm is thus safe and acceptable for a wide range of PRNG applications and situations where the cost to manipulate outweigh the transaction value.

# Disclaimer
Do not use this algorithm in gambling and/or use at your own risk. Definitely do not use this algorithm in cryptography.

# What is The Divine?
The Divine is an immortality chain of randomness entropy, which is collected from the nonce of a sender's message . Each sender has a different nonce number they contribute to the entropy chain, thus ensuring a different. All users grow and maintain the immortality chain.

# How to use TheDivine?

**Contract ABI:**

```
[{"constant":false,"inputs":[],"name":"rand","outputs":[{"name":"result","type":"bytes32"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"payable":true,"stateMutability":"payable","type":"fallback"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_sender","type":"address"},{"indexed":false,"name":"_complex","type":"uint256"},{"indexed":false,"name":"_randomValue","type":"bytes32"}],"name":"NewRand","type":"event"}]
```

**Contract Address:** [0xf0068C4b8ea178CaaC88B70136BEe03b7953E479](https://etherscan.io/address/0xf0068C4b8ea178CaaC88B70136BEe03b7953E479)
```
0xf0068C4b8ea178CaaC88B70136BEe03b7953E479
```

**Usage:**

```
pragma solidity ^0.4.24;


contract TheDivineInterface{
    function rand() public returns(bytes32);
}

contract TheDivineUser{

    event Log(bytes32 _value);
    
    function testRand() public {
        emit Log(TheDivineInterface(0x692a70D2e424a56D2C6C27aA97D1a86395877b3A).rand());
    }
}
```

# Reference

[A Pseudorandom Number Generator with KECCAK Hash Function ](http://www.ijcee.org/papers/439-JE503.pdf)

# License

This software distributed under [MIT License](https://github.com/chiro-hiro/thedivine/blob/master/LICENSE)