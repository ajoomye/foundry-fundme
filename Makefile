-include .env

build:; forge build

deploy-sepolia-test
:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url ${SEPOLIA_RPC_URL} --account MetaMaskTestAcc --sender ${MetaMaskTestAccPubKey} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv