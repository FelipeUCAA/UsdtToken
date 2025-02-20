// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IUniswapV2Router02 {
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountA,
        uint256 amountB,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 _amountA, uint256 _amountB, uint256 liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 _amountA, uint256 _amountB);

    // Outras funções da interface podem ser adicionadas conforme necessário
}
