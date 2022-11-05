import { BaseContract } from 'ethers'
import { ethers } from 'hardhat'
import { expect, assert } from 'chai'

describe('Fixed Metaverse', () => {
    let accounts, deployer, FixedMetaverse, fixedMetaverse: BaseContract
    const tokenURI = 'someURLForNow'

    beforeEach(async () => {
        accounts = await ethers.getSigners()
        deployer = accounts[0]

        // deploy contract
        FixedMetaverse = await ethers.getContractFactory('FixedMetaverse')
        fixedMetaverse = await FixedMetaverse.deploy(tokenURI)
    })
    describe('Deployment', () => {
        it('Deploys successfully', () => {
            it('Intitializes a contract address', () => {
                const contractAddress = fixedMetaverse.address
                assert.exists(contractAddress)
            })
        })
    })
})
