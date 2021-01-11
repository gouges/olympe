Class {
	#name : #BaselineOfOlympe,
	#superclass : #BaselineOf,
	#category : #BaselineOfOlympe
}

{ #category : #baselines }
BaselineOfOlympe >> baseline: spec [
	<baseline>
	spec package: #'Olympe-Slot'.
	spec package: #'Olympe-Types' with: [ spec requires: #'Olympe-Slot' ].
	spec package: #'Olympe-ProtoCore' with: [ spec requires:  #'Olympe-Types' ].
	spec package: #'Olympe' with: [ spec requires:  #'Olympe-ProtoCore' ].
]
