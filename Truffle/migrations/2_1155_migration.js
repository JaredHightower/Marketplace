
const ERC1155Whitelist = artifacts.require("ERC1155Whitelist");

module.exports = function (deployer) {
    deployer.deploy(ERC1155Whitelist);
};