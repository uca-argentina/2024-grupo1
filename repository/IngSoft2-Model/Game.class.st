Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'board',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> begin: aSpaceship with: aBoard [

	^ self new begin: aSpaceship with: aBoard 
]

{ #category : #initialization }
Game >> begin: spaceship with: aBoard [
spaceships := spaceship.  
state := GameOngoingState new.
board := aBoard.
]

{ #category : #adding }
Game >> end [
	state := GameFinishedState new.
]

{ #category : #action }
Game >> finalPositionFor: aSpaceship [ 

	| currentPosition finalPosition |
	currentPosition := 	aSpaceship getPosition.
	finalPosition := board finalSquareAfterLandingIn: currentPosition.
	
	aSpaceship move: (finalPosition - currentPosition).
]

{ #category : #testing }
Game >> isOngoing [

^ state isOngoing.
]

{ #category : #accessing }
Game >> players [
^ spaceships.
]

{ #category : #accessing }
Game >> winner [

	^ state whoWon:  spaceships with: board 
]
