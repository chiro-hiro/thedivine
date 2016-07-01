# TheDivine

## Introduction

**The Divine** uncontrollable number.

**The Divine** is one more security layer to protect your RNG contract, RANDAO,...from many kind of attack.

**The Divine** contract which's give you power and belong to the void. No fees are required, you have to pay for gas cost and get the **Power**.

## Concept

**The Divine** is a smart contract which were growing a **World Tree**.

**World Tree** is grow by **you** and **anyone** who are use this contract.

**World Tree** Have root and it's **World Tree's** address.

**World Tree** is chain, one chain is created by:

* Previous chain value
* Sender address
* Current difficulty

## Why ?

* **Previous chain value:** You are only change it by change previous value, and it's impossible.
* **Sender address:** is addition value, user can not manipulate it.
* **Current difficulty:** is control by algorithm and whole network. Let's take a look.
```
block_diff = parent_diff + parent_diff // 2048 * max(1 - (block_timestamp - parent_timestamp) // 10, -99) + int(2**((block.number // 100000) - 2))
```
What's happen if some miner want to manipulate **The Divine** ?.
They only have chance to manipulate by change ``block_timestamp``
```
max(1 - (block_timestamp - parent_timestamp) // 10, -99)
```
If block_timestamp - parent_timestamp < 10 secs : Not possible to manipulate, difficulty not change.
If block_timestamp - parent_timestamp > 10 secs : and he can change difficulty by ``max(1, -99)``.
When he try to manipulating he's also push himself to risk, his block may be come an uncle block. 

