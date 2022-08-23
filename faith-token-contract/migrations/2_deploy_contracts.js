const FaithToken = artifacts.require("FaithToken");

/* Migration script to deploy token */
module.exports = (deployer) => {
    deployer.deploy(
        FaithToken,
        "Faith", // token name,
        "FTH", // Token symbol
        10, // token decimals
        100000 // initial owner's balance
        )
}