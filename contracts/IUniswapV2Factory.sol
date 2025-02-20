// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IUniswapV2Router02.sol";

interface IUniswapV2Factory {
    function getPair(address tokenA, address tokenB) external view returns (address pair);
}
