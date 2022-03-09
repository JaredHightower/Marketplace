// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract ERC1155Whitelist is ERC1155, Ownable {
  string public name;
  string public symbol;
  uint256 public totalSupply = 7777;
  uint256 public maxMintAmountPerTx = 3;

  mapping(uint => string) public tokenURI;
  constructor() ERC1155("") {
    name = "Whitelist Tickets";
    symbol = "WHLT";
  }

  modifier mintCompliance(uint256 _mintAmount) {
    require(_mintAmount > 0 && _mintAmount <= maxMintAmountPerTx, "Invalid mint amount!");
    _;
  }

  function _balanceOf(address account, uint256 id) public view returns(uint256){
        return balanceOf(account, id);
    }

  function getMaxMintAmount() public view returns(uint256) {
    return maxMintAmountPerTx;
  }

  function updateMaxMintAmount(uint256 _newLimitAmount) public onlyOwner {
    maxMintAmountPerTx = _newLimitAmount;
  }

  function mint(address _to, uint _id, uint _amount) external onlyOwner mintCompliance(_amount) {
    _mint(_to, _id, _amount, "");
  }


  function mintBatch(address _to, uint[] memory _ids, uint[] memory _amounts) external onlyOwner {
    _mintBatch(_to, _ids, _amounts, "");
  }

  function burn(uint _id, uint _amount) external {
    _burn(msg.sender, _id, _amount);
  }

  function burnBatch(uint[] memory _ids, uint[] memory _amounts) external {
    _burnBatch(msg.sender, _ids, _amounts);
  }

  function burnForMint(
      address _from,
      uint[] memory _burnIds,
      uint[] memory _burnAmounts,
      uint[] memory _mintIds,
      uint[] memory _mintAmounts
    ) external onlyOwner {
    _burnBatch(_from, _burnIds, _burnAmounts);
    _mintBatch(_from, _mintIds, _mintAmounts, "");
  }

  function setURI(uint _id, string memory _uri) external onlyOwner {
    tokenURI[_id] = _uri;
    emit URI(_uri, _id);
  }

  function uri(uint _id) public view override returns (string memory) {
    return tokenURI[_id];
  }

  function withdraw() public onlyOwner {
    require(address(this).balance > 0, "Balance is 0");
    payable(owner()).transfer(address(this).balance);
  }
}