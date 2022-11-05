import { ethers } from 'hardhat'

async function main() {
    // get deployer's account
    const [owner] = await ethers.getSigners()

    // deploy contract
    const FixedMetaverse = await ethers.getContractFactory('FixedMetaverse')
    const tokenURI = 'someURLForNow'
    const fixedMetaverse = await FixedMetaverse.deploy(tokenURI)

    // wait for deployment
    await fixedMetaverse.deployed()

    // check construction quantities
    const goldQty = await fixedMetaverse.balanceOf(owner.address, 0)
    const silverQty = await fixedMetaverse.balanceOf(owner.address, 1)
    const lancelotsSwordQty = await fixedMetaverse.balanceOf(owner.address, 2)

    console.log(`\n Metaverse contract deployed with: \n
        Gold: ${goldQty} 
        Silver: ${silverQty} 
        Lancelot's Sword: ${lancelotsSwordQty} \n`)
}

main().catch(error => {
    console.error(error)
    process.exitCode = 1
})
