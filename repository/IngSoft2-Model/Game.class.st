Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'board',
		'state',
		'dice',
		'spaceshipsData',
		'laps',
		'activeCards',
		'lastTypeOfCardPlayed',
		'lastEffectTriggered'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> playedBy: someSpaceships on: aBoard throwing: someDice wonAfter: aNumberOfLaps [ 
	^self new initializePlayedBy: someSpaceships  on: aBoard  throwing: someDice wonAfter: aNumberOfLaps .
]

{ #category : #accessing }
Game >> activeMercenaryCards [
	^activeCards select: [ :card | card isMercenaryCard  ]
]

{ #category : #accessing }
Game >> activeMovementCards [
	^activeCards select: [ :card | card isMovementCard   ]
]

{ #category : #adding }
Game >> addActiveCard: aCard [

lastTypeOfCardPlayed := aCard class.
activeCards add: aCard.

]

{ #category : #adding }
Game >> addRandomCardFor: aSpaceship [

(self dataFor: aSpaceship) addRandomCard.
]

{ #category : #action }
Game >> battleIn: position [

	| aSpaceship |
	aSpaceship := self nextSpaceshipToPlay.
	position = 0 ifFalse: [
		spaceships allButFirstDo: [ :spaceship |
			((self positionOf: spaceship) = position and:
				 (self activeMercenaryCards allSatisfy: [ :card |
					  (card is: aSpaceship anAllyOf: spaceship) not ])) ifTrue: [
				self processBattleBetween: aSpaceship and: spaceship ] ] ]
]

{ #category : #action }
Game >> calculateFinalPositionFor: aSpaceship [

	| diceResult squaresMovedByEffect newPosition originalPosition |
	diceResult := self throwDice.
	self activeMovementCards  do: [ :card |
		diceResult := card playOn: aSpaceship withDiceThrow: diceResult ].
	originalPosition := self positionOf: aSpaceship.
	newPosition := diceResult + originalPosition.
	squaresMovedByEffect := board
		                        finalSquareFor: aSpaceship
		                        afterMovingTo: newPosition
		                        whenPlaying: self.

	self
		calculateLapsFor: aSpaceship
		in: originalPosition + diceResult + squaresMovedByEffect
]

{ #category : #action }
Game >> calculateLapsFor: aSpaceship in: totalPosition [

	totalPosition >= board length ifTrue: [
		(self dataFor: aSpaceship )updateLapsBy: totalPosition // board length ].
	totalPosition < 0 ifTrue: [
		(self dataFor: aSpaceship ) updateLapsBy: totalPosition // board length - 1 ]
]

{ #category : #action }
Game >> changeStateOf: aSpaceship to: aState [

	(self dataFor: aSpaceship ) changeStateTo: aState 
]

{ #category : #action }
Game >> checkForWinner [ 

	|currentSpaceship|
	currentSpaceship := self nextSpaceshipToPlay .
	((self lapsOf: currentSpaceship  ) >= laps) ifTrue: [ self end  ]
]

{ #category : #converting }
Game >> convertToSquares: aParsecDistance [
	^board convertToSquares: aParsecDistance
	
]

{ #category : #accessing }
Game >> dataFor: aSpaceship [

^spaceshipsData detect: [:dataForASpaceship | dataForASpaceship spaceship = aSpaceship   ] ifNone: [ Error signal: 'That spaceship is not a player in this game' ].

]

{ #category : #adding }
Game >> decreaseAllShieldsByOne [

	spaceshipsData do: [ :dataForASpaceship |
		dataForASpaceship decreaseShieldsByOne ]
]

{ #category : #adding }
Game >> decreaseShieldByOneOf: aSpaceship [

	(self dataFor: aSpaceship) decreaseShieldsByOne  
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
Game >> initializePlayedBy: someSpaceships on: aBoard throwing: someDice wonAfter: aNumberOfLaps [ 

spaceshipsData := someSpaceships.
self initializeSpaceships.
state := GameOngoingState new.
board := aBoard.
dice := someDice.
laps := aNumberOfLaps .
activeCards:= OrderedCollection new.
lastEffectTriggered:= NullEffect new.
]

{ #category : #initialization }
Game >> initializeSpaceships [

	| numberOfPlayers |
	numberOfPlayers := spaceshipsData size.

	spaceships := OrderedCollection new.
	spaceships := spaceshipsData collect: [ :dataForASpaceship | dataForASpaceship spaceship ]
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
Game >> move: aSpaceship to: aPosition [

	| currentLaps finalPosition |
	finalPosition := board adjustBounds: aPosition.
	currentLaps := (self dataFor: aSpaceship) laps .
	(currentLaps = 0 and: aPosition < 0) ifTrue: [ finalPosition := 0 ].
	(self dataFor: aSpaceship) moveTo: finalPosition .

]

{ #category : #action }
Game >> moveAllBackToBeginning [
	
	spaceshipsData do: [ :dataForASpaceship | dataForASpaceship moveTo: 0 ]
]

{ #category : #action }
Game >> moveAllBut: aSpaceship back: someSquares [

	| currentPosition finalPosition movesTo currentLaps selectedSpaceships |
	selectedSpaceships:= spaceships select:[ :spaceship | spaceship ~= aSpaceship .].
	selectedSpaceships do: [ :spaceship |
		currentPosition := (self dataFor: spaceship) position.
		movesTo := currentPosition - someSquares.
		finalPosition := board adjustBounds: movesTo.
		currentLaps := (self dataFor: spaceship) laps.
		(currentLaps = 0 and: movesTo < 0) ifTrue: [ finalPosition := 0 ].
		
		self calculateLapsFor: spaceship  in: movesTo .
		(self dataFor: spaceship) moveTo: finalPosition ]
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
	self battleIn: (self positionOf: aSpaceship).

	self checkForWinner.
]

{ #category : #action }
Game >> playCard: aCard from: aSpaceship withTarget: anotherSpaceship [
	self validateIf: aCard  canBePlayedBy: aSpaceship .
	aCard from: aSpaceship withTarget: anotherSpaceship useIn: self.
	(self dataFor: aSpaceship) removeCardFromHand: aCard. 
	
]

{ #category : #action }
Game >> playTurn [
 
	| aSpaceship |
	state validateTurn.
	aSpaceship := self nextSpaceshipToPlay.
	(self dataFor: aSpaceship ) playIn: self.

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
	self activeMercenaryCards  do: [ :card | resultForFirstPlayer := (card reinforce: aSpaceship in: self) + resultForFirstPlayer. ].
	resultForSecondPlayer := self throwDice.
	self activeMercenaryCards  do: [ :card | resultForSecondPlayer := (card reinforce: aSpaceship2 in: self) + resultForSecondPlayer. ].

	loser := resultForFirstPlayer > resultForSecondPlayer
		         ifTrue: [ aSpaceship2 ]
		         ifFalse: [ aSpaceship ].
	self reducePartyShieldsByOneOf: loser
]

{ #category : #adding }
Game >> rechargeShieldsOf: aSpaceship [
	(self dataFor: aSpaceship ) rechargeShields
]

{ #category : #action }
Game >> redoLastCardPlayedFor: aSpaceship withTarget: aTarget [
	| aCard |
	self validateLastCardPlayed.
	(self dataFor: aSpaceship) addCard: lastTypeOfCardPlayed. 
	aCard:= lastTypeOfCardPlayed new.
	self playCard: aCard from: aSpaceship  withTarget: aTarget
]

{ #category : #action }
Game >> reducePartyShieldsByOneOf: loser [
	
	self activeMercenaryCards  do: [ :card | card reduceShieldsOfAllyOf: loser in: self ].
	(self dataFor: loser) decreaseShieldsByOne . 
	(self dataFor: loser) moveTo: 0
	
]

{ #category : #removing }
Game >> removeActiveCard: aCard [ 
	
	activeCards remove: aCard ifAbsent: [ Error signal: 'Selected card is not active'. ].
	lastTypeOfCardPlayed := CancellationCard .
]

{ #category : #action }
Game >> repeatLastEffectFor: aSpaceship [ 

	|squaresMovedByEffect originalPosition|
	originalPosition := (self positionOf: aSpaceship).
	lastEffectTriggered setPosition: originalPosition .
	
	squaresMovedByEffect := lastEffectTriggered applyIn: self for: aSpaceship.
	self
		calculateLapsFor: aSpaceship
		in: originalPosition +  squaresMovedByEffect.
		
	lastTypeOfCardPlayed := RepeatCard .
	
	

]

{ #category : #adding }
Game >> saveLastEffectTriggeredTo: anEffect [

lastEffectTriggered := anEffect deepCopy .
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

{ #category : #validation }
Game >> validateIf: aCard canBePlayedBy: aSpaceship [

	| spaceshipData |
	state validateStateForCards.
	
	spaceshipData := self dataFor: aSpaceship.
	spaceshipData validateThatSpaceshipHasCard: aCard .
]

{ #category : #validation }
Game >> validateLastCardPlayed [
	lastTypeOfCardPlayed ifNil: [Error signal: 'There are no cards played to redo'.]
]

{ #category : #validation }
Game >> validateMercenaryAvailability: aSpaceship [

	(self activeMercenaryCards anySatisfy: [ :card |
		 card mercenary = aSpaceship ]) ifTrue: [
		Error signal: 'Selected spaceship is already a mercenary' ]
]

{ #category : #accessing }
Game >> winner [

	^ state winnerOf: spaceshipsData after: laps 
]
