Class {
	#name : #OLTestFactory,
	#superclass : #Object,
	#category : #'Olympe-Core'
}

{ #category : #factory }
OLTestFactory class >> createBlockNumber: anInteger parentHash: aHash [
	anInteger = 0
		ifTrue: [ self assert: aHash isNil ].
	aHash isNil
		ifTrue: [ self assert: anInteger = 0 ].
	^ OLUnsubmittedBlock new
		repository: OLDictionaryRepository new;
		header:
			(OLBlockHeader new
				number: anInteger;
				parentHash: aHash;
				yourself) yourself;
		yourself
]

{ #category : #factory }
OLTestFactory class >> createBlockNumber: anInteger parentHash: aHash repository: aRepository [
	anInteger = 0
		ifTrue: [ self assert: aHash isNil ].
	aHash isNil
		ifTrue: [ self assert: anInteger = 0 ].
	^ OLUnsubmittedBlock new
		repository: aRepository;
		header:
			(OLBlockHeader new
				number: anInteger;
				parentHash: aHash;
				yourself) yourself;
		yourself
]

{ #category : #creatintg }
OLTestFactory class >> createGenesisBlock [
	^ self createBlockNumber: 0 parentHash: nil repository: OLDictionaryRepository new
]

{ #category : #creating }
OLTestFactory class >> createTransactionSender: aSender receiver: aReceiver message: aSelector arguments: aCollection [
	^ OLTransaction new
		sender: aSender;
		receiver: aReceiver;
		message: aSelector;
		arguments: aCollection;
		gas: 100
]
