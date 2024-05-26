"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  If you land here, you advance 4 squares, but lose a shield.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	myPosition:		<Object>


    Implementation Points
"
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
