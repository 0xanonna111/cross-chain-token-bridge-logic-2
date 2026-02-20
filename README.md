# Cross-Chain Token Bridge Logic

This repository provides an expert-level smart contract architecture for bridging ERC-20 tokens between two EVM-compatible networks. It utilizes the "Lock/Unlock" and "Mint/Burn" patterns commonly found in professional bridging protocols.

## Features
* **Lock/Release Mechanism**: Securely locks tokens on the source chain.
* **Mint/Burn Mechanism**: Creates "Wrapped" versions of assets on the destination chain.
* **Signature Verification**: Placeholder logic for EIP-712 or relayer-signed message validation to authorize minting.
* **Admin Controls**: Pause and unpause bridging functionality in case of emergencies.

## Workflow
1. **Bridge Out**: User calls `bridgeOut` which locks/burns tokens and emits a `BridgeInitiated` event.
2. **Relayer**: An off-chain service monitors events and triggers the destination contract.
3. **Bridge In**: Relayer calls `bridgeIn` on the destination chain to release/mint tokens to the user.

## Security
This code uses OpenZeppelin's `AccessControl` to manage designated "Relayer" roles, ensuring only authorized entities can finalize transfers.

## License
MIT
