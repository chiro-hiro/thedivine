var Migrations = artifacts.require("./Migrations.sol");
var TheDivine = artifacts.require("./TheDivine.sol");

module.exports = function (deployer) {
    deployer.deploy(Migrations);
    deployer.deploy(TheDivine);
};
