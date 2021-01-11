Class {
	#name : #OLStonEncoder,
	#superclass : #Object,
	#category : #'Olympe-Encoder'
}

{ #category : #accessing }
OLStonEncoder class >> instance [
	^ self new
]

{ #category : #encoding }
OLStonEncoder >> encode: anOLBlock into: aWriteStream [
	^ aWriteStream
		nextPutAll:
			(String
				streamContents: [ :str | (STON writer on: str) nextPut: anOLBlock ])
				utf8Encoded
]
