Class {
	#name : #OLAbstractyRepository,
	#superclass : #Object,
	#category : #'Olympe-Core'
}

{ #category : #abstract }
OLAbstractyRepository >> atHash: aHash put: aValue [
	self subclassResponsibility 
]

{ #category : #abstract }
OLAbstractyRepository >> atName: aHash put: aValue [
	self subclassResponsibility 
]

{ #category : #abstract }
OLAbstractyRepository >> findBlockByHash: aString ifAbsent: aBlockClosure [
	^ self
		findByHash: aString
		ifPresent: [ :v | v findByName: #block ]
		ifAbsent: aBlockClosure
]

{ #category : #abstract }
OLAbstractyRepository >> findBlockByHash: aString ifPresent: aBlock ifAbsent: aBlockClosure [
	^ self
		findByHash: aString
		ifPresent: [ :v | aBlock cull: (v findByName: #block) ]
		ifAbsent: aBlockClosure
]

{ #category : #abstract }
OLAbstractyRepository >> findByHash: aString [
	^ self
		findByHash: aString
		ifPresent: [ :v | v ]
		ifAbsent: [ self error: 'Error looking for value ' , aString ]
]

{ #category : #abstract }
OLAbstractyRepository >> findByHash: aString ifAbsent: aBlockClosure [
	^ self
		findByHash: aString
		ifPresent: [ :v | v ]
		ifAbsent: aBlockClosure
]

{ #category : #abstract }
OLAbstractyRepository >> findByHash: aString ifPresent: aBlock ifAbsent: aBlockClosure [
	^ self subclassResponsibility 
]

{ #category : #abstract }
OLAbstractyRepository >> findByName: aString [
	^ self
		findByName: aString
		ifPresent: [ :v | v ]
		ifAbsent: [ self error: 'Error looking for value ' , aString ]
]

{ #category : #abstract }
OLAbstractyRepository >> findByName: aString ifAbsent: aBlockClosure [
	^ self
		findByName: aString
		ifPresent: [ :x | x ]
		ifAbsent: aBlockClosure
]

{ #category : #abstract }
OLAbstractyRepository >> findByName: aString ifPresent: aBlock ifAbsent: aBlockClosure [
	^ self subclassResponsibility 
]

{ #category : #abstract }
OLAbstractyRepository >> findForTranscationByHash: aHash [
	self subclassResponsibility 
]

{ #category : #abstract }
OLAbstractyRepository >> install: anObject named: aName [
	self atName: aName put: anObject
]

{ #category : #abstract }
OLAbstractyRepository >> persistBlock: anOLBlock in: aRepository [
	self subclassResponsibility
]
