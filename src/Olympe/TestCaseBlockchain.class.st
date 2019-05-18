Class {
	#name : #TestCaseBlockchain,
	#superclass : #TestCase,
	#instVars : [
		'olympe',
		'root'
	],
	#category : #'Olympe-Core'
}

{ #category : #running }
TestCaseBlockchain >> setUp [
	| state |
	super setUp.
	olympe := Olympe new.
	state := OLState new.
	olympe root: state
]

{ #category : #running }
TestCaseBlockchain >> testAddASecondBlock [
	| block |
	block := OLTestFactory createBlockNumber: 0 parentHash: nil.
	olympe addBlock: block.
	self assert: olympe bestBlock equals: block.
	block := OLTestFactory createBlockNumber: 1 parentHash: block sha3.
	olympe addBlock: block.
	self assert: olympe bestBlock equals: block.
]

{ #category : #running }
TestCaseBlockchain >> testAddInitialBlock [
	| block |
	block := OLTestFactory createBlockNumber: 0 parentHash: nil.
	olympe addBlock: block.
	self assert: olympe bestBlock equals: block
]

{ #category : #running }
TestCaseBlockchain >> testAddRejectNonGenesisBlockAsFirstBlock [
	| block |
	block := OLTestFactory createBlockNumber: 1 parentHash: 16racbcbc1234.
	self should: [ olympe addBlock: block ] raise: Error
]

{ #category : #running }
TestCaseBlockchain >> testFindBlockByHash [
	| block parentHash hashes |
	parentHash := nil.
	hashes := (0 to: 9) collect: [ :i | 
		block := OLTestFactory createBlockNumber: i parentHash: parentHash.
		olympe addBlock: block.
		parentHash := block sha3.].
	0 to: 9 do: [ :i | self assert: i equals: (olympe findBlockByHash: (hashes at:i)) number ].
]

{ #category : #running }
TestCaseBlockchain >> testFindBlockByHashFailsIfNone [
	| block parentHash hashes |
	parentHash := nil.
	(0 to: 9)
		collect: [ :i | 
			block := OLTestFactory createBlockNumber: i parentHash: parentHash.
			olympe addBlock: block.
			parentHash := block sha3 ].
	self should: [ olympe findBlockByHash: 234567890 ] raise: Error
]

{ #category : #running }
TestCaseBlockchain >> testFindBlockByNumber [
	| block parentHash |
	parentHash := nil.
	0 to: 9 do: [ :i | 
		block := OLTestFactory createBlockNumber: i parentHash: parentHash.
		olympe addBlock: block.
		parentHash := block sha3.
		self assert: olympe bestBlock equals: block ].
	0 to: 9 do:
		[ :i | self assert: i equals: (olympe findBlockByNumber: i) number ]
]

{ #category : #running }
TestCaseBlockchain >> testFindBlockByNumberIfNone [
	| block parentHash |
	parentHash := nil.
	0 to: 9 do: [ :i | 
		block := OLTestFactory createBlockNumber: i parentHash: parentHash.
		olympe addBlock: block.
		parentHash := block sha3.
		self assert: olympe bestBlock equals: block ].
	self should: [ olympe findBlockByNumber: 500 ] raise: Error
]

{ #category : #running }
TestCaseBlockchain >> testRejectSecondBlockIfWrongHash [
	| block |
	block := OLTestFactory createBlockNumber: 0 parentHash: nil.
	olympe addBlock: block.
	self assert: olympe bestBlock equals: block.
	self
		should:
			[ block := OLTestFactory createBlockNumber: 1 parentHash: 16r12345678 ]
		raise: Error
]

{ #category : #running }
TestCaseBlockchain >> testRejectSecondBlockIfWrongNumber [
	| block |
	block := OLTestFactory createBlockNumber: 0 parentHash: nil.
	olympe addBlock: block.
	self assert: olympe bestBlock equals: block.
	self
		should: [ block := OLTestFactory createBlockNumber: 0 parentHash: block sha3 ]
		raise: Error
]
