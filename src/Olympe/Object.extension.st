Extension { #name : #Object }

{ #category : #'*Olympe' }
Object class >> type [
	^ OLDerivativeType typeFor: self
]
