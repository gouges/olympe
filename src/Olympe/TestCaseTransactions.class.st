Class {
	#name : #TestCaseTransactions,
	#superclass : #TestCase,
	#instVars : [
		'olympe',
		'transaction',
		'object',
		'block'
	],
	#category : #'Olympe-Core'
}

{ #category : #running }
TestCaseTransactions >> setUp [
	| repo |
	super setUp.
	olympe := Olympe new.
	repo := OLDictionaryRepository new.
	olympe repository: repo.
	object := OLDummyTestObject new.
	transaction := OLTestFactory
		createTransactionSender: #self
		receiver: #self
		message: #install:named:
		arguments:
			{object.
			#object}.
	olympe submitBlock: OLTestFactory createGenesisBlock.
	block := OLTestFactory
		createBlockNumber: 1
		parentHash: olympe bestBlock digest
		repository: olympe createRepository.

]

{ #category : #running }
TestCaseTransactions >> testSecondTransactionAppliesOverFirstSideEffectInDifferentblock [
	| newBlock | 
	block submitTransaction: transaction.
	self assert: (block repository findByName: #object) equals: object.
	self assert: (block repository findByName: #object) value isNil.
	
	
	olympe addBlock: block.
	
	transaction := OLTestFactory
		createTransactionSender: #self
		receiver: #object
		message: #value:
		arguments: {3}.
	newBlock := OLTestFactory
		createBlockNumber: 2
		parentHash: olympe bestBlock digest
		repository: olympe createRepository.
	
	newBlock submitTransaction: transaction.
	self assert: (block repository findByName: #object) equals: object.
	self assert: (block repository findByName: #object) value isNil.
	self deny: (newBlock repository findByName: #object) equals: object.
	self assert: (newBlock repository findByName: #object) value equals: 3
]

{ #category : #running }
TestCaseTransactions >> testSecondTransactionAppliesOverFirstSideEffectInTheSameblock [
	block submitTransaction: transaction.
	transaction := OLTestFactory
		createTransactionSender: #self
		receiver: #object
		message: #value:
		arguments: {3}.
	self assert: (block repository findByName: #object) equals: object.
	self assert: (block repository findByName: #object) value isNil.
	block submitTransaction: transaction.
	self assert: (block repository findByName: #object) equals: object.
	self assert: (block repository findByName: #object) value equals: 3
]

{ #category : #running }
TestCaseTransactions >> testTransactionAppliesOnAdd [
	(olympe repositoryFor: olympe bestBlock)
		findByName: #object
		ifPresent: [ self fail ]
		ifAbsent: [ self assert: true ].
	block submitTransaction: transaction.
	block repository
		findByName: #object
		ifPresent: [ :o | self assert: o equals: object ]
		ifAbsent: [ self fail ]
]
