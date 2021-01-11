Class {
	#name : #TestCaseBlock,
	#superclass : #TestCase,
	#category : #'Olympe-Core'
}

{ #category : #tests }
TestCaseBlock >> testAddTransaction [
	| block1 block2 tx |
	block1 := OLTestFactory createGenesisBlock.
	block2 := OLTestFactory createGenesisBlock.
	tx := OLTestFactory createTransactionSend: 2 from: OLAccount new to: OLAccount new.
	
	self assert: block1 digest equals: block2 digest.
	block1 transactions: { tx }.
	self assert: block1 transactions size equals: 1.
	self assert: block1 transactions first value equals: 2.
	self deny: block1 digest equals: block2 digest.
	block2 transactions: { tx }.
	self assert: block1 digest equals: block2 digest.
	
	block1 transactions: {}.
	block2 transactions: {}.
	self assert: block1 digest equals: block2 digest.
	
]

{ #category : #tests }
TestCaseBlock >> testGenesisHasNoParent [
	self should: [ OLBlockHeader number: 0 parentHash: 1 ] raise: Error
]

{ #category : #tests }
TestCaseBlock >> testIsGenesis [
	self
		assert: (OLTestFactory createBlockNumber: 0 parentHash: nil repository: OLDictionaryRepository new) isGenesis.
	self
		deny: (OLTestFactory createBlockNumber: 2 parentHash: 234 repository: OLDictionaryRepository new) isGenesis
]
