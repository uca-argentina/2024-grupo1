Class {
	#name : #HyperJumpEffect,
	#superclass : #Effect,
	#instVars : [
		'myPosition',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
HyperJumpEffect class >> isIn: aSquare movesParsecs: someParsecs [ 
	^self new initializeIsIn: aSquare  movesParsecs: someParsecs 
]

{ #category : #action }
HyperJumpEffect >> applyIn: aGame [ 

^myPosition + parsecs
]

{ #category : #initialization }
HyperJumpEffect >> initializeIsIn: aSquare movesParsecs: someParsecs [ 
	myPosition := aSquare .
	parsecs := someParsecs 
]
