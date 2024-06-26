# accounts benchmark

Test `create`, `send ether`, `send dai` and `send usdc` in production for smart accounts and compare the results.

## Ethereum:

| Test Case    | Nani Account (Gas Used)  | Coinbase SW (Gas Used)         |
|--------------|--------------------------|--------------------------------|
| Create       | 99,783                   | 178,446                        |
| Send Ether   | 20,287                   | 20,531                         |
| Send DAI     | 41,780                   | 42,292                         |
| Send USDC    | 52,313                   | 52,825                         |
| **Total**    | **214,163**              | **294,094**                    |

Gas report: [⛽](https://github.com/z0r0z/accounts-benchmark/blob/main/.gas-snapshot)

- Nani Account Factory: `0x0000000000009f1E546FC4A8F68eB98031846cb8`
- Coinbase SW Factory: `0x0BA5ED0c6AA8c49038F819E587E2633c4A9F428a`

All tests use a virtual fork of the production environment and reproduce live conditions as accurately as possible.

## Getting Started

Run: `curl -L https://foundry.paradigm.xyz | bash && source ~/.bashrc && foundryup`

Build the foundry project with `forge build`. Run tests with `forge test`. Measure gas with `forge snapshot`. Format with `forge fmt`.

## License

See [LICENSE](./LICENSE) for more details.
