FROM hyperledger/fabric-peer

COPY contracts/ /contracts/


CMD ["peer", "chaincode", "install", "-n", "device_manager" "-p", "/contracts/"]
CMD ["peer", "node", "start"]