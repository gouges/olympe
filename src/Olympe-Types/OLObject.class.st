Class {
	#name : #OLObject,
	#superclass : #Object,
	#category : #'Olympe-Types'
}

{ #category : #options }
OLObject class >> defaultEncoder [
	^ OLStonEncoder
]

{ #category : #encoding }
OLObject class >> encode: anOLBlockHeader into: aWriteStream [
	^ self
		encode: anOLBlockHeader
		using: self defaultEncoder instance
		into: aWriteStream
]

{ #category : #encoding }
OLObject class >> encode: anOLBlockHeader using: anEncoder into: aWriteStream [
	anEncoder encode: anOLBlockHeader into: aWriteStream
]

{ #category : #modes }
OLObject >> binary [
	^ ByteArray
		streamContents: [ :str | self defaultEncoder instance encode: self into: str ]
]

{ #category : #modes }
OLObject >> defaultEncoder [
	^ self class defaultEncoder
]

{ #category : #digest }
OLObject >> digest [
	^ (SHA256 hashMessage: self binary) hex
]
