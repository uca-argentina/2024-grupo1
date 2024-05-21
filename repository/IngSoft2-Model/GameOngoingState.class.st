"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  ""State when the game is ongoing""

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
	#name : #GameOngoingState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GameOngoingState >> isOngoing [ 

^ true
]

{ #category : #analyzing }
GameOngoingState >> validateTurn [
	^0
]

{ #category : #accessing }
GameOngoingState >> winnerOf: spaceships playingIn: aBoard [

	Error signal: 'The game is not over - there is no winner yet.'
]
