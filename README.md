# AES-128
AES-128 consists of 10 rounds, each round, a number of operations is done on the Plaintext using a round subkey. after the 10th round, the Ciphertext is ready.  This design prioritizes the cost and area, only one instance of each module is used to compute the rounds. I achieved this using an FSM Controller. The Ciphertext is ready after 12 cycles.
