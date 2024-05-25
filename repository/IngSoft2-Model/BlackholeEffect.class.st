Class {
	#name : #BlackholeEffect,
	#superclass : #Effect,
	#instVars : [
		'myPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BlackholeEffect class >> isIn: aPosition [

	^self new initializeIsIn: aPosition 
]

{ #category : #action }
BlackholeEffect >> apply [
	^(myPosition ) -4.
]

{ #category : #initialization }
BlackholeEffect >> initializeIsIn: aPosition [

	myPosition := aPosition  
]
