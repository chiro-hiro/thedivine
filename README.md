# The Divine

## Introduction

**The Divine** is uncontrollable number.

**The Divine** is one more security layer to protect your RNG contract, RANDAO,...from many kinds of attack.

**The Divine** is contract which's give you power and belong to the void. No fees are required, you have to pay for gas cost and get the **Power** (*unsigned 256 bits integer*).

## Concept

**The Divine** is a smart contract which was growing a **World Tree**.

**World Tree** is grown by **you** and **anyone** who is using this contract.

**World Tree** Have root and it's **World Tree's** address.

**World Tree** is chained, one chain is created by:

* Previous chain value
* Sender address
* Current difficulty

## Why ?

* **Previous chain value:** You are only changing it by change previous value, and it's impossible.
* **Sender address:** is adding value, user can not manipulate it.
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

* It can not protect you from [51% attack](http://ethdocs.org/en/latest/mining.html#what-is-mining).
* This contract can be manipulated by combining all conditions:
    * Malicious miner was found a block which is ```GetPower()``` was called.
    * Malicious have been increased the difficulty by hold mined block.
    * Malicious block do not become an uncle block.