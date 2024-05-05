Class {
	#name : #RealDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#classInstVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RealDie class >> of: anAmountOfFaces [
	
	anAmountOfFaces < 3 ifTrue: [ Error signal: 'Faces should be more than 2' ].
	^ self new initializeOf: anAmountOfFaces 
]

{ #category : #initialization }
RealDie >> initializeOf: anAmountOfFaces [

faces := anAmountOfFaces.
]

{ #category : #action }
RealDie >> throw [

	^ faces atRandom 
]
