"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  Data for a spaceship

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	laps:		<Object>
	position:		<Object>
	shields:		<Object>
	spaceship:		<Object>


    Implementation Points
"
Class {
	#name : #SpaceshipData,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'laps',
		'shields',
		'position',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipData class >> for: aSpaceship [

	^self new initializeFor: aSpaceship 
]

{ #category : #accessing }
SpaceshipData >> changeLapsTo: anAmountOfLaps [

laps := anAmountOfLaps 
]

{ #category : #accessing }
SpaceshipData >> changeShieldsTo: aShieldValue [

shields := aShieldValue 
]

{ #category : #accessing }
SpaceshipData >> changeStateTo: aState [ 

state := aState 
]

{ #category : #initialization }
SpaceshipData >> initializeFor: aSpaceship [ 

	spaceship := aSpaceship .
	position := 0.
	laps := 0.
	state := NormalState new.
	shields := 3.
]

{ #category : #accessing }
SpaceshipData >> laps [
^laps 
]

{ #category : #accessing }
SpaceshipData >> moveTo: aPosition [

	position := aPosition 
]

{ #category : #accessing }
SpaceshipData >> position [
^position 
]

{ #category : #accessing }
SpaceshipData >> shields [
^shields 
]

{ #category : #accessing }
SpaceshipData >> spaceship [
^spaceship 
]

{ #category : #accessing }
SpaceshipData >> state [ 
^state 
]
