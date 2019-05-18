Class {
	#name : #OLBlock,
	#superclass : #OLObject,
	#instVars : [
		'#header => OLTypedSlot type: OLBlockHeader',
		'#transactions => OLTypedSlot type: (OLTypedCollection typeFor: OLTransaction)'
	],
	#category : #'Olympe-Core'
}

{ #category : #digest }
OLBlock >> digest [
	^ SHA256 hashMessage: self binary.
]

{ #category : #accessing }
OLBlock >> header: anOLBlockHeader [ 
	header := anOLBlockHeader
]

{ #category : #'as yet unclassified' }
OLBlock >> header: aHeader transactions: aCollection [
	header := aHeader .
	transactions := aCollection.
	
]

{ #category : #'as yet unclassified' }
OLBlock >> parentHash [
	^ header parentHash
]
