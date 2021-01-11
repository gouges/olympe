Class {
	#name : #OLExecutable,
	#superclass : #OLObject,
	#instVars : [
		'message'
	],
	#category : #'Olympe-ProtoCore'
}

{ #category : #executing }
OLExecutable >> execute: anOLTransaction on: aContext [
	| trueReceiver trueSender |
	trueReceiver := aContext findByHash: anOLTransaction receiver.
	trueSender := aContext findByHash: anOLTransaction sender.
	message arguments: anOLTransaction arguments.
	message sendTo: trueReceiver 
]

{ #category : #accessing }
OLExecutable >> message: aMessage [ 
	message := aMessage
]
