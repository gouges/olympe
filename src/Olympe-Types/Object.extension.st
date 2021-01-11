Extension { #name : #Object }

{ #category : #'*Olympe-Types' }
Object class >> type [
	^ OLDerivativeType typeFor: self
]
