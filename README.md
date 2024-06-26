# accounts benchmark

Test `create`, `send ether` and `send dai` in production for smart accounts and compare the results.

| Test Case    | Nani Account (Gas Used) | Coinbase SW Account (Gas Used) |
|--------------|--------------------------|--------------------------------|
| Create       | 99,783                   | 178,446                        |
| Send Ether   | 20,287                   | 20,531                         |
| Send DAI     | 41,800                   | 42,306                         |

## Getting Started

Run: `curl -L https://foundry.paradigm.xyz | bash && source ~/.bashrc && foundryup`

Build the foundry project with `forge build`. Run tests with `forge test`. Measure gas with `forge snapshot`. Format with `forge fmt`.

## License

See [LICENSE](./LICENSE) for more details.
