// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC20.sol";  
import "./IUniswapV2Router02.sol";  

contract SimulatedUSDTToken is IERC20 {
    string public name = "Tether USD";
    string public symbol = "USDT";
    uint8 public decimals = 6;
    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    IUniswapV2Router02 public uniswapRouter;
    address public usdt;

    constructor(address _usdtAddress, address _uniswapRouterAddress) {
        usdt = _usdtAddress;
        uniswapRouter = IUniswapV2Router02(_uniswapRouterAddress);
        _mint(msg.sender, 10_000_000 * (10 ** uint256(decimals)));
    }

    // Funções ERC20 padrão
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender] - amount);
        return true;
    }

    // Funções internas
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(_balances[sender] >= amount, "ERC20: transfer amount exceeds balance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        _balances[account] += amount;

        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");
        require(_balances[account] >= amount, "ERC20: burn amount exceeds balance");

        _totalSupply -= amount;
        _balances[account] -= amount;

        emit Transfer(account, address(0), amount);
    }

    // Funções para adicionar liquidez ao Uniswap
    function addLiquidity(uint256 tokenAmount, uint256 usdtAmount) external {
        require(balanceOf(msg.sender) >= tokenAmount, "Saldo insuficiente de tokens simulados");
        _approve(msg.sender, address(uniswapRouter), tokenAmount);
        IERC20(usdt).approve(address(uniswapRouter), usdtAmount);

        uniswapRouter.addLiquidity(
            address(this),
            usdt,
            tokenAmount,
            usdtAmount,
            0,  // Mínimo de seu token aceitável
            0,  // Mínimo de USDT aceitável
            msg.sender,
            block.timestamp
        );
    }

    // Função de queima e troca de tokens
    function exchangeSimulatedForUSDT(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Saldo insuficiente");
        _burn(msg.sender, amount);  // Queima os tokens simulados
        require(IERC20(usdt).transfer(msg.sender, amount), "Transfer failed");
    }

    // Função para obter o preço (1:1 com USDT)
    function getSimulatedPrice() public view returns (uint256) {
        return 1 * 10 ** uint256(decimals);
    }

    // Eventos do contrato
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
