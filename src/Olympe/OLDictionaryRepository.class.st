Class {
	#name : #OLDictionaryRepository,
	#superclass : #OLAbstractyRepository,
	#instVars : [
		'content',
		'parent'
	],
	#category : #'Olympe-Core'
}

{ #category : #abstract }
OLDictionaryRepository >> at: aKey put: aValue [
	self content at: aKey put: aValue
]

{ #category : #abstract }
OLDictionaryRepository >> atHash: aHash put: aValue [
	self at: aHash put: aValue
]

{ #category : #abstract }
OLDictionaryRepository >> atName: aHash put: aValue [
	self at: aHash put: aValue
]

{ #category : #accessing }
OLDictionaryRepository >> content [
	^ content ifNil: [ content := Dictionary new ]
]

{ #category : #creating }
OLDictionaryRepository >> createChild [
	^ self class new
		parent: self;
		yourself
]

{ #category : #abstract }
OLDictionaryRepository >> findByHash: aString ifPresent: aBlock ifAbsent: aBlockClosure [
	^ self content
		at: aString
		ifPresent: [ :v | aBlock cull: v ]
		ifAbsent: [ parent
				ifNil: [ aBlockClosure value ]
				ifNotNil: [ parent findByHash: aString ifPresent: aBlock ifAbsent: aBlockClosure ] ]
]

{ #category : #abstract }
OLDictionaryRepository >> findByName: aString ifPresent: aBlock ifAbsent: aBlockClosure [
	^ self findByHash: aString ifPresent: aBlock ifAbsent: aBlockClosure
]

{ #category : #abstract }
OLDictionaryRepository >> findForTranscationByHash: aHash [
	| comesFromParent object |
	comesFromParent := false.
	object := self content
		at: aHash
		ifAbsent: [ comesFromParent := true.
			parent
				ifNil: [ self error: 'Not found' ]
				ifNotNil: [ parent findByHash: aHash ] ].
	comesFromParent
		ifTrue: [ object := object copy.
			self atHash: aHash put: object ].
	^ object
]

{ #category : #accessing }
OLDictionaryRepository >> initialize [
	super initialize.
	content := Dictionary new.
	self atName: #self put: self.
	self atName: #parent put: parent.
	self
		atName: #install:named:
		put: (Message selector: #install:named:) asExecutable.
	self
		atName: #removeNamed:
		put: (Message selector: #removeNamed:) asExecutable
]

{ #category : #accessing }
OLDictionaryRepository >> parent [
	^ parent
]

{ #category : #accessing }
OLDictionaryRepository >> parent: anOLDictionaryRepository [ 
	parent := anOLDictionaryRepository
]

{ #category : #abstract }
OLDictionaryRepository >> persistBlock: anOLBlock in: aRepository [
	^ self content
		at: anOLBlock digest
		ifPresent: [ self error: ' There is already a block persisted with this hash!!' ]
		ifAbsentPut: [ aRepository
				at: #block put: anOLBlock;
				yourself ]
]

{ #category : #abstract }
OLDictionaryRepository >> postCopy [ 
	content := content copy.
	parent := parent copy.
]
