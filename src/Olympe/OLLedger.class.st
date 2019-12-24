Class {
	#name : #OLLedger,
	#superclass : #OLModule,
	#category : #'Olympe-Core'
}

{ #category : #initialization }
OLLedger >> balanceFor: anAccount [
	^ state findByHash: anAccount ifPresent: [ :v | v ] ifAbsent: [ 0 ]
]

{ #category : #initialization }
OLLedger >> initialize [
	super initialize .
	state := OLDictionaryRepository new
]

{ #category : #initialization }
OLLedger >> mint: aValue for: anAccount [
	| value |
	value := state
		findByHash: anAccount
		ifPresent: [ :v | v + aValue ]
		ifAbsent: [ aValue ].
	state at: anAccount put: value
]
