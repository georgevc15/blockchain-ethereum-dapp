var wallet = artifacts.require("./MyWallet.sol");

contract("MyWallet", function(accounts) {
	it('should be possible to transfer money to this accounts', function() {
		var contractInstance;
		wallet.deployed().then(function(instance) {
			contractInstance = instance;
			return contractInstance.sendTransaction({value: web3.toWei(10, 'ether'), address:contractInstance.address, from: accounts[0]});
		}).then(function(result) {
			assert.equal(web3.eth.getBalance(contractInstance.address).toNumber(), web3.toWei(10, 'ether'), 'The Balance is the same');
		});
	});
});