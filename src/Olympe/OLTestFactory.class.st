Class {
	#name : #OLTestFactory,
	#superclass : #Object,
	#category : #'Olympe-Core'
}

{ #category : #factory }
OLTestFactory class >> createBlockNumber: anInteger parentHash: aHash [
	^ OLBlock new
		header:
			(OLBlockHeader new
				number: anInteger;
				parentHash: aHash;
				yourself) yourself;
		yourself
]
