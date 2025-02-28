# ArtisanMarketplace

A decentralized marketplace for digital art built on Clarity smart contracts.

## Overview

ArtisanMarketplace is a blockchain-based platform that enables artists to mint, list, and sell their digital artwork as NFTs (Non-Fungible Tokens). The platform facilitates secure, transparent transactions between creators and collectors.

## Features

- **NFT Creation**: Artists can mint unique digital art tokens
- **Secure Marketplace**: Direct peer-to-peer transactions between artists and collectors
- **Bidding System**: Collectors can place bids on artwork
- **Ownership Transfer**: Automatic transfer of NFTs upon successful sales
- **Transparent History**: All transactions are recorded on the blockchain

## Smart Contract Structure

The core of this project is the `ArtisanMarketplace.clar` Clarity smart contract which handles:

1. **Artwork Registration**: Artists can register their digital art with a specified price
2. **Bid Placement**: Collectors can express interest by placing bids
3. **Sale Finalization**: Executes the transfer of ownership and funds
4. **Bid Withdrawal**: Allows collectors to withdraw their bids if needed

## Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity development environment
- [Stacks Wallet](https://www.hiro.so/wallet) - For interacting with the contract

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/ArtisanMarketplace.git
   cd ArtisanMarketplace
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Deploy the contract locally for testing:
   ```
   clarinet console
   ```

## Usage

### For Artists

```clarity
;; List your artwork
(contract-call? .ArtisanMarketplace list-artwork u1000000 u1)
```

### For Collectors

```clarity
;; Place a bid on artwork
(contract-call? .ArtisanMarketplace place-bid)

;; Finalize the purchase of artwork
(contract-call? .ArtisanMarketplace finalize-sale)

;; Withdraw your bid if needed
(contract-call? .ArtisanMarketplace withdraw-bid)
```

## Contract Functions

- `list-artwork`: Register a digital artwork with a price and ID
- `place-bid`: Express interest in purchasing the artwork
- `finalize-sale`: Complete the transaction, transferring NFT and funds
- `withdraw-bid`: Remove your bid from consideration

## Testing

Run the test suite:

```
clarinet test
```

## Security Considerations

- All user inputs are validated before processing
- The contract ensures only the artwork creator can list items
- Transactions are atomic, ensuring both NFT and funds transfer successfully
- Ownership validation prevents unauthorized actions
