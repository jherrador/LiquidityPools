# 💧 LiquidityPools

![Ethereum](https://img.shields.io/badge/Ethereum-Blockchain-3C3C3D?logo=ethereum&logoColor=white)
![Solidity](https://img.shields.io/badge/Solidity-%5E0.8.x-363636?logo=solidity)
![UniswapV2](https://img.shields.io/badge/DEX-Uniswap%20V2-orange)
![DeFi](https://img.shields.io/badge/Focus-DeFi-blue)
![License](https://img.shields.io/badge/License-Unlicensed-lightgrey)

LiquidityPools is a **DeFi-focused Solidity project** built on top of **Uniswap V2**, designed to demonstrate practical interaction with AMMs (Automated Market Makers), swap execution, liquidity provisioning, and liquidity removal.

This project showcases hands-on experience integrating real DeFi infrastructure and implementing production-style smart contract logic.

---

## 🚀 Why This Project Matters

This repository demonstrates:

- ✅ Direct integration with **Uniswap V2 Router**
- ✅ ERC20 token swap execution
- ✅ Single-token liquidity provisioning (abstracting AMM complexity)
- ✅ **Liquidity removal (LP token burn & asset retrieval)**
- ✅ ERC20 handling and approval workflows
- ✅ Understanding of AMM mechanics and liquidity math

It reflects practical knowledge of how decentralized exchanges operate under the hood.

---

## 🧠 What The Protocol Does

### 🔄 Token Swapping

Users can swap ERC20 tokens through Uniswap V2 pools.

Key points:

- Direct Uniswap V2 Router interaction
- Multi-hop routing support
- Secure token transfer & approval flow
- Integration logic written directly in Solidity

---

### 💧 Add Liquidity Using a Single Token

Unlike standard Uniswap flows (which require both tokens in the correct ratio), this contract allows:

- Adding liquidity using only one token
- Automatic internal swap (if required)
- Simplified user experience
- LP token minting

This abstracts complexity while preserving AMM mechanics.

---

### 🔓 Remove Liquidity

Users can also remove liquidity from a Uniswap V2 pool:

- Burn LP tokens
- Retrieve proportional underlying assets
- Interact directly with Uniswap V2 Router

This completes the full liquidity lifecycle: **add → manage → remove**.

---

## 🏗️ Technical Highlights

- Solidity-based DeFi integration
- Router-level interaction (not SDK-based)
- LP token minting & burning
- Internal token ratio handling
- Clean modular architecture
- Tested using Foundry

> Note: Slippage handling is currently managed at the testing level and not enforced directly inside the `SwapAppV2.sol` contract logic.

---

## 📦 Project Structure

```text
.
├── src/        → Core swap & liquidity contracts
├── test/       → Unit tests
├── script/     → Deployment scripts
└── lib/        → Dependencies
```

---

## 🛠 Tech Stack

- Solidity
- Uniswap V2
- ERC20
- Foundry
- Ethereum

---

## 🔍 Example Interaction Flow

### Swap

1. Approve token.
2. Call swap function.
3. Contract executes swap through Uniswap V2 Router.

### Add Liquidity (Single Token)

1. Approve token.
2. Call addLiquiditySingleToken().
3. Contract handles internal routing.
4. LP tokens minted to user.

### Remove Liquidity

1. Approve LP tokens.
2. Call removeLiquidity().
3. Contract burns LP tokens.
4. Underlying assets returned to user.

---

## 🧠 What This Demonstrates (For Recruiters)

This project proves:

- Understanding of AMM pricing mechanics
- Full liquidity lifecycle handling (add/remove)
- Experience integrating third-party DeFi protocols
- ERC20 approval and token flow handling
- Solidity best practices in DeFi contexts

---

## 🔮 Future Improvements

- Support Uniswap V3 Liquidity
- Multi-DEX Support (Uniswap, SushiSwap)
- Automatic optimal routing engine
- Impermanent loss estimator
- Layer 2 deployment (Arbitrum / Optimism)
- On-chain slippage protection implementation

---

## 👤 Author

Developed by **Javier Herrador**  
Blockchain & Solidity Developer focused on DeFi infrastructure and protocol mechanics.
