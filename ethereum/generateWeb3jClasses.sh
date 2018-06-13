#!/bin/sh

truffle compile

web3j truffle generate build/contracts/DeviceManager.json -o . -p io.anyledger
