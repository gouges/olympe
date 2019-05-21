Class {
	#name : #OLDummyTestObject,
	#superclass : #OLModule,
	#instVars : [
		'value'
	],
	#category : #'Olympe-Core'
}

{ #category : #initialization }
OLDummyTestObject >> initialize [
	super initialize .
	state := OLDictionaryRepository new
]

{ #category : #initialization }
OLDummyTestObject >> value [
	^ state findByName: #value ifAbsent: [ nil ]
]

{ #category : #initialization }
OLDummyTestObject >> value: aValue [
	state atName:#value put: aValue
]
