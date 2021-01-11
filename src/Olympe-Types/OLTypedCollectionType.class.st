Class {
	#name : #OLTypedCollectionType,
	#superclass : #OLType,
	#instVars : [
		'subtype'
	],
	#classInstVars : [
		'subtypes'
	],
	#category : #'Olympe-Types'
}

{ #category : #accessing }
OLTypedCollectionType class >> subtypes [
	^ subtypes ifNil: [ subtypes := Dictionary new. ]
]

{ #category : #'class creation' }
OLTypedCollectionType class >> typeFor: aClass [
	^ self subtypes
		at: aClass
		ifAbsentPut: [ OLTypedCollectionType new
				subtype: aClass;
				yourself ]
]

{ #category : #'instance creation' }
OLTypedCollectionType >> new [
	^ subtype
		ifNil: [ self error: 'Use collection:typed: method ' ]
		ifNotNil:
			[ OLTypedCollection collection: OrderedCollection new typed: subtype ]
]

{ #category : #'instance creation' }
OLTypedCollectionType >> storeOn: aStream [
	^ aStream
		nextPut: $(;
		nextPutAll: OLTypedCollectionType name;
		nextPutAll: ' typeFor: ';
		nextPutAll: subtype name;
		nextPut: $)
]

{ #category : #accessing }
OLTypedCollectionType >> subtype [
	^ subtype
]

{ #category : #'instance creation' }
OLTypedCollectionType >> subtype: aSubtype [
	subtype := aSubtype
]

{ #category : #accessign }
OLTypedCollectionType >> type [
	^ self
]

{ #category : #'instance creation' }
OLTypedCollectionType >> types: aTypedCollection [
	^ aTypedCollection species = OLTypedCollection
		and: [ aTypedCollection innerType = subtype ]
]
