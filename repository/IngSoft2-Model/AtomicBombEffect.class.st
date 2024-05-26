Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> applyIn: aGame [ 
	aGame moveAllBackToBeginning.
	^1
]
