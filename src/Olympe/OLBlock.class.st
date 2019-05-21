Class {
	#name : #OLBlock,
	#superclass : #OLObject,
	#instVars : [
		'#header => OLSerializableSlot type: OLBlockHeader type',
		'#transactions => OLSerializableSlot type: (OLTypedCollectionType typeFor: OLTransaction) type'
	],
	#category : #'Olympe-Core'
}

{ #category : #'instance creation' }
OLBlock class >> fromUnsubmittedBlock: anUnsubmittedBlock [
	^ self new
		header: anUnsubmittedBlock header;
		transactions: anUnsubmittedBlock transactions;
		yourself
]

{ #category : #accessing }
OLBlock >> header [
	^ header
]

{ #category : #accessing }
OLBlock >> header: aHeader [
	header := aHeader.
]

{ #category : #testing }
OLBlock >> isGenesis [
	^ header isGenesis
]

{ #category : #accessing }
OLBlock >> number [
	^ header number
]

{ #category : #accessing }
OLBlock >> parentHash [
	^ header parentHash
]

{ #category : #accessing }
OLBlock >> transactions [
	^ transactions
]

{ #category : #accessing }
OLBlock >> transactions: aCol [
	transactions := aCol
]
