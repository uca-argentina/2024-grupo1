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

{ #category : #testing }
Game >> canIPlay: aSpaceship [	
	
	self whoseTurn = aSpaceship ifFalse: [ Error signal: 'It is not your turn!' ].
	self isOngoing ifFalse: [ Error signal: 'Game has already ended' ].
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

{ #category : #accessing }
Game >> getDice [
^ dice.
]

{ #category : #testing }
Game >> isOngoing [

^ state isOngoing.
]

{ #category : #accessing }
Game >> leaderBoard [
	
	^ spaceships asSortedCollection: [ :sp1 :sp2 | sp1 getPosition >= sp2 getPosition ].  
	
]

{ #category : #accessing }
Game >> leaderboardString [

	| string leaderboard |
	string := ''.
	leaderboard := self leaderBoard.
	leaderboard do: [ :spaceship | string := string , spaceship getName , ' in position ', spaceship getPosition asString, (Character cr asString) ].
	^ string
]

{ #category : #accessing }
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
