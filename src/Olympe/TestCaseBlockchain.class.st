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
	| repo |
	super setUp.
	olympe := Olympe new.
	repo := OLDictionaryRepository new.
	olympe repository: repo
]

{ #category : #running }
TestCaseBlockchain >> testAddASecondBlock [
	| unsubmitted block |
	unsubmitted := OLTestFactory createBlockNumber: 0 parentHash: nil repository: OLDictionaryRepository new. 
	block := olympe submitBlock: unsubmitted.
	self assert: olympe bestBlock header equals: block header.
	self assert: olympe bestBlock transactions equals: block transactions.
	unsubmitted := OLTestFactory createBlockNumber: 1 parentHash: block digest repository: olympe createRepository.
	block := olympe submitBlock: unsubmitted.
	self assert: olympe bestBlock header equals: block header.
	self assert: olympe bestBlock transactions equals: block transactions
]

{ #category : #running }
TestCaseBlockchain >> testAddInitialBlock [
	| block |
	block := OLTestFactory createBlockNumber: 0 parentHash: nil repository: OLDictionaryRepository new.
	olympe submitBlock: block.
	self assert: olympe bestBlock header equals: block header.
	self assert: olympe bestBlock transactions equals: block transactions  
]

{ #category : #running }
TestCaseBlockchain >> testAddRejectNonGenesisBlockAsFirstBlock [
	| block |
	block := OLTestFactory createBlockNumber: 1 parentHash: 16racbcbc1234 repository: OLDictionaryRepository new.
	self should: [ olympe submitBlock: block ] raise: Error
]

{ #category : #running }
TestCaseBlockchain >> testFindBlockByHash [
	| block parentHash hashes |
	parentHash := nil.
	hashes := (0 to: 9)
		collect: [ :i | 
			block := OLTestFactory createBlockNumber: i parentHash: parentHash repository: olympe createRepository.
			parentHash := (olympe submitBlock: block) digest ].
	0 to: 9 do: [ :i | 
		self
			assert: i
			equals: (olympe findBlockByHash: (hashes at: i + 1)) number ]
]

{ #category : #running }
TestCaseBlockchain >> testFindBlockByHashFailsIfNone [
	| block parentHash |
	parentHash := nil.
	(0 to: 9)
		collect: [ :i | 
			block := OLTestFactory
				createBlockNumber: i
				parentHash: parentHash
				repository: olympe createRepository.
			parentHash := (olympe submitBlock: block) digest ].
	self should: [ olympe findBlockByHash: 234567890 ] raise: Error
]

{ #category : #running }
TestCaseBlockchain >> testFindBlockByNumber [
	| block parentHash |
	parentHash := nil.
	0 to: 9 do: [ :i | 
		block := OLTestFactory createBlockNumber: i parentHash: parentHash repository: olympe createRepository..
		parentHash := (olympe submitBlock: block) digest.
		self assert: olympe bestBlock header equals: block header.
		self
			assert: olympe bestBlock transactions
			equals: block transactions ].
	0 to: 9 do: [ :i | self assert: i equals: (olympe findBlockByNumber: i) number ]
]

{ #category : #running }
TestCaseBlockchain >> testFindBlockByNumberIfNone [
	| block parentHash |
	parentHash := nil.
	0 to: 9 do: [ :i | 
		block := OLTestFactory createBlockNumber: i parentHash: parentHash repository: OLDictionaryRepository new.
		parentHash := (olympe submitBlock: block) digest.
		self assert: olympe bestBlock header equals: block header.
		self
			assert: olympe bestBlock transactions
			equals: block transactions ].
	self should: [ olympe findBlockByNumber: 500 ] raise: Error
]

{ #category : #running }
TestCaseBlockchain >> testRejectSecondBlockIfWrongHash [
	| block |
	block := OLTestFactory createBlockNumber: 0 parentHash: nil repository: OLDictionaryRepository new.
	olympe submitBlock: block.
	self assert: olympe bestBlock header equals: block header.
	self assert: olympe bestBlock transactions equals: block transactions  .
	self
		should:
			[ block := OLTestFactory createBlockNumber: 1 parentHash: nil repository: OLDictionaryRepository new]
		raise: Error
]

{ #category : #running }
TestCaseBlockchain >> testRejectSecondBlockIfWrongNumber [
	| block |
	block := OLTestFactory createBlockNumber: 0 parentHash: nil repository: OLDictionaryRepository new.
	olympe submitBlock: block.
	self assert: olympe bestBlock header equals: block header.
	self assert: olympe bestBlock transactions equals: block transactions.
	self
		should:
			[ block := OLTestFactory createBlockNumber: 0 parentHash: block digest repository: OLDictionaryRepository new ]
		raise: Error
]
