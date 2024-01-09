const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("FileVaultV1", function () {
  let FileVaultV1;
  let fileVaultV1;
  let owner;
  let addr1;
  let addrs;

  beforeEach(async function () {
    FileVaultV1 = await ethers.getContractFactory("FileVaultV1");
    [owner, addr1, ...addrs] = await ethers.getSigners();
    fileVaultV1 = await FileVaultV1.deploy();
    await fileVaultV1.deployed();
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await fileVaultV1.owner()).to.equal(owner.address);
    });

    it("Should assign the total files count to zero", async function () {
      const totalFilesCount = await fileVaultV1.getTotalFilesCount();
      expect(totalFilesCount).to.equal(0);
    });
  });

  describe("Transactions", function () {
    it("Should fail if non-owner tries to upload a file", async function () {
      await expect(fileVaultV1.connect(addr1).uploadFile("file1", "hash1", "description1", "type1", 100, true)).to.be.revertedWith("Only the owner have the permission!");
    });

    it("Should allow owner to upload a file", async function () {
      await fileVaultV1.connect(owner).uploadFile("file1", "hash1", "description1", "type1", 100, true);
      const totalFilesCount = await fileVaultV1.getTotalFilesCount();
      expect(totalFilesCount).to.equal(1);
    });

    it("Should allow owner to toggle file privacy", async function () {
      await fileVaultV1.connect(owner).uploadFile("file1", "hash1", "description1", "type1", 100, true);
      await fileVaultV1.connect(owner).toggleIsPrivate(1);
      const file = await fileVaultV1.getFileById(1);
      expect(file.isPrivate).to.equal(false);
    });

    it("Should allow owner to transfer ownership", async function () {
      await fileVaultV1.connect(owner).transferOwnership(addr1.address);
      expect(await fileVaultV1.owner()).to.equal(addr1.address);
    });
  });
});