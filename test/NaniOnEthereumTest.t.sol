// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";

interface ICreate {
    function createAccount(address, bytes32) external payable returns (address);
}

interface IExecute {
    function execute(address, uint256, bytes calldata) external payable returns (bytes memory);
}

interface IERC20 {
    function transfer(address, uint256) external returns (bool);
}

contract NaniOnEthereumTest is Test {
    ICreate constant factory = ICreate(0x0000000000009f1E546FC4A8F68eB98031846cb8);

    bytes32 immutable salt0 = 0x0000000000000000000000000000000000000000000000000000000000000000;
    bytes32 immutable salt1 = bytes32(abi.encodePacked(address(this)));

    address constant z = 0x1C0Aa8cCD568d90d61659F060D1bFb1e6f855A20;
    address constant dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    IExecute account;

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main")); // Ethereum mainnet fork.
        account = IExecute(factory.createAccount(address(this), salt1));
        (bool ok,) = address(account).call{value: 0.001 ether}("");
        assert(ok);
        vm.prank(z);
        IERC20(dai).transfer(address(account), 1 ether);
    }

    function testCreate() public payable {
        IExecute(factory.createAccount(address(this), salt0));
    }

    function testSendETH() public payable {
        account.execute(address(this), 0.001 ether, "");
    }

    function testSendDai() public payable {
        account.execute(
            dai, 0, abi.encodeWithSelector(IERC20.transfer.selector, address(this), 1 ether)
        );
    }

    receive() external payable {}
}
