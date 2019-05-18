Class {
	#name : #OLObject,
	#superclass : #Object,
	#category : #'Olympe-Core'
}

{ #category : #options }
OLObject class >> defaultEncoder [
	^ OLRplEncoder
]

{ #category : #modes }
OLObject >> binary [
	^ self defaultEncoder encode: self
]

{ #category : #modes }
OLObject >> defaultEncoder [
	^ self class defaultEncoder
]
