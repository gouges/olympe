Extension { #name : #Message }

{ #category : #'*Olympe' }
Message >> asExecutable [
	^ OLExecutable new
		message: self;
		yourself
]
