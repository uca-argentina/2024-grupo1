Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'board',
		'state',
		'index'
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
index := 1.
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

{ #category : #'as yet unclassified' }
Game >> nextTurn [
	index := index + 1.
	
]

{ #category : #accessing }
Game >> players [
^ spaceships.
]

{ #category : #accessing }
Game >> whoseTurn [
	^ spaceships at: index.
]

{ #category : #accessing }
Game >> winner [

	^ state whoWon:  spaceships with: board 
]
