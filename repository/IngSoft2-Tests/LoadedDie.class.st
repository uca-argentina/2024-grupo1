"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  ""I am an instance of playing dice""

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> of: anAmountOfFaces [  "anArrayOfValues -> para testear y controlar el comportamiento"

anAmountOfFaces < 3 ifTrue: [ Error signal: 'Faces should be more than 2' ].

^ (self new) initializeOf: anAmountOfFaces 
]

{ #category : #initialization }
LoadedDie >> initializeOf: anAmountOfFaces [

faces := anAmountOfFaces.
]

{ #category : #action }
LoadedDie >> throw [

	^ faces 
]
