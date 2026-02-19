# 💧 LiquidityPools

![Ethereum](https://img.shields.io/badge/Ethereum-Blockchain-3C3C3D?logo=ethereum&logoColor=white)
![Solidity](https://img.shields.io/badge/Solidity-%5E0.8.x-363636?logo=solidity)
![UniswapV2](https://img.shields.io/badge/DEX-Uniswap%20V2-orange)
![DeFi](https://img.shields.io/badge/Focus-DeFi-blue)
![License](https://img.shields.io/badge/License-Unlicensed-lightgrey)

LiquidityPools is a **DeFi-focused Solidity project** built on top of **Uniswap V2**, designed to demonstrate practical interaction with AMMs (Automated Market Makers), swap execution, liquidity provisioning, and slippage control.

This project showcases hands-on experience integrating real DeFi infrastructure and implementing production-style smart contract logic.

---

## 🚀 Why This Project Matters

This repository demonstrates:

- ✅ Direct integration with **Uniswap V2 Router**
- ✅ Safe token swapping with **parameterized slippage control**
- ✅ Single-token liquidity provisioning (abstracting AMM complexity)
- ✅ ERC20 handling and approval workflows
- ✅ Understanding of AMM mechanics and liquidity math

It reflects practical knowledge of how decentralized exchanges operate under the hood.

---

## 🧠 What The Protocol Does

### 🔄 Token Swapping (With Slippage Protection)

Users can swap ERC20 tokens while defining their acceptable slippage tolerance.

Key points:

- Custom slippage parameter
- Minimum amount out calculation
- Multi-hop routing support
- Direct Uniswap V2 Router interaction
- Secure token transfer & approval flow

This protects users from excessive price impact during volatile market conditions.

---

### 💧 Add Liquidity Using a Single Token

Unlike standard Uniswap flows (which require both tokens in the correct ratio), this contract allows:

- Adding liquidity using only one token
- Automatic internal swap (if required)
- Simplified user experience
- LP token minting

This abstracts complexity while preserving AMM mechanics.

---

## 🏗️ Technical Highlights

- Solidity-based DeFi integration
- Router-level interaction (not SDK-based)
- Slippage parameterization logic
- Internal token ratio handling
- Gas-conscious swap execution
- Clean modular architecture
- Tested using Foundry

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
2. Call swap with:
   - tokenIn
   - tokenOut
   - amount
   - slippage tolerance
3. Contract calculates minimum amount out.
4. Executes swap through Uniswap V2.

### Add Liquidity (Single Token)

1. Approve token.
2. Call addLiquiditySingleToken().
3. Contract handles internal routing.
4. LP tokens minted to user.

---

## 🧠 What This Demonstrates (For Recruiters)

This project proves:

- Understanding of AMM pricing mechanics
- Knowledge of slippage risk management
- Experience integrating third-party DeFi protocols
- ERC20 approval and token flow handling
- Solidity best practices in DeFi contexts

---

## 🔮 Future Improvements

- Support Uniswap V3 Liquidity
- Remove Liquidity Support, Burn LP Tokens & withdraw proportional underlying assets
- Multi-DEX Support (Uniswap, sushiswap..)

### 🛡️ Risk Mitigation Enhancements
- Oracle price validation
- TWAP checks
- Dynamic slippage bounds

---

## 👤 Author

Developed by **Javier Herrador**  
Blockchain & Solidity Developer focused on DeFi infrastructure and protocol mechanics.
