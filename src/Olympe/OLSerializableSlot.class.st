Class {
	#name : #OLSerializableSlot,
	#superclass : #OLTypedSlot,
	#category : #'Olympe-Slot'
}

{ #category : #testing }
OLSerializableSlot >> isSerializable [
	^ true .
]

{ #category : #serializing }
OLSerializableSlot >> serialize: anOLObject using: anEncoder into: aWriteStream [
	self type
		encode: (self read: anOLObject)
		using: anEncoder
		into: aWriteStream
]
