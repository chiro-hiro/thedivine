# TheDivine
The smart contracts allow us to generate pseudo-random number and secure it with lowest cost. All process and algorithm are transparent and open to everyone. Therefor the algorithm still safe at acceptable on wide ranger of PRNG application when cost to manipulate are greater than transaction value.

# Discaimler
Do not use this algorithm in gambling and/or use at your own risk. And surely that, do not use in cryptography

# What is The Divine?
The Divine is a immotality chain of randomness entropy, which was collected from message sender's nonce. Every sender have different nonce number that why they have recive a different result and contribute their own nonce to entropy chain. All user grownth and maintance immotality chain.

# How does The Divine secure?

Everytime anyone get result from The Divine, they also append their own randomness value to infinity chain. The randomness value had been created from:

**Shift:** *The base of bits rotation, created following simple formula `((Previous RSHIFT 128) XOR (Previous LSHIFT 128)) MOD 256`*

**Previous:** *The last value from the immotality chain, it will be rotated dependent to **Shift**.*

**ThePast:** *Random pickup value from the immotality chain, dependent to **Previous:**. It will be rotated dependent to **Shift**.*

**Distance:** *Equal to **Previous** - **ThePast**.*

**Total:** *The number of values in the immotality chain.*

**Nonce:**  *Nonce number of messange sender, this number increase each time sender request random number from The Divine.*

We will calculate **k** times the digest of all combine given data above. Thus honest participant call The Divine and pay for gas to execute TheDivine once times with complicated **O(n)**. Adversary who try to manipulate the result of The Divine they need precalculate, that's mean adversaris are going to solve **O(n^2)** to determine number of times they need to call The Divine. In case some unexpected participant may call to The Divine and change whole proccess by append they own entropy. Adversaries need to discard current calculation. With huge number of participants adversaries are not possible to manipulate the result anymore.