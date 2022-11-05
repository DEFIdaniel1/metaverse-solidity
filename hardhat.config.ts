import { HardhatUserConfig } from 'hardhat/config'
import '@nomiclabs/hardhat-ethers'
import '@nomicfoundation/hardhat-toolbox'
import 'hardhat-deploy'
import 'hardhat-gas-reporter'
import 'ethers'
import 'hardhat-gas-reporter'
require('dotenv').config()

const RINKEBY_URL = process.env.RINKEBY_URL || 'rinkeby-key'
const POLYGON_TEST_URL = process.env.POLYGON_TEST_URL || 'rinkeby-key'
const PRIVATE_KEY = process.env.PRIVATE_KEY || '0x0noKey'
const ETHERSCAN_API = process.env.ETHERSCAN_API || 'etherscan-key'
const COINMARKETCAP_API = process.env.COINMARKETCAP_API || 'coinmarketcap-key'
const GOERLI_URL = process.env.GOERLI_URL || 'goerli-url'

const config: HardhatUserConfig = {
    solidity: {
        compilers: [{ version: '0.8.9' }]
    },
    defaultNetwork: 'hardhat',
    networks: {
        polygonTest: {
            url: POLYGON_TEST_URL,
            accounts: [PRIVATE_KEY],
            chainId: 80001
        },
        localhost: {
            url: 'http://127.0.0.1:8545/',
            chainId: 31337
        },
        goerli: {
            url: GOERLI_URL,
            accounts: [PRIVATE_KEY],
            chainId: 5
        }
    },
    etherscan: {
        apiKey: ETHERSCAN_API
    },
    gasReporter: {
        enabled: true,
        outputFile: 'gas-report.txt',
        noColors: true,
        coinmarketcap: COINMARKETCAP_API,
        currency: 'USD'
        // token: 'MATIC',
    },
    namedAccounts: {
        deployer: {
            default: 0,
            4: 0
        },
        player1: {
            default: 1,
            4: 1
        }
    },
    mocha: {
        timeout: 500000
    }
}

export default config
