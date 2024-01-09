const hre = require("hardhat");

async function main() {
  const FileVaultV1 = await hre.ethers.getContractFactory("FileVaultV1")
  const fileVaultV1 = await FileVaultV1.deploy()

  await fileVaultV1.deployed()

  console.log(`NFT was deployed to: ${fileVaultV1.address}`)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
