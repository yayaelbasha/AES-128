# AES-128
AES-128 consists of 10 rounds, each round, a number of operations is done on the Plaintext using a round subkey. after the 10th round, the Ciphertext is ready.  This design prioritizes the cost and area, only one instance of each module is used to compute the rounds (as shown in the block diagram). I achieved this using an FSM Controller. The Ciphertext is ready after 12 cycles.

# Datapath Block Diagram

![AES_datapath](https://github.com/yayaelbasha/AES-128/assets/83354302/44424a1f-4dee-4618-ba7f-4a9244925c4c)

# Controller FSM

![AES_Ctrller_FSM](https://github.com/yayaelbasha/AES-128/assets/83354302/d7ea2d2f-7020-4574-8579-91362448f596)

# Netlist RTL

![aes_RTL](https://github.com/yayaelbasha/AES-128/assets/83354302/22016b47-b2ae-4fd3-bf6d-c971320c404a)

# Simulation Waveform

![aes_wave](https://github.com/yayaelbasha/AES-128/assets/83354302/cbe61e45-3b8b-47ed-85ca-69ff9b245644)

# Output Verification

![Verification](https://github.com/yayaelbasha/AES-128/assets/83354302/ad8a9cc7-8401-4a88-abc9-b133dc3c8594)

# Quartus Utilization

![Quartus_Utilization](https://github.com/yayaelbasha/AES-128/assets/83354302/398da6af-b876-431e-8ebf-3bad3cf1b6d9)

# Vivado Utilization

![Vivado_Utilization](https://github.com/yayaelbasha/AES-128/assets/83354302/0b1dc1da-5ad6-4f5f-be20-71ec99c831bb)


This AES-128 will be used in CTR mode, thus there is no need to implement the decryption hardware yet saving another 50% of area.


