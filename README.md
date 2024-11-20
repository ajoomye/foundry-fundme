# Foundry Fund Me

This is the code of the FundMe project from the Cyfrin Solidity Course.

*[⭐️ Updraft | Foundry Fund Me](https://updraft.cyfrin.io/courses/foundry/foundry-fund-me/fund-me-project-setup)*

- [Foundry Fund Me](#foundry-fund-me)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
- [Usage](#usage)
  - [Deploy](#deploy)
  - [Testing](#testing)
    - [Test Coverage](#test-coverage)
- [To add in your .env](#to-add-in-your-env)


# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`


## Quickstart

```
git clone https://github.com/ajoomye/foundry-fundme
cd foundry-fundme
make
```


# Usage

## Deploy

```
forge script script/DeployFundMe.s.sol
```

## Testing

We talk about 4 test tiers in the video. 

1. Unit
2. Integration
3. Forked
4. Staging

This repo we cover #1 and #3. 


```
forge test
```

or 

```
// Only run test functions matching the specified regex pattern.

"forge test -m testFunctionName" is deprecated. Please use 

forge test --match-test testFunctionName
```

or

```
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage

```
forge coverage
```

### To add in your .env
```
1. Local Anvil RPC URL
2. Sepolia RPC URL (Alchemy for example)
3. Base Sepolia URL (Alchemy also)
4. MetaMask Account Public Key
5. Etherscan API key

Note: For the deployment using the makefile, Foundry accounts has been used without adding the Private Key to the .env file.

```