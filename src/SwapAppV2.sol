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
        uint256 amountOutMin_,
        address[] memory path_,
        address to_,
        uint256 deadline_
    ) public returns (address tokenIn, address tokenOut, uint256 amountTokensOut) {
        if (!_validPath(path_)) {
            revert InvalidPath(path_);
        }

        IERC20(path_[0]).safeTransferFrom(msg.sender, address(this), amountIn_);
        IERC20(path_[0]).approve(V2Router02Address, amountIn_);

        uint256[] memory swapAmounts_ =
            IV2Router02(V2Router02Address).swapExactTokensForTokens(amountIn_, amountOutMin_, path_, to_, deadline_);

        amountTokensOut = swapAmounts_[swapAmounts_.length - 1];
        tokenIn = path_[0];
        tokenOut = path_[path_.length - 1];

        emit SwapTokens(tokenIn, tokenOut, amountIn_, amountTokensOut);
    }

    function addLiquiditySingleToken(
        address token1_,
        address token0_,
        uint256 amount0In_,
        uint256 amountAMin_,
        uint256 amountBMin_,
        uint256 amountOutMin_,
        address[] memory path_,
        uint256 deadline_
    ) external returns (uint256 transferedTokens0, uint256 transferedTokens1, uint256 lpTokenAmount) {
        require(token1_ == path_[0], "TokenA address not in path");
        require(token0_ == path_[path_.length - 1], "TokenB address not in path");

        uint256 amountDesiredToken0 = amount0In_ / 2;

        (,, uint256 amountTokensBAfterSwap) =
            swapTokens(amountDesiredToken0, amountOutMin_, path_, address(this), deadline_);

        IERC20(token1_).approve(V2Router02Address, amountDesiredToken0);
        IERC20(token1_).safeTransferFrom(msg.sender, address(this), amount0In_ - amountDesiredToken0);
        IERC20(token0_).approve(V2Router02Address, amountTokensBAfterSwap);

        (transferedTokens0, transferedTokens1, lpTokenAmount) = IV2Router02(V2Router02Address)
            .addLiquidity(
                token1_,
                token0_,
                amountDesiredToken0,
                amountTokensBAfterSwap,
                amountAMin_,
                amountBMin_,
                msg.sender,
                deadline_
            );

        emit AddLiquidity(token1_, token0_, lpTokenAmount);
    }

    function removeLiquidity(
        address token0_,
        address token1_,
        uint256 liquidityAmount_,
        uint256 amount0Min_,
        uint256 amount1Min_,
        address to_,
        uint256 deadline_
    ) external {
        address lpTokenAddress = IV2Factory(V2FactoryAddress).getPair(token0_, token1_);

        IERC20(lpTokenAddress).transferFrom(msg.sender, address(this), liquidityAmount_);
        IERC20(lpTokenAddress).approve(V2Router02Address, liquidityAmount_);

        IV2Router02(V2Router02Address)
            .removeLiquidity(token0_, token1_, liquidityAmount_, amount0Min_, amount1Min_, to_, deadline_);
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
