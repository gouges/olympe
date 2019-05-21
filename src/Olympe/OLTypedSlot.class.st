Class {
	#name : #OLTypedSlot,
	#superclass : #InstanceVariableSlot,
	#instVars : [
		'type'
	],
	#category : #'Olympe-Slot'
}

{ #category : #initialization }
OLTypedSlot >> printOn: aStream [
	aStream
		store: self name;
		nextPutAll: ' => ';
		nextPutAll: self class name;
		nextPutAll: ' type: ';
		store: type; nextPutAll: ' type'.

]

{ #category : #accessing }
OLTypedSlot >> type [
	^ type
]

{ #category : #initialization }
OLTypedSlot >> type: aClass [
	self assert: aClass isType.
	type := aClass.
]

{ #category : #initialization }
OLTypedSlot >> write: aValue to: anObject [
	(aValue isNil or: [ type types: aValue ])
		ifFalse: [ self
				error:
					('Unexpected object type {1}. Type {2} expected'
						format:
							{aValue class printString.
							type printString}) ].
	^ super write: aValue to: anObject
]
