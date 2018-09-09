# Tracebility Supply Chain Smart Contract

This repository contains Tracebility Supply Chain Smart Contract

## Getting Started

It integrates with [Truffle](https://github.com/ConsenSys/truffle), an Ethereum development environment. Please install Truffle.

```sh
npm install -g truffle

```

It uses ganache-cli for local simulation of Ethereum node. Please install ganache-cli

```sh
npm install -g ganache-cli

```


Clone Tracebility Supply Chain Smart Contract

```sh
git clone https://github.com/AnyLedger/smart-contracts.git
cd smart-contracts/ethereum/contractSandbox/traceabilitySupplyChain

```

Compile and Deploy
------------------
These commands apply to the RPC provider running on port 8545. You may want to have TestRPC running in the background. They are really wrappers around the [corresponding Truffle commands](http://truffleframework.com/docs/advanced/commands).

### Compile all contracts to obtain ABI and bytecode:

```bash
truffle compile
```
### Start ganache-cli

```bash
ganache-cli
```

### Migrate all contracts required for the basic framework onto network. Please specify network where contracts will be deployed. These networks are defined in truffle.js file

```bash
truffle migrate --network development (start ganache-cli mentioned in previous step)
```
Network Artifacts
-----------------

### Show the deployed addresses of all contracts on all networks:

```bash
truffle networks
```

Live Preview Link
-------------------
### https://traceabilitiyscm.herokuapp.com/

Contract address on rinkeby
-------------------
### https://rinkeby.etherscan.io/address/0x91e36e361ec6aca33cf6509a0691b0e7c6eebb2c

