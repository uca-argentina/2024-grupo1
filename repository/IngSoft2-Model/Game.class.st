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
		self updateLapsOf: aSpaceship by: totalPosition // board squares ].
	totalPosition <= 0 ifTrue: [
		self updateLapsOf: aSpaceship by: totalPosition // board squares - 1 ]
]

{ #category : #action }
Game >> changeStateOf: aSpaceship to: aState [

	(self dataFor: aSpaceship ) changeStateTo: aState 
]

{ #category : #action }
Game >> checkForBattleIn: finalPosition [

	| aSpaceship |
	aSpaceship := self nextSpaceshipToPlay.
	finalPosition = 0 ifFalse: [
		spaceships allButFirstDo: [ :spaceship |
			((self dataFor: spaceship ) position) = finalPosition
				ifTrue: [ self processBattleBetween: aSpaceship and: spaceship ] ] ]
]

{ #category : #action }
Game >> checkForWinner [ 

	|currentSpaceship|
	currentSpaceship := self nextSpaceshipToPlay .
	(((self dataFor: currentSpaceship ) laps ) >= laps) ifTrue: [ self end  ]
]

{ #category : #testing }
Game >> data [ 

^spaceshipsData 
]

{ #category : #accessing }
Game >> dataFor: aSpaceship [

^spaceshipsData detect: [:dataForASpaceship | dataForASpaceship spaceship = aSpaceship   ] ifNone: [ Error signal: 'That spaceship is not a player in this game' ].
"^spaceshipsData at: aSpaceship ifAbsent: [Error signal: 'That spaceship is not a player in this game']"
]

{ #category : #adding }
Game >> decreaseAllShieldsByOne [

	| currentShields |
	spaceshipsData do: [ :dataForASpaceship |
		currentShields := dataForASpaceship shields .
		dataForASpaceship changeShieldsTo: currentShields -1]
]

{ #category : #adding }
Game >> decreaseShieldByOne [

	| currentShield aSpaceship |
	aSpaceship := self nextSpaceshipToPlay.
	currentShield := (self dataFor: self nextSpaceshipToPlay) shields .
	(self dataFor: aSpaceship) changeShieldsTo:  currentShield - 1
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

	| numberOfPlayers |
	numberOfPlayers := spaceships size.

	spaceshipsData := OrderedCollection new.
	spaceships  do: [ :spaceship |
		spaceshipsData add: (SpaceshipData for: (spaceship ) ) ].
	
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
 ^ (self dataFor:  aSpaceship) laps
]

{ #category : #accessing }
Game >> leaderBoard [

	^ spaceships asSortedCollection: [ :sp1 :sp2 |
		  (self dataFor: sp1) >= (self dataFor: sp2) ]
]

{ #category : #action }
Game >> moveAllBackToBeginning [
	
	spaceshipsData do: [ :dataForASpaceship | dataForASpaceship moveTo: 0 ]
]

{ #category : #action }
Game >> moveAllButCurrentBack: someSquares [

	| currentPosition finalPosition movesTo currentLaps |
	spaceships allButFirstDo: [ :spaceship |
		currentPosition := (self dataFor: spaceship) position.
		movesTo := currentPosition - someSquares.
		finalPosition := board validateWithinBounds: movesTo.
		currentLaps := (self dataFor: spaceship) laps.
		(currentLaps = 0 and: movesTo < 0) ifTrue: [ finalPosition := 0 ].
		movesTo < 0 ifTrue: [
			self updateLapsOf: spaceship by: movesTo // board squares - 1 ].
		(self dataFor: spaceship) moveTo: finalPosition ]
]

{ #category : #action }
Game >> moveCurrentTo: aPosition [

	| aSpaceship currentLaps finalPosition |
	aSpaceship := self nextSpaceshipToPlay.
	finalPosition := board validateWithinBounds: aPosition.
	currentLaps := (self dataFor: aSpaceship) laps .
	(currentLaps = 0 and: aPosition < 0) ifTrue: [ finalPosition := 0 ].
	(self dataFor: aSpaceship) moveTo: finalPosition 
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
	((self dataFor: aSpaceship ) state) playIn: self.

	self nextTurn
]

{ #category : #accessing }
Game >> players [
^ spaceships.
]

{ #category : #accessing }
Game >> positionOf: aSpaceship [ 

	^(self dataFor: aSpaceship )  position 
]

{ #category : #action }
Game >> processBattleBetween: aSpaceship and: aSpaceship2 [

	| loser resultForFirstPlayer resultForSecondPlayer |
	resultForFirstPlayer := self throwDice.
	resultForSecondPlayer := self throwDice.
	loser := resultForFirstPlayer > resultForSecondPlayer
		         ifTrue: [ aSpaceship2 ]
		         ifFalse: [ aSpaceship ].
		
	self reduceShieldsByOneOf: loser
]

{ #category : #adding }
Game >> rechargeShieldsOf: aSpaceship [ 
	(self dataFor: aSpaceship ) changeShieldsTo: 3
]

{ #category : #action }
Game >> reduceShieldsByOneOf: loser [

	| currentShields |
	currentShields := (self dataFor: loser) shields.
	(self dataFor: loser) changeShieldsTo: currentShields - 1.
	(self dataFor: loser) shields = 0 ifTrue: [
		(self dataFor: loser) changeStateTo: RechargingState2 new ].
	(self dataFor: loser) moveTo: 0
]

{ #category : #accessing }
Game >> shieldsOf: aSpaceship [ 

	^(self dataFor: aSpaceship) shields 
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
	currentLaps := (self dataFor: currentPlayer) laps.
	totalLaps := (currentLaps + amountOfLaps) max: 0 .
	(self dataFor: currentPlayer) changeLapsTo: totalLaps 
]

{ #category : #adding }
Game >> updateLapsOf: aSpaceship by: amountOfLaps [

	| currentLaps  totalLaps |

	currentLaps := (self dataFor: aSpaceship ) laps .
	totalLaps := (currentLaps + amountOfLaps) max: 0 .
	(self dataFor: aSpaceship ) changeLapsTo: totalLaps
]

{ #category : #action }
Game >> updatePositionOf: aSpaceship to: newPosition [ 

	(self dataFor: aSpaceship) moveTo: newPosition 
	

]

{ #category : #accessing }
Game >> winner [

	^ state winnerOf: spaceshipsData after: laps 
]
