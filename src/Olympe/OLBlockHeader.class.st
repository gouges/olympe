Class {
	#name : #OLBlockHeader,
	#superclass : #OLObject,
	#instVars : [
		'#number => OLTypedSlot type: Integer',
		'#parentHash => OLTypedSlot type: OLHash',
		'#hash => OLTypedSlot type: OLHash',
		'#nonce => OLTypedSlot type: Integer'
	],
	#category : #'Olympe-Core'
}

{ #category : #accessing }
OLBlockHeader >> number: anInteger [ 
	number := anInteger
]

{ #category : #accessing }
OLBlockHeader >> parentHash: aHash [ 
	parentHash := aHash
]
