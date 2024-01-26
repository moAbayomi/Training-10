## Training 10

## Implementing a ERC-20 Token Contract from scratch (skrr skrr)

This Solidity contract implements the ERC-20 standard, providing a common interface for fungible tokens on the Ethereum blockchain. ERC-20 is widely adopted and used for various token implementations.

## Overview

contract deployed to here on the arbitrum sepolia chain: `0xc9808eA2d1C71D6B45dBB287ADEA6c09a35f54E6`

The contract is deployed with the following parameters:

- **Name:** MUHd20
- **Symbol:** MUHD
- **Decimals:** 18
- **Initial Supply:** Configurable during deployment

### Features

1. **Transfer:** Allows users to transfer tokens to another address.

2. **Balance Inquiry:** Provides a function to query the token balance of a specific address.

3. **Approval:** Allows an account owner to approve another address to spend tokens on their behalf.

4. **Allowance Inquiry:** Provides a function to check the amount of tokens that an approved spender can still spend.

5. **Transfer From:** Enables the approved spender to transfer tokens on behalf of the token owner.

6. **Increase Allowance:** Allows the token owner to increase the allowance for a spender.

7. **Decrease Allowance:** Allows the token owner to decrease the allowance for a spender.

## Usage
 Interact with the contract through its functions to transfer tokens, check balances, and manage allowances.


