Class {
	#name : #OLAbstractTransaction,
	#superclass : #OLObject,
	#instVars : [
		'#sender => OLTypedSlot type: OLSymbolicAddress',
		'#receiver => OLTypedSlot type: OLSymbolicAddress',
		'#message => OLTypedSlot type: OLMessageSignature',
		'#arguments => OLTypedSlot type: OLTuple'
	],
	#category : #'Olympe-Core'
}
