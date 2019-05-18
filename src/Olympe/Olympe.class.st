Class {
	#name : #Olympe,
	#superclass : #Object,
	#instVars : [
		'root',
		'bestBlock'
	],
	#category : #'Olympe-Core'
}

{ #category : #accessing }
Olympe >> addBlock: anOLBlock [
	self
		findBlockByHash: anOLBlock digest
		ifNone: [ 
			anOLBlock number > 0 ifTrue: [
				(self findBlockByHash: anOLBlock parentHash) number + 1 = anOLBlock number ifFalse: [ 
					^ self error: 'Unconsistent number' 
				]
			].
			self privatePersistBlock: anOLBlock.
			(bestBlock isNil or: [ bestBlock number < anOLBlock number ]) ifTrue: [ 
				bestBlock := anOLBlock  
			].
		]
]

{ #category : #accessing }
Olympe >> root: anOLState [ 
	root := anOLState
]
