Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'myPosition',
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
MoonWalkEffect class >> isIn: aPosition moves: aNumberOfSquares [ 
	^self new initializeIsIn: aPosition moves: aNumberOfSquares 
]

{ #category : #action }
MoonWalkEffect >> applyIn: aGame [ 
	
	aGame moveAllButCurrentBack: n.
	^myPosition 
]

{ #category : #initialization }
MoonWalkEffect >> initializeIsIn: aPosition moves: aNumberOfSquares [ 
	myPosition := aPosition .
	n := aNumberOfSquares 
]
