Class {
	#name : #TestCaseTransactionsSpending,
	#superclass : #TestCase,
	#instVars : [
		'olympe',
		'root',
		'ledger',
		'transaction',
		'block'
	],
	#category : #'Olympe-Core'
}

{ #category : #running }
TestCaseTransactionsSpending >> setUp [
	| repo |
	super setUp.
	olympe := Olympe new.
	repo := OLDictionaryRepository new.
	olympe repository: repo.
	ledger := OLLedger new.
	transaction := OLTestFactory
		createTransactionSender: #self
		receiver: #self
		message: #install:named:
		arguments:
			{ledger.
			#ledger}.
	olympe submitBlock: OLTestFactory createGenesisBlock.
	block := OLTestFactory
		createBlockNumber: 1
		parentHash: olympe bestBlock digest
		repository: olympe createRepository
]

{ #category : #running }
TestCaseTransactionsSpending >> testTransactionApplied [
	| submitted |
	" Createing the ledger "
	block submitTransaction: transaction.
	submitted := olympe submitBlock: block.
	self
		assert: ((block repository findByName: #ledger) balanceFor: 'receiver')
		equals: 0.
	" New block minting money "
	block := OLTestFactory
		createBlockNumber: 2
		parentHash: olympe bestBlock digest
		repository: olympe createRepository.
	transaction := OLTransaction new.
	transaction
		sender: 'self';
		receiver: #ledger;
		message: #mint:for:;
		arguments: {20 . 'receiver'}.
	block submitTransaction: transaction.
	olympe submitBlock: block.
	self
		assert: ((block repository findByName: #ledger) balanceFor: 'receiver')
		equals: 20.
	" New block minting money "
	block := OLTestFactory
		createBlockNumber: 3
		parentHash: olympe bestBlock digest
		repository: olympe createRepository.
	transaction := OLTransaction new.
	transaction
		sender: 'self';
		receiver: #ledger;
		message: #mint:for:;
		arguments: {20 . 'receiver'}.
	block submitTransaction: transaction.
	olympe submitBlock: block.
	self
		assert: ((block repository findByName: #ledger) balanceFor: 'receiver')
		equals: 40.
	self halt.
	

]
