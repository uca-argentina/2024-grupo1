Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'board',
		'state',
		'dice',
		'spaceshipPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> playedBy: someSpaceships on: aBoard throwing: someDice [

	^ self new initializePlayedBy: someSpaceships on: aBoard throwing: someDice
]

{ #category : #accessing }
Game >> checkForWinnerIn: aSquare [ 
	aSquare = board squares ifTrue: [ self end  ].
]

{ #category : #accessing }
Game >> dice [
^ dice.
]

{ #category : #adding }
Game >> end [
	state := GameFinishedState new.
]

{ #category : #initialization }
Game >> initializePlayedBy: someSpaceships on: aBoard throwing: someDice [

spaceships := someSpaceships.  
self initializePositions.
state := GameOngoingState new.
board := aBoard.
dice := someDice.


]

{ #category : #initialization }
Game >> initializePositions [

|numberOfPlayers startingPositions|


numberOfPlayers := spaceships size.
startingPositions := OrderedCollection new.
numberOfPlayers timesRepeat: [ startingPositions add: 0 ] .

spaceshipPositions := Dictionary newFromKeys: spaceships andValues:  (startingPositions ).
]

{ #category : #testing }
Game >> isOngoing [

^ state isOngoing.
]

{ #category : #accessing }
Game >> leaderBoard [
	
	^ spaceships asSortedCollection: [ :sp1 :sp2 | (spaceshipPositions at: sp1) >= (spaceshipPositions at: sp2 ) ].  
	
]

{ #category : #accessing }
Game >> nextSpaceshipToPlay [
	^ spaceships first.
]

{ #category : #adding }
Game >> nextTurn [

	|aSpaceship|
	aSpaceship := spaceships removeFirst.
	spaceships addLast: aSpaceship.
	
]

{ #category : #action }
Game >> playTurn [

	| aSpaceship diceResult finalPosition | 
	state validateTurn.
	aSpaceship := self nextSpaceshipToPlay.
	diceResult := self throwDice.


	finalPosition := diceResult + (self positionOf: aSpaceship).
	finalPosition := board finalSquareAfterLandingIn: finalPosition.
	self updatePositionOf: aSpaceship to: finalPosition.

	self checkForWinnerIn: finalPosition.
	self nextTurn

]

{ #category : #accessing }
Game >> players [
^ spaceships.
]

{ #category : #accessing }
Game >> positionOf: aSpaceship [ 


 ^ spaceshipPositions at: aSpaceship ifAbsent: [Error signal: 'That spaceship is not a player in this game'].
]

{ #category : #action }
Game >> throwDice [

	|result|
	result :=0.
	dice do: [ :aDie | result := result + aDie throw ].
 	^ result 
]

{ #category : #action }
Game >> updatePositionOf: aSpaceship to: newPosition [ 

	spaceshipPositions at: aSpaceship put: newPosition.
]

{ #category : #accessing }
Game >> winner [

	^ state winnerOf: spaceshipPositions playingIn: board 
]
