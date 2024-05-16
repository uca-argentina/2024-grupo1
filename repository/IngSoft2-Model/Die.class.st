"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  ""A die with n faces. When thrown, returns a random number between 1 and the amount of faces""

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	faces:		<Object>


    Implementation Points
"
Class {
	#name : #Die,
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
Die class >> of: anAmountOfFaces [
	
	anAmountOfFaces < 3 ifTrue: [ Error signal: 'Faces should be more than 2' ].
	^ self new initializeOf: anAmountOfFaces 
]

{ #category : #initialization }
Die >> initializeOf: anAmountOfFaces [

faces := anAmountOfFaces.
]

{ #category : #action }
Die >> throw [

	^ faces atRandom 
]
