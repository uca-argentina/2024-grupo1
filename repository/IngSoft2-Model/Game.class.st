Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'board',
		'state',
		'dice',
		'spaceshipsData'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> playedBy: someSpaceships on: aBoard throwing: someDice [

	^ self new initializePlayedBy: someSpaceships on: aBoard throwing: someDice
]

{ #category : #adding }
Game >> addLap [
	
	|currentLaps currentPlayer|
	
	currentPlayer := spaceships first.
	currentLaps := (spaceshipsData at: currentPlayer ) at: 'Laps' .
	(spaceshipsData at: currentPlayer ) at: 'Laps' put: (currentLaps +1)
]

{ #category : #adding }
Game >> addLaps: amountOfLaps [
	
	|currentLaps currentPlayer|
	
	currentPlayer := spaceships first.
	currentLaps := (spaceshipsData at: currentPlayer ) at: 'Laps' .
	(spaceshipsData at: currentPlayer ) at: 'Laps' put: (currentLaps +amountOfLaps)
]

{ #category : #action }
Game >> calculateFinalPositionFor: aSpaceship [

	| diceResult finalPosition |
	diceResult := self throwDice.
	finalPosition := diceResult + (self positionOf: aSpaceship).
	finalPosition := board
		                 finalSquareAfterLandingIn: finalPosition
		                 whenPlaying: self.

	^ finalPosition
]

{ #category : #action }
Game >> checkForBattleIn: finalPosition [

	| aSpaceship |
	aSpaceship := self nextSpaceshipToPlay.
	finalPosition = 1 ifFalse: [
		spaceships allButFirstDo: [ :spaceship |
			((spaceshipsData at: spaceship) at: 'Position') = finalPosition
				ifTrue: [ self processBattleBetween: aSpaceship and: spaceship ] ] ]
]

{ #category : #accessing }
Game >> checkForWinnerIn: aSquare [ 
	aSquare = board squares ifTrue: [ self end  ].
]

{ #category : #testing }
Game >> data [ 

^spaceshipsData 
]

{ #category : #accessing }
Game >> dataFor: aSpaceship [

^spaceshipsData at: aSpaceship ifAbsent: [Error signal: 'That spaceship is not a player in this game']
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
Game >> initializeData [

|numberOfPlayers data |


numberOfPlayers := spaceships size.

data := OrderedCollection new.
numberOfPlayers timesRepeat: [ data add: (Dictionary newFromKeys: (OrderedCollection with: 'Position' with: 'Laps' with: 'Shields') andValues: (OrderedCollection with: 0 with: 0 with: 3) )] .
spaceshipsData := Dictionary newFromKeys: spaceships andValues:  (data).
]

{ #category : #initialization }
Game >> initializePlayedBy: someSpaceships on: aBoard throwing: someDice [

spaceships := someSpaceships.  
self initializeData.
state := GameOngoingState new.
board := aBoard.
dice := someDice.


]

{ #category : #accessing }
Game >> isOngoing [

^ state isOngoing.
]

{ #category : #accessing }
Game >> lapsOf: aSpaceship [ 
 ^ (self dataFor:  aSpaceship) at: 'Laps'
]

{ #category : #accessing }
Game >> leaderBoard [
	
	"^ spaceships asSortedCollection: [ :sp1 :sp2 | (spaceshipPositions at: sp1) >= (spaceshipPositions at: sp2 ) ].  "
	
	^spaceships asSortedCollection: [ :sp1 :sp2 | (spaceshipsData at: sp1 at: 'Position') >= (spaceshipsData at: sp2 at: 'Position') ]
	
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

	| aSpaceship finalPosition |
	state validateTurn.
	aSpaceship := self nextSpaceshipToPlay.
	finalPosition := self calculateFinalPositionFor: aSpaceship.
	self updatePositionOf: aSpaceship to: finalPosition.
	self checkForBattleIn: finalPosition.

	self checkForWinnerIn: finalPosition.
	self nextTurn
]

{ #category : #accessing }
Game >> players [
^ spaceships.
]

{ #category : #accessing }
Game >> positionOf: aSpaceship [ 

	^(self dataFor: aSpaceship )  at: 'Position'
]

{ #category : #action }
Game >> processBattleBetween: aSpaceship and: aSpaceship2 [

	| loser resultForFirstPlayer resultForSecondPlayer |
	resultForFirstPlayer := self throwDice.
	resultForSecondPlayer := self throwDice.
	loser := resultForFirstPlayer > resultForSecondPlayer
		         ifTrue: [ aSpaceship2 ]
		         ifFalse: [ aSpaceship ].

	(spaceshipsData at: loser) at: 'Shields' update: [:shields | shields -1].
	(spaceshipsData at: loser) at: 'Position' put: 1.
	

]

{ #category : #action }
Game >> rechargeShieldsOf: aSpaceship [ 
	spaceshipsData at: aSpaceship at: 'Shields' put: 3.
]

{ #category : #accessing }
Game >> shieldsOf: aSpaceship [ 

	^(self dataFor:  aSpaceship) at: 'Shields'.
]

{ #category : #action }
Game >> skipTurn [
	|aSpaceship|
	aSpaceship := self nextSpaceshipToPlay .
	self rechargeShieldsOf: aSpaceship.
	self nextTurn.
	
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

	"spaceshipPositions at: aSpaceship put: newPosition."
	(spaceshipsData at: aSpaceship) at: 'Position' put: newPosition .
	

]

{ #category : #accessing }
Game >> winner [

	^ state winnerOf: spaceshipsData  playingIn: board 
]
