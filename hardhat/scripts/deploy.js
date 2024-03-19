const { ethers, upgrades } = require("hardhat");

async function main() {
  const bookingProxy = await ethers.getContractFactory("BookingProxy");
  const proxy = await upgrades.deployProxy(bookingProxy, [23]);
  await proxy.deployed();

  console.log(proxy.target);
}
main();