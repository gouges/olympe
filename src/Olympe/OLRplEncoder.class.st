Class {
	#name : #OLRplEncoder,
	#superclass : #Object,
	#category : #'Olympe-Encoder'
}

{ #category : #creation }
OLRplEncoder class >> instance [
	^ self new
]

{ #category : #encoding }
OLRplEncoder >> encode: anOLObject [ 
	(anOLObject class slots select: [: t | t isSerializable ] )flatCollect: [ : s | s type s read: anOLObject  ] 
]

{ #category : #encoder }
OLRplEncoder >> encode: anOLObject into: aWriteStream [
	^ (anOLObject class slots select: [ :t | t isSerializable ])
		flatCollect: [ :s | s serialize: anOLObject using: self into: aWriteStream ]
]
