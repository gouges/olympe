Class {
	#name : #OLUnsubmittedBlock,
	#superclass : #OLObject,
	#instVars : [
		'#header => OLSerializableSlot type: OLBlockHeader type',
		'#transactions => OLSerializableSlot type: (OLTypedCollectionType typeFor: OLTransaction) type',
		'#repository'
	],
	#category : #'Olympe-Core'
}

{ #category : #accessing }
OLUnsubmittedBlock >> header [
	^ header
]

{ #category : #accessing }
OLUnsubmittedBlock >> header: anOLBlockHeader [ 
	header := anOLBlockHeader
]

{ #category : #accessing }
OLUnsubmittedBlock >> initialize [ 
	super initialize. 
	transactions := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
OLUnsubmittedBlock >> isGenesis [
	^ header isGenesis
]

{ #category : #accessing }
OLUnsubmittedBlock >> number [
	^ header number
]

{ #category : #'as yet unclassified' }
OLUnsubmittedBlock >> parentHash [
	^ header parentHash
]

{ #category : #accessing }
OLUnsubmittedBlock >> repository [
	^ repository
]

{ #category : #accessing }
OLUnsubmittedBlock >> repository: anOLDictionaryRepository [
	repository := anOLDictionaryRepository
]

{ #category : #accessing }
OLUnsubmittedBlock >> submitTransaction: aTransaction [
	aTransaction applyOn: repository.
	transactions add: aTransaction
]

{ #category : #accessing }
OLUnsubmittedBlock >> submittableBlock [
	^ OLBlock fromUnsubmittedBlock: self
]

{ #category : #accessing }
OLUnsubmittedBlock >> transactions [
	^ transactions
]
