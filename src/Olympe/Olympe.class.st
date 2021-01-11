Class {
	#name : #Olympe,
	#superclass : #Object,
	#instVars : [
		'repository',
		'bestBlock'
	],
	#category : #'Olympe-Core'
}

{ #category : #accessing }
Olympe >> addBlock: anOLUnsubmittedBlock [
	^ self
		findBlockByHash: anOLUnsubmittedBlock digest
		ifAbsent: [ anOLUnsubmittedBlock number > 0
				ifTrue: [ (self findBlockByHash: anOLUnsubmittedBlock parentHash) number + 1
						= anOLUnsubmittedBlock number
						ifFalse: [ ^ self error: 'Unconsistent number' ] ].
			self submitBlock: anOLUnsubmittedBlock ]
]

{ #category : #accessing }
Olympe >> bestBlock [
	^ bestBlock
]

{ #category : #accessing }
Olympe >> createBlock [

]

{ #category : #repositories }
Olympe >> createRepository [
	^ bestBlock
		ifNil: [ OLDictionaryRepository new
				beFirst;
				yourself ]
		ifNotNil: [ (repository findByHash: bestBlock digest) createChild ]
]

{ #category : #finding }
Olympe >> findBlockByHash: aString [ 
	^ self findBlockByHash: aString ifAbsent: [ self error: ' Unable to found ', aString ]
]

{ #category : #finding }
Olympe >> findBlockByHash: aHash ifAbsent: aBlockClosure [
	^ repository findBlockByHash: aHash ifAbsent: aBlockClosure
]

{ #category : #accessing }
Olympe >> findBlockByNumber: anInteger [
	^ self
		findBlockByNumber: anInteger
		ifAbsent: [ self error: ' Block not found  ' , anInteger asString ]
]

{ #category : #accessing }
Olympe >> findBlockByNumber: anInteger ifAbsent: aBlock [
	| block |
	block := bestBlock.
	[ block number = anInteger or: [ block isGenesis ] ]
		whileFalse: [ block := self findBlockByHash: block parentHash ].
	^ block number = anInteger
		ifTrue: [ block ]
		ifFalse: [ aBlock value ]
]

{ #category : #accessing }
Olympe >> findRepositoryFor: anOLBlock [
	^ repository findByHash: self bestBlock digest
]

{ #category : #persistence }
Olympe >> privatePersistBlock: anOLBlock in: aRepository [
	repository persistBlock: anOLBlock in: aRepository .
]

{ #category : #accessing }
Olympe >> privateSubmitBlock: anOLUnsubmittedBlock [
	| block |
	block := anOLUnsubmittedBlock submittableBlock.
	self privatePersistBlock: block in: anOLUnsubmittedBlock repository.
	(bestBlock isNil or: [ bestBlock number < block number ])
		ifTrue: [ bestBlock := block ].
	^ block
]

{ #category : #accessing }
Olympe >> repository [
	^ repository
]

{ #category : #finding }
Olympe >> repository: aRepository [
	repository := aRepository 
]

{ #category : #accessing }
Olympe >> repositoryFor: anOLBlock [
	^ repository findByHash: self bestBlock digest
]

{ #category : #accessing }
Olympe >> submitBlock: anOLUnsubmittedBlock [
	^ self
		findBlockByHash: anOLUnsubmittedBlock digest
		ifAbsent: [ anOLUnsubmittedBlock number > 0
				ifTrue: [ (self findBlockByHash: anOLUnsubmittedBlock parentHash) number + 1
						= anOLUnsubmittedBlock number
						ifFalse: [ ^ self error: 'Unconsistent number' ] ].
			self privateSubmitBlock: anOLUnsubmittedBlock ]
]
