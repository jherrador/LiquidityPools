// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import "./interfaces/IV2Router02.sol";
import "./interfaces/IV2Factory.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

contract SwapAppV2 {
    using SafeERC20 for IERC20;

    address public V2Router02Address;
    address public V2FactoryAddress;

    event SwapTokens(address tokenIn_, address tokenOut_, uint256 amountIn_, uint256 amountOut_);
    event AddLiquidity(address token0, address token1, uint256 lpTokenAmount);

    error InvalidPath(address[] path_);

    constructor(address V2Router02Address_, address V2FactoryAddress_) {
        V2Router02Address = V2Router02Address_;
        V2FactoryAddress = V2FactoryAddress_;
    }

    function swapTokens(
        uint256 amountIn_,
        uint256 slippage_,
        address[] memory path_,
        address to_,
        uint256 deadline_
    ) public returns (address tokenIn, address tokenOut, uint256 amountTokensOut) {
        if (!_validPath(path_)) {
            revert InvalidPath(path_);
        }

        IERC20(path_[0]).safeTransferFrom(msg.sender, address(this), amountIn_);
        
        uint256 amountOutMin_ = getAmountWithslippage(amountIn_, path_, slippage_);
        
        uint256[] memory swapAmounts_ =
            IV2Router02(V2Router02Address).swapExactTokensForTokens(amountIn_, amountOutMin_, path_, to_, deadline_);

        amountTokensOut = swapAmounts_[swapAmounts_.length - 1];
        tokenIn = path_[0];
        tokenOut = path_[path_.length - 1];

        emit SwapTokens(tokenIn, tokenOut, amountIn_, amountTokensOut);
    }

    function addLiquidity(
        address tokenA_,
        address tokenB_,
        uint256 amountAIn_,
        uint256 swapSlippage_,
        uint256 liquiditySlippage_,
        address[] memory path_,
        uint256 deadline_
    ) external returns (uint256 lpTokenAmount){
        require(tokenA_ == path_[0], "TokenA address not in path");
        require(tokenB_ == path_[path_.length - 1], "TokenB address not in path");

        uint256 amountDesiredTokensA = amountAIn_ / 2;

        (,, uint256 amountDesiredTokensB) =
            swapTokens(amountDesiredTokensA, swapSlippage_, path_, address(this), deadline_);

        uint256 amountAMin_ = amountDesiredTokensA * (10_000 - liquiditySlippage_) / 10_000;
        uint256 amountBMin_ = amountDesiredTokensB * (10_000 - liquiditySlippage_) / 10_000;

        IERC20(tokenA_).approve(V2Router02Address, amountAMin_);
        IERC20(tokenB_).approve(V2Router02Address, amountBMin_);

        (,, lpTokenAmount) = IV2Router02(V2Router02Address)
            .addLiquidity(
                tokenA_,
                tokenB_,
                amountDesiredTokensA,
                amountDesiredTokensB,
                amountAMin_,
                amountBMin_,
                msg.sender,
                deadline_
            );

        emit AddLiquidity(tokenA_, tokenB_, lpTokenAmount);
    }

    function getAmountWithslippage(uint256 amountIn_, address[] memory path_, uint256 slippage_) public returns(uint256){
        uint256[] memory quoteAmounts_ = IV2Router02(V2Router02Address).getAmountsOut(amountIn_, path_);
        uint256 amountOutMin_ = quoteAmounts_[quoteAmounts_.length - 1] * (10_000 - slippage_) / 10_000;

        return amountOutMin_;
    }

    function _validPath(address[] memory path) private view returns (bool) {
        require(path.length >= 2, "Invalid path");

        for (uint256 i = 0; i < path.length - 1; i++) {
            address pair = IV2Factory(V2FactoryAddress).getPair(path[i], path[i + 1]);
            if (pair == address(0)) {
                return false;
            }
        }

        return true;
    }
}
