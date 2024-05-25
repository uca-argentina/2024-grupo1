Class {
	#name : #HyperSpaceJumpEffect,
	#superclass : #Effect,
	#instVars : [
		'myPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
HyperSpaceJumpEffect class >> isIn: aPosition [

 ^self new initializeIsIn: aPosition 
]

{ #category : #action }
HyperSpaceJumpEffect >> applyIn: aGame [ 
	aGame decreaseShieldByOne.
	^myPosition +4
]

{ #category : #initialization }
HyperSpaceJumpEffect >> initializeIsIn: aPosition [ 
	myPosition := aPosition 
]
