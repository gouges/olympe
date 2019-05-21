Class {
	#name : #OLTransaction,
	#superclass : #OLObject,
	#instVars : [
		'#sender => OLSerializableSlot type: OLSymbolicAddressType type',
		'#receiver => OLSerializableSlot type: OLSymbolicAddressType type',
		'#message => OLSerializableSlot type: OLMessageSignatureType type',
		'#arguments => OLSerializableSlot type: OLTupleType type',
		'#gas => OLSerializableSlot type: Integer type'
	],
	#category : #'Olympe-Core'
}

{ #category : #accessing }
OLTransaction >> applyOn: aContext [
	| trueReceiver |
	trueReceiver := aContext findForTranscationByHash: receiver.
	(trueReceiver findByName: message) execute: self on: aContext
]

{ #category : #accessing }
OLTransaction >> arguments [
	^ arguments
]

{ #category : #accessing }
OLTransaction >> arguments: aCollection [ 
	arguments := aCollection
]

{ #category : #accessing }
OLTransaction >> gas: anInteger [ 
	gas := anInteger
]

{ #category : #accessing }
OLTransaction >> message: aString [
	message := aString
]

{ #category : #accessing }
OLTransaction >> receiver [
	^ receiver
]

{ #category : #accessing }
OLTransaction >> receiver: aString [ 
	receiver := aString
]

{ #category : #accessing }
OLTransaction >> sender [
	^ sender
]

{ #category : #accessing }
OLTransaction >> sender: anOlympe [ 
	sender := anOlympe
]
