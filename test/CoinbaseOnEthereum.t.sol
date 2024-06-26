// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";

interface ICreate {
    function createAccount(bytes[] calldata, uint256) external payable returns (address);
}

interface IExecute {
    function execute(address, uint256, bytes calldata) external payable;
}

interface IERC20 {
    function transfer(address, uint256) external returns (bool);
}

contract CoinbaseOnEthereumTest is Test {
    ICreate constant factory = ICreate(0x0BA5ED0c6AA8c49038F819E587E2633c4A9F428a);

    uint256 constant salt0 = 0;
    uint256 constant salt1 = 1;

    bytes[] owners;

    address constant z = 0x1C0Aa8cCD568d90d61659F060D1bFb1e6f855A20;
    address constant dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    IExecute account;

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main")); // Ethereum mainnet fork.
        owners.push(abi.encode(address(this)));
        account = IExecute(factory.createAccount(owners, salt1));
        (bool ok,) = address(account).call{value: 0.001 ether}("");
        assert(ok);
        vm.prank(z);
        IERC20(dai).transfer(address(account), 1 ether);
        vm.prank(z);
        IERC20(usdc).transfer(address(account), 10 ** 6);
    }

    function testCreate() public payable {
        IExecute(factory.createAccount(owners, salt0));
    }

    function testSendETH() public payable {
        account.execute(address(this), 0.001 ether, "");
    }

    function testSendDAI() public payable {
        account.execute(
            dai, 0, abi.encodeWithSelector(IERC20.transfer.selector, address(this), 1 ether)
        );
    }

    function testSendUSDC() public payable {
        account.execute(
            usdc, 0, abi.encodeWithSelector(IERC20.transfer.selector, address(this), 10 ** 6)
        );
    }

    receive() external payable {}
}
