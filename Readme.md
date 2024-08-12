# NFTLingo Module

The `NFTLingo` module is a Move smart contract designed for managing a simple token system with functionalities for minting, burning, depositing, withdrawing, and transferring tokens. This module includes the ability to create and manage balances for different accounts.

## Overview

This module defines the following main components:
- **Crypto**: Represents a token with a value.
- **Bal**: Stores the balance of tokens for an account.
- **Functions**: Includes functionalities for minting tokens, burning tokens, creating balances, depositing, withdrawing, and transferring tokens.

## Error Codes

The module defines the following error codes:
- `ERR_BALANCE_NOT_EXISTS`: Error code 101 for when a balance does not exist.
- `ERR_BALANCE_EXISTS`: Error code 102 for when a balance already exists.
- `EINSUFFICIENT_BALANCE`: Error code 1 for insufficient balance.
- `EALREADY_HAS_BALANCE`: Error code 2 for an already existing balance.
- `EEQUAL_ADDR`: Error code 4 for equal addresses in transfer.

## Functions

### `mint(val: u64) -> Crypto`

Creates a new token with a given value.

### `burn(coin: Crypto)`

Burns a given token, removing it from circulation.

### `create_balancce(acc: &signer)`

Creates a new balance for the specified account. The balance starts at zero. Note that there is a typo in the function name; it should be `create_balance`.

### `balance_exists(acc_addr: address) -> bool`

Checks if a balance exists for the given address.

### `balance(owner: address) -> u64`

Returns the balance of tokens for the specified address.

### `deposit(acc_addr: address, tokens: Crypto)`

Deposits tokens into the balance of the specified address.

### `withdraw(acc: address, value: u64) -> Crypto`

Withdraws a specified amount of tokens from the balance of the given address and returns the withdrawn tokens.

### `transfer(from: &signer, to: address, amount: u64)`

Transfers a specified amount of tokens from one address to another.

## Test

### `test_use_some_coins(acc: signer)`

Tests the basic functionality of minting, creating a balance, depositing, withdrawing, and burning tokens. This function verifies that the token operations work as expected.

## TOML Configuration

The TOML file is used for configuration and includes package information, addresses, and dependencies.

```toml
[package]
name = "send_message"
version = "1.0.0"
authors = []

[addresses]
nftlingo ='0x0dc80a9f9c33215a41a19b15635659ea6380734df94b3ea5d6ecbe0910fc2cc8'

[dependencies.AptosFramework]
git = "https://github.com/aptos-labs/aptos-core.git"
rev = "mainnet"
subdir = "aptos-move/framework/aptos-framework"
```

## Notes

- Ensure that the function names in the module are consistent and correct (`create_balancce` should be `create_balance`).
- The TOML file defines dependencies on the Aptos framework, which is required for deploying and interacting with the module.

For further details on using and deploying this module, refer to the [Aptos documentation](https://aptos.dev/docs).
