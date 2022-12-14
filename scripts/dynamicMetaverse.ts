import { ethers } from 'hardhat'

async function main() {
    // get deployer's account
    const [owner] = await ethers.getSigners()

    // deploy contract
    const DynamicMetaverse = await ethers.getContractFactory('DynamicMetaverse')
    const dynamicMetaverse = await DynamicMetaverse.deploy()

    // wait for deployment
    await dynamicMetaverse.deployed()

    // check construction quantities
    const goldQty = await dynamicMetaverse.balanceOf(owner.address, 0)
    const silverQty = await dynamicMetaverse.balanceOf(owner.address, 1)
    const lancelotsSwordQty = await dynamicMetaverse.balanceOf(owner.address, 2)

    // get globalURI from the chain and tailor to gold
    const globalUri = await dynamicMetaverse.uri(0)
    const goldUri = globalUri.replace('{id}', '0')

    console.log(`\n Metaverse contract deployed with: 
        Contract address: ${dynamicMetaverse.address}\n 
        Gold: ${goldQty} 
        Silver: ${silverQty} 
        Lancelot's Sword: ${lancelotsSwordQty}
        Gold URI: ${goldUri} \n`)
}

main().catch(error => {
    console.error(error)
    process.exitCode = 1
})
