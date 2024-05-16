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
Game class >> playedBy: someSpaceships on: aBoard throwing: someDice [

	^ self new initializePlayedBy: someSpaceships on: aBoard throwing: someDice
]

{ #category : #testing }
Game >> canIPlay: aSpaceship [

	self nextSpaceshipToPlay = aSpaceship ifFalse: [
		Error signal: 'It is not your turn!' ].
	
	self isOngoing ifFalse: [ Error signal: 'Game has already ended' ]
]

{ #category : #accessing }
Game >> dice [
^ dice.
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

{ #category : #initialization }
Game >> initializePlayedBy: spaceship on: aBoard throwing: someDice [
spaceships := spaceship.  
state := GameOngoingState new.
board := aBoard.
index := 1.
dice := someDice.
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
Game >> nextSpaceshipToPlay [
	^ spaceships at: index.
]

{ #category : #adding }
Game >> nextTurn [

	| numberOfPlayers |
	numberOfPlayers := spaceships size.
	index := numberOfPlayers = index
		         ifTrue: [ 1 ]
		         ifFalse: [ index + 1 ]
]

{ #category : #accessing }
Game >> players [
^ spaceships.
]

{ #category : #accessing }
Game >> winner [

	^ state winnerOf:  spaceships playingIn: board 
]
