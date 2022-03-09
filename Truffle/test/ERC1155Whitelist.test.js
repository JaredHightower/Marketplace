const ERC1155 = artifacts.require("ERC1155Whitelist");

contract("ERC1155Whitelist", accounts => {
    it("Should return current max limit", async () => {
        let erc1155 = await ERC1155.deployed();
        let currentMax = await erc1155.getMaxMintAmount();
        console.log(currentMax);
    })
    it("Should throw an error if user mints more then required", async () => {
        let erc1155 = await ERC1155.deployed();

        let before = await erc1155.getMaxMintAmount();
        console.log(before);

        await erc1155.updateMaxMintAmount(5);

        let after = await erc1155.getMaxMintAmount();
        console.log(after);
    })
    it("Should throw an error if you mint more then MAX", async () => {
        let erc1155 = await ERC1155.deployed();

        await erc1155.mint(accounts[1], 1, 5);
        let accountBalance = await erc1155._balanceOf(accounts[1], 1);

        console.log(accountBalance);

    })


})