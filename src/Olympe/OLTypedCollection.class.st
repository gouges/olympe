Class {
	#name : #OLTypedCollection,
	#superclass : #OLObject,
	#instVars : [
		'type',
		'collection'
	],
	#classInstVars : [
		'subtypes'
	],
	#category : #'Olympe-Types'
}

{ #category : #'as yet unclassified' }
OLTypedCollection class >> collection: aCollection typed: aType [
	| object |
	(aCollection allSatisfy: [ :o | o isKindOf: aType ])
		ifFalse: [ ^ self
				error:
					' The given collection contains objects that are not of the given type ' ].
	object := self basicNew.
	object instVarNamed: #collection put: aCollection.
	object instVarNamed: #type put: aType.
	object initialize.
	^ object
]

{ #category : #'as yet unclassified' }
OLTypedCollection class >> new [
	^ self = OLTypedCollection
		ifTrue: [ self error: 'Use collection:typed: method ' ]
		ifFalse: [ self collection: OrderedCollection new typed: self subtype ]
]

{ #category : #accessing }
OLTypedCollection class >> storeOn: aStream [
	^ self = OLTypedCollection
		ifTrue: [ super storeOn: aStream ]
		ifFalse: [ aStream
				nextPut: $(;
				nextPutAll: OLTypedCollection name;
				nextPutAll: ' typeFor: ';
				nextPutAll: self subtype name;
				nextPut: $) ]
]

{ #category : #accessing }
OLTypedCollection class >> subtype [
	self subclassResponsibility
]

{ #category : #accessing }
OLTypedCollection class >> subtypes [
	^ subtypes ifNil: [ subtypes := Dictionary new. ]
]

{ #category : #'class creation' }
OLTypedCollection class >> typeFor: aClass [
	^ self subtypes
		at: aClass
		ifAbsentPut: [ | class |
			class := OLTypedCollection
				subclass: self name , aClass name
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'Olympe-Generated'.
			class class
				compile:
					('subtype 
				^ {1}' format: {aClass name})
				classified: #generated.
			class ]
]

{ #category : #adding }
OLTypedCollection >> add: aValue [
	(aValue isKindOf: type)
		ifFalse: [ ^ self
				error:
					('Unexpected object type {1}. Type {2} expected'
						format:
							{aValue class printString.
							type printString}) ].
	^ collection add: aValue
]

{ #category : #adding }
OLTypedCollection >> remove: anObject [
	^ collection remove: anObject 
]
