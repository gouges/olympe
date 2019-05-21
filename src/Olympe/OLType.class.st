Class {
	#name : #OLType,
	#superclass : #OLObject,
	#category : #'Olympe-Types'
}

{ #category : #encoding }
OLType class >> encode: anInteger into: aWriteStream [
	self shouldNotImplement
]

{ #category : #encoding }
OLType class >> encode: anOLBlockHeader using: anEncoder into: aWriteStream [
]

{ #category : #encoding }
OLType class >> isType [
	^ true
]

{ #category : #encoding }
OLType class >> type [
	^ self
]

{ #category : #encoding }
OLType class >> types: aValue [
	^ aValue species = self
]

{ #category : #testing }
OLType >> isType [
	^ true
]
