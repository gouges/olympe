Class {
	#name : #OLModule,
	#superclass : #OLAbstractyRepository,
	#instVars : [
		'state'
	],
	#category : #'Olympe-Core'
}

{ #category : #abstract }
OLModule >> atHash: aHash put: aValue [
	^ state atHash: aHash put: aValue
]

{ #category : #abstract }
OLModule >> atName: aHash put: aValue [
	^ state atName: aHash put: aValue
]

{ #category : #abstract }
OLModule >> findByHash: aString ifPresent: aBlockClosure ifAbsent: aBlockClosure3 [ 
	^ state findByHash: aString ifPresent: aBlockClosure ifAbsent: aBlockClosure3 
]

{ #category : #abstract }
OLModule >> findByName: aString ifPresent: aBlockClosure ifAbsent: aBlockAbsent [
	^ state
		findByName: aString
		ifPresent: aBlockClosure
		ifAbsent: [ (self class lookupSelector: aString)
				ifNil: [ aBlockAbsent value ]
				ifNotNil:
					[ :v | aBlockClosure cull: (Message selector: aString asSymbol) asExecutable ] ]
]

{ #category : #abstract }
OLModule >> persistBlock: anOLBlock in: aRepository [
	self shouldNotImplement 
]

{ #category : #abstract }
OLModule >> postCopy [
	state := state copy.
	^ self 
]

{ #category : #access }
OLModule >> state [
	^ state
]
