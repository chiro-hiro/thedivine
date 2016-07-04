# The Divine

## Introduction

**The Divine** is uncontrollable number.

**The Divine** is one more security layer to protect your RNG contract, RANDAO,...from many kinds of attack.

**The Divine** is a smart contract which gives you **power** and belong to the void. No fees are required, you have to pay for gas cost and get the **power** (*unsigned 256 bits integer*).

**DO NOT USE THE DIVINE AS A RNG.**

## Concept

**The Divine** is a smart contract which was growing a **World Tree**.

**World Tree** is grown by **you** and **anyone** who is using this contract.

**World Tree** have root and it's **World Tree's** address.

**World Tree** is chained, one chain is created by:

* Previous chain value
* Sender address
* Current difficulty

## Why ?

* **The Divine didn't store anything:** To make sure that no one can read it own data. Anyone try to create off-chain simulates and read **The Divine's** data, they will read all invalid data cuz it is always change.
* **Previous chain value:** You are only changing it by change previous value, and it's impossible.
* **Sender address:** is adding value, user cannot manipulate it.
* **Current difficulty:** is controlled by an algorithm and the whole network. Let's take a look.
```
block_diff = parent_diff + parent_diff // 2048 * max(1 - (block_timestamp - parent_timestamp) // 10, -99) + int(2**((block.number // 100000) - 2))
```
What happen if some miner wants to manipulate **The Divine**?.
They only have a chance to manipulate by change ``block_timestamp``
```
max(1 - (block_timestamp - parent_timestamp) // 10, -99)
```
* ```If block_timestamp - parent_timestamp < 10 seconds``` : Not possible to manipulate, the difficulty didn't change.

* ```If block_timestamp - parent_timestamp > 10 seconds``` : and he can change the difficulty by ``max(1, -99)``.
When he tries to manipulating he's also pushing himself to risk, his block may become an uncle block. 

## Risks

* It cannot protect you from [51% attack](http://ethdocs.org/en/latest/mining.html#what-is-mining).
* This contract can be manipulated by combining all conditions:
    * The malicious miner was found a block which is ```GetPower()``` was called.
    * The malicious miner have been increasing the difficulty by hold mined block.
    * The malicious block does not become an uncle block.
