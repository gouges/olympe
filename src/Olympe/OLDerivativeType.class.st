Class {
	#name : #OLDerivativeType,
	#superclass : #OLType,
	#instVars : [
		'type'
	],
	#classInstVars : [
		'subtypes'
	],
	#category : #'Olympe-Types'
}

{ #category : #'class creation' }
OLDerivativeType class >> subtypes [
	^ subtypes ifNil: [ subtypes := Dictionary new. ]
]

{ #category : #'class creation' }
OLDerivativeType class >> typeFor: aClass [
	^ self subtypes
		at: aClass
		ifAbsentPut: [ OLDerivativeType new
				type: aClass;
				yourself ]
]

{ #category : #printing }
OLDerivativeType >> storeOn: aStream [
	^ aStream
		nextPutAll: type name
]

{ #category : #accessing }
OLDerivativeType >> type: aClass [ 
	type := aClass
]

{ #category : #testing }
OLDerivativeType >> types: anOLBlockHeader [
	^ anOLBlockHeader species = type
]
