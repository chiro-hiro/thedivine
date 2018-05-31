'use strict';

var TheDivine = artifacts.require('TheDivine');
var instanceTheDivine;

contract('TheDivine', function (accounts) {

    it('The Divine should product 1000 sample without duplicated', async function () {
        let samples = [];
        instanceTheDivine = await TheDivine.deployed().then(function (instance) {
            return instance;
        });
        for (let i = 0; i < 1000; i++) {
            //Trigger smart contract
            await instanceTheDivine.rand();
            let randomness = await instanceTheDivine.rand.call();
            assert.equal(samples.indexOf(randomness.valueOf()), -1);
            samples.push(randomness.valueOf());
            console.log("      New random value from The Divine:", randomness.valueOf());
        }
    });

});
