Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'board',
		'state',
		'dice',
		'spaceshipsData',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> playedBy: someSpaceships on: aBoard throwing: someDice wonAfter: aNumberOfLaps [ 
	^self new initializePlayedBy: someSpaceships  on: aBoard  throwing: someDice wonAfter: aNumberOfLaps .
]

{ #category : #action }
Game >> calculateFinalPositionFor: aSpaceship [

	| diceResult squaresMovedByEffect newPosition totalPosition originalPosition |
	diceResult := self throwDice.
	originalPosition := self positionOf: aSpaceship.
	newPosition := diceResult + originalPosition.
	squaresMovedByEffect := board
		                        finalSquareAfterMovingTo: newPosition
		                        whenPlaying: self.

	totalPosition := originalPosition + diceResult + squaresMovedByEffect.
	totalPosition >= board squares ifTrue: [
		self updateLaps: totalPosition // board squares of: aSpaceship ].
	totalPosition <= 0 ifTrue: [
		self updateLaps: totalPosition // board squares - 1 of: aSpaceship ]
]

{ #category : #action }
Game >> changeStateOf: aSpaceship to: aState [

	(self dataFor: aSpaceship ) at: 'State' put: aState .
]

{ #category : #action }
Game >> checkForBattleIn: finalPosition [

	| aSpaceship |
	aSpaceship := self nextSpaceshipToPlay.
	finalPosition = 0 ifFalse: [
		spaceships allButFirstDo: [ :spaceship |
			((spaceshipsData at: spaceship) at: 'Position') = finalPosition
				ifTrue: [ self processBattleBetween: aSpaceship and: spaceship ] ] ]
]

{ #category : #action }
Game >> checkForWinner [ 

	|currentSpaceship|
	currentSpaceship := self nextSpaceshipToPlay .
	(((self dataFor: currentSpaceship ) at: 'Laps') >= laps) ifTrue: [ self end  ]
]

{ #category : #testing }
Game >> data [ 

^spaceshipsData 
]

{ #category : #accessing }
Game >> dataFor: aSpaceship [

^spaceshipsData at: aSpaceship ifAbsent: [Error signal: 'That spaceship is not a player in this game']
]

{ #category : #adding }
Game >> decreaseAllShieldsByOne [

	| currentShields |
	spaceshipsData do: [ :dataForASpaceship |
		currentShields := dataForASpaceship at: 'Shields'.
		dataForASpaceship at: 'Shields' put: currentShields - 1 ]
]

{ #category : #adding }
Game >> decreaseShieldByOne [

	| currentShield aSpaceship |
	aSpaceship := self nextSpaceshipToPlay.
	currentShield := (self dataFor: self nextSpaceshipToPlay) at:
		                 'Shields'.
	(self dataFor: aSpaceship) at: 'Shields' put: currentShield - 1
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

	| numberOfPlayers data |
	numberOfPlayers := spaceships size.

	data := OrderedCollection new.
	numberOfPlayers timesRepeat: [
		data add: (Dictionary
				 newFromKeys: (OrderedCollection
						  with: 'Position'
						  with: 'Laps'
						  with: 'Shields'
						  with: 'State')
				 andValues: (OrderedCollection
						  with: 0
						  with: 0
						  with: 3
						  with: NormalState new)) ].
	spaceshipsData := Dictionary newFromKeys: spaceships andValues: data
]

{ #category : #initialization }
Game >> initializePlayedBy: someSpaceships on: aBoard throwing: someDice wonAfter: aNumberOfLaps [ 

spaceships := someSpaceships.  
self initializeData.
state := GameOngoingState new.
board := aBoard.
dice := someDice.
laps := aNumberOfLaps .
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
	"^spaceships asSortedCollection: [ :sp1 :sp2 | (spaceshipsData at: sp1 at: 'Position') >= (spaceshipsData at: sp2 at: 'Position') ]"

	^ spaceships asSortedCollection: [ :sp1 :sp2 |
		  (spaceshipsData at: sp1 at: 'Laps')
		  = (spaceshipsData at: sp2 at: 'Laps')
			  ifFalse: [
				  (spaceshipsData at: sp1 at: 'Laps')
				  >= (spaceshipsData at: sp2 at: 'Laps') ]
			  ifTrue: [
				  (spaceshipsData at: sp1 at: 'Position')
				  >= (spaceshipsData at: sp2 at: 'Position') ] ]
]

{ #category : #action }
Game >> moveAllBackToBeginning [
	
	spaceshipsData do: [ :dataForASpaceship | dataForASpaceship at: 'Position' put: 0 ]
]

{ #category : #action }
Game >> moveAllButCurrentBack: n [

	| currentPosition finalPosition movesTo currentLaps|
	spaceships allButFirstDo: [ :spaceship |
		currentPosition := (self dataFor: spaceship) at: 'Position'.
		movesTo  := currentPosition - n.
		finalPosition := board validateWithinBounds: movesTo .
 		currentLaps := (self dataFor: spaceship) at: 'Laps'.
		(currentLaps =0 and: (movesTo  <0)) ifTrue: [ finalPosition := 0 ].
		movesTo < 0 ifTrue: [ self updateLaps: movesTo  // board squares - 1 of: spaceship  ].
		(self dataFor: spaceship) at: 'Position' put: finalPosition ] 
]

{ #category : #action }
Game >> moveCurrentTo: aPosition [

	| aSpaceship currentLaps finalPosition |
	aSpaceship := self nextSpaceshipToPlay.
	finalPosition := board validateWithinBounds: aPosition.
	currentLaps := (self dataFor: aSpaceship) at: 'Laps'.
	(currentLaps = 0 and: aPosition < 0) ifTrue: [ finalPosition := 0 ].
	(self dataFor: aSpaceship) at: 'Position' put: finalPosition 
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
Game >> normalTurn [

	| aSpaceship|
	aSpaceship := self nextSpaceshipToPlay .
	self calculateFinalPositionFor: aSpaceship.
	self checkForBattleIn: (self positionOf: aSpaceship) .

	self checkForWinner.
]

{ #category : #action }
Game >> playTurn [
 
	| aSpaceship |
	state validateTurn.
	aSpaceship := self nextSpaceshipToPlay.
	((self dataFor: aSpaceship ) at: 'State') playIn: self.

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

	| loser resultForFirstPlayer resultForSecondPlayer currentShields |
	resultForFirstPlayer := self throwDice.
	resultForSecondPlayer := self throwDice.
	loser := resultForFirstPlayer > resultForSecondPlayer
		         ifTrue: [ aSpaceship2 ]
		         ifFalse: [ aSpaceship ].

	currentShields :=	(spaceshipsData at: loser) at: 'Shields'.
	(spaceshipsData at: loser) at: 'Shields' put: (currentShields -1).
	((spaceshipsData at: loser) at: 'Shields') = 0 ifTrue: [ (spaceshipsData at: loser) at: 'State' put: (RechargingState2 new) ].
	(spaceshipsData at: loser) at: 'Position' put: 0.
	
	

]

{ #category : #adding }
Game >> rechargeShieldsOf: aSpaceship [ 
	spaceshipsData at: aSpaceship at: 'Shields' put: 3.
]

{ #category : #accessing }
Game >> shieldsOf: aSpaceship [ 

	^(self dataFor: aSpaceship) at: 'Shields'.
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

{ #category : #adding }
Game >> updateLaps: amountOfLaps [

	| currentLaps currentPlayer totalLaps |
	currentPlayer := spaceships first.
	currentLaps := (self dataFor: currentPlayer) at: 'Laps'.
	totalLaps := (currentLaps + amountOfLaps) max: 0 "min: 0.".
	(self dataFor: currentPlayer) at: 'Laps' put: totalLaps
]

{ #category : #adding }
Game >> updateLaps: amountOfLaps of: aSpaceship [

	| currentLaps  totalLaps |

	currentLaps := (self dataFor: aSpaceship ) at: 'Laps'.
	totalLaps := (currentLaps + amountOfLaps) max: 0 .
	(self dataFor: aSpaceship ) at: 'Laps' put: totalLaps
]

{ #category : #action }
Game >> updatePositionOf: aSpaceship to: newPosition [ 

	(self dataFor: aSpaceship) at: 'Position' put: newPosition .
	

]

{ #category : #accessing }
Game >> winner [

	^ state winnerOf: spaceshipsData inAGameOf: laps 
]
