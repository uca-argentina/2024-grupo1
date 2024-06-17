"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  Squares with this effect teleport spaceships to the other side of the wormhole

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	otherSide:		<Object>


    Implementation Points
"
Class {
	#name : #WormholeEffect,
	#superclass : #NullEffect,
	#instVars : [
		'otherSide'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormholeEffect class >> isIn: aPosition goesTo: anotherPosition [

^self new initializeIsIn: aPosition goesTo: anotherPosition.
]

{ #category : #action }
WormholeEffect >> applyIn: aGame for: aSpaceship [ 
	aGame move: aSpaceship to: otherSide .
^(otherSide  - myPosition ).



]

{ #category : #initialization }
WormholeEffect >> initializeIsIn: aPosition goesTo: anotherPosition [

otherSide := anotherPosition.
myPosition:= aPosition .
]
