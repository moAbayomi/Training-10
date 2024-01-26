// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract ERC20 {
    // name
    // symbol
    // decimal
    // total supply

    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;

    mapping(address => uint256) private addressToBal;
    mapping(address => mapping(address => uint256)) private addressToAllowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _decimal,
        uint256 initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        // decimal should be init to 18 i guess ?
        decimals = _decimal;
        // so that
        // totalsupply => initialSupply * 10^18;
        totalSupply = initialSupply * 10 ** uint256(decimals);

        addressToBal[msg.sender] = totalSupply;
        // address(0) which is => 0x0000000000000000000000000000000000000000
        // just shows that tokens are not being transferred from some existing address
        // they are just minted into existence
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function balanceOf(address account) external view returns (uint256) {
        return addressToBal[account];
    }

    function allowance(
        address from,
        address to
    ) external view returns (uint256) {
        return addressToAllowance[from][to];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(
            to != address(0) && msg.sender != address(0),
            "Invalid addresses."
        );

        require(addressToBal[msg.sender] >= value, "insufficient fundss");

        addressToBal[msg.sender] -= value;
        addressToBal[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        addressToAllowance[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);
        return true;
    }

    // transferring on behalf of another user
    // so that, it address A has allowed address B to spend 20 tokens on their behalf, after B
    // transfers 5 of A's token, the remaining allowance will be 15.
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool) {
        // condition to see if indeed address from has allowed the caller &&
        // if they are not exceeding the allowance value/limit ... in that if they are allowed 40 and trying to spend 42.
        require(
            addressToAllowance[from][msg.sender] <= value,
            "you are not approved this much tokens sorry"
        );

        // cond to see if the from address even have that much tokens ??
        require(addressToBal[from] >= value, "insufficient fundss");

        addressToBal[from] -= value;
        addressToBal[to] += value;

        // this updates the allowance
        // i.e spent 27 tokens out of 69 and now its remaining 42
        uint256 newAllowance = addressToAllowance[from][msg.sender] - value;

        addressToAllowance[from][msg.sender] = newAllowance;

        emit Transfer(from, to, value);
        emit Approval(from, msg.sender, newAllowance);

        return true;
    }

    function increaseAllowance(
        address owner,
        address spender,
        uint256 value
    ) external returns (bool) {
        uint256 newAllowance = addressToAllowance[owner][spender] + value;

        addressToAllowance[owner][spender] = newAllowance;

        emit Approval(owner, spender, newAllowance);

        return true;
    }

    function decreaseAllowance(
        address owner,
        address spender,
        uint256 value
    ) external returns (bool) {
        uint256 newAllowance = addressToAllowance[owner][spender] - value;

        addressToAllowance[owner][spender] = newAllowance;

        emit Approval(owner, spender, newAllowance);

        return true;
    }
}
