Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'board',
		'state',
		'index',
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> begin: aSpaceship with: aBoard with: someDice [

	^ self new begin: aSpaceship with: aBoard with: someDice.
]

{ #category : #initialization }
Game >> begin: spaceship with: aBoard with: someDice [
spaceships := spaceship.  
state := GameOngoingState new.
board := aBoard.
index := 1.
dice := someDice.
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
	finalPosition = board squares ifTrue: [ self end . ]
]

{ #category : #'as yet unclassified' }
Game >> getDice [
^ dice.
]

{ #category : #testing }
Game >> isOngoing [

^ state isOngoing.
]

{ #category : #'as yet unclassified' }
Game >> leaderBoard [
	
	^ spaceships asSortedCollection: [ :sp1 :sp2 | sp1 getPosition >= sp2 getPosition ].  
	
]

{ #category : #'as yet unclassified' }
Game >> nextTurn [
	| numberOfPlayers |
	numberOfPlayers := spaceships size.
	numberOfPlayers = index ifTrue: [index:=1]  ifFalse: [index := index + 1].  
	
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
