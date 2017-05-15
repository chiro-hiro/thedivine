# The Divine
Smart contracts allow us to generate and secure pseudo-random numbers and for the lowest cost. All processes and algorithms are transparent and open to everyone. The algorithm is thus safe and acceptable for a wide range of PRNG applications and situations where the cost to manipulate outweigh the transaction value.

# Disclaimer
Do not use this algorithm in gambling and/or use at your own risk. Definitely do not use this algorithm in cryptography.

# What is The Divine?
The Divine is an immortality chain of randomness entropy, which is collected from the nonce of a sender's message . Each sender has a different nonce number they contribute to the entropy chain, thus ensuring a different. All users grow and maintain the immortality chain.

# How does The Divine secure?

Anyone at anytime can get the results from The Divine, as well also add their own randomness value to the infinity chain. The randomness value had been created from:

**Shift:** *The base of bits rotation is created by the simple formula: `((Previous RSHIFT 128) XOR (Previous LSHIFT 128)) MOD 256`*

**Previous:** *The last value from the immortality chain will be rotated dependent on **Shift**.*

**ThePast:** *Random pickup value from the immortality chain is dependent on **Previous:**. It will be rotated dependent on **Shift**.*

**Distance:** *Equal to **Previous** - **ThePast**.*

**Total:** *The number of immortality chain values.*

**Nonce:**  *Nonce number of the message sender, this number increases each time the sender requests a random number from The Divine.*

We will calculate **k** times the Digest value of the combined data above. Honest participants request The Divine and pay for the gas to execute it once with complexity of **O(n)**.An adversary who try to manipulate the result of The Divine need to precalculate, meaning solve a complexity of **O(n^2)** to determine number of times they need to call The Divine. Sometimes unexpected participants will call The Divine and change the entire process by appended they own entropy forcing adversary need to discard current calculation. With a huge number of participants, adversary is unable to manipulate the results.