Class {
	#name : #OLBlockHeader,
	#superclass : #OLObject,
	#instVars : [
		'#number => OLSerializableSlot type: Integer type',
		'#parentHash => OLSerializableSlot type: OLHashType type',
		'#nonce => OLSerializableSlot type: Integer type'
	],
	#category : #'Olympe-Core'
}

{ #category : #accessing }
OLBlockHeader >> isGenesis [
	^ number = 0 and: [ parentHash isNil ]
]

{ #category : #accessing }
OLBlockHeader >> number [
	^ number
]

{ #category : #accessing }
OLBlockHeader >> number: anInteger [ 
	number := anInteger
]

{ #category : #accessing }
OLBlockHeader >> parentHash [
	^ parentHash
]

{ #category : #accessing }
OLBlockHeader >> parentHash: aHash [ 
	parentHash := aHash
]
