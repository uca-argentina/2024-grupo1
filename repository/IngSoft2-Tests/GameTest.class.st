Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> should: anErrorBlock raise: anError withMessage: errorMessage [

self 
	should: anErrorBlock 
	raise: anError 
	withExceptionDo: [ :error |
										self assert: error messageText  equals: errorMessage  ].
]

{ #category : #tests }
GameTest >> test001WhenGameStartedThenIsOngoing [
	"Let the games begin"

	| aGame aSpaceship |
	aSpaceship := Spaceship launch: ''.
	aGame := Game playedBy: #(aSpaceship) on: nil throwing: nil.
	^ self assert: aGame isOngoing
]

{ #category : #tests }
GameTest >> test002WhenGameEndsThenIsOver [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch: ''.
	aGame := Game playedBy: #(aSpaceship) on: nil throwing: nil.
	aGame end.

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> test003GameBeginsWithAPlayer [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch: ''.
	aGame := Game playedBy: #(aSpaceship) on: nil throwing: nil.
	self assert: aGame players equals: #(aSpaceship)
]

{ #category : #tests }
GameTest >> test004SpaceshipChangedPositionByOneWhenMoved [

	| aSpaceship aGame |
	aSpaceship := Spaceship launch: ''.
	aGame := Game playedBy: #(aSpaceship ) on: nil throwing: nil.
	aGame updatePositionOf: aSpaceship  to: 1.
	self assert: (aGame positionOf: aSpaceship ) equals: 1
]

{ #category : #tests }
GameTest >> test005SpaceshipIsCreatedAtStartPoint0 [

	| aSpaceship aGame |
	aSpaceship := Spaceship launch: ''.
	aGame := Game playedBy: (OrderedCollection with: aSpaceship ) on: nil throwing: nil.

	self assert: (aGame positionOf: aSpaceship ) equals: 0
]

{ #category : #tests }
GameTest >> test006WhenGameHasOnlyOnePlayerThenThatPlayerWins [

	| aGame aSpaceship aBoard stack |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 2 wormholeBeginsAt: 1 andEndsAt: 2.
	aGame := Game playedBy: stack on: aBoard throwing: nil.
	aGame updatePositionOf: aSpaceship  to: 2.
	aGame end.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
GameTest >> test008WhenGameIsOngoingThereIsNoWinner [

	| aGame aSpaceship aBoard |
	aBoard := Board new.
	aSpaceship := Spaceship launch: ''.
	aGame := Game playedBy: #(aSpaceship) on: aBoard throwing: nil.

	self assert: aGame winner equals: nil
	
"poner excepcion"
]

{ #category : #tests }
GameTest >> test009SpaceshipDoesNotWinUntilItLandsOnTheLastSquare [

	| aGame aSpaceship aBoard stack |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 2 wormholeBeginsAt: 1 andEndsAt: 2.
	aGame := Game playedBy: stack on: aBoard throwing: nil.

	aGame end.

	self should: [ aGame winner equals: aSpaceship ] raise: NotFound
]

{ #category : #tests }
GameTest >> test011ASpaceshipMovesFiveSquaresWhenLoadedDieIsThrown [

	| aSpaceship aLoadedDie aBoard aGame someDice stack |
	aSpaceship := Spaceship launch: ''.
	aLoadedDie := LoadedDie of: 5.
	someDice:=OrderedCollection with: aLoadedDie .
	aBoard := Board of: 10 wormholeBeginsAt: 6 andEndsAt: 7.
	stack:=OrderedCollection with: aSpaceship .
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn .
	self assert: (aGame positionOf: aSpaceship ) equals: 5
]

{ #category : #tests }
GameTest >> test012ASpaceshipMovesSevenSquaresWhenLoadedDieIsThrown [

	| aSpaceship aLoadedDie aBoard aGame stack someDice |
	aSpaceship := Spaceship launch: ''.
	stack:=OrderedCollection with: aSpaceship .
	aLoadedDie := LoadedDie of: 7.
	someDice:= OrderedCollection with: aLoadedDie .
	aBoard := Board of: 10 wormholeBeginsAt: 6 andEndsAt: 8.
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn .
	self assert: (aGame positionOf: aSpaceship ) equals: 7
]

{ #category : #tests }
GameTest >> test016GameIndicatesTurnWithOnePlayer [

	| aGame aSpaceship stack |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aGame := Game playedBy: stack on: nil throwing: nil.
	self assert: aGame nextSpaceshipToPlay equals: aSpaceship
]

{ #category : #tests }
GameTest >> test017GameIndicatesFirstTurnWithTwoPlayers [

	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aGame := Game playedBy: stack on: nil throwing: nil.
	self assert: aGame nextSpaceshipToPlay equals: aSpaceship
]

{ #category : #tests }
GameTest >> test018GameIndicatesSecondTurnWithTwoPlayers [

	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aGame := Game playedBy: stack on: nil throwing: nil.
	aGame nextTurn.
	self assert: aGame nextSpaceshipToPlay equals: anotherSpaceship
]

{ #category : #tests }
GameTest >> test019GameResetsTurnsForNextRound [

	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aGame := Game playedBy: stack on: nil throwing: nil.
	aGame
		nextTurn;
		nextTurn.
	self assert: aGame nextSpaceshipToPlay equals: aSpaceship
]

{ #category : #tests }
GameTest >> test020GameWithMultiplePlayersKnowsTheWinner [

	| aGame aSpaceship anotherSpaceship stack aBoard aLoadedDie someDice |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	aLoadedDie := LoadedDie of: 3.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	someDice:= OrderedCollection with: aLoadedDie.
	aBoard := Board of: 3 wormholeBeginsAt: 1 andEndsAt: 2.
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn.
	aGame end.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
GameTest >> test021WhenGameIsOverLeaderboardIsShown [

	| aGame aSpaceship anotherSpaceship stack aBoard aLoadedDie someDice |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aBoard := Board of: 6 wormholeBeginsAt: 1 andEndsAt: 2.
	aLoadedDie := LoadedDie of: 5.
	someDice:= OrderedCollection with: aLoadedDie .
	aGame := Game playedBy: stack on: aBoard throwing: someDice .
	aGame playTurn .
	aGame playTurn.

	self
		assert: aGame leaderBoard asOrderedCollection
		equals: (OrderedCollection with: aSpaceship with: anotherSpaceship )
]

{ #category : #tests }
GameTest >> test023GameWithMultiplePlayersShowsLeaderBoard [

	| aGame aSpaceship anotherSpaceship yetAnotherSpaceship stack aBoard aLoadedDie someDice |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	stack := OrderedCollection
		         with: aSpaceship
		         with: anotherSpaceship
		         with: yetAnotherSpaceship.
	aBoard := Board of: 6 wormholeBeginsAt: 1 andEndsAt: 2.
	aLoadedDie := LoadedDie of: 4.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	[ aGame isOngoing ] whileTrue: [ aGame playTurn ].

	self
		assert: aGame leaderBoard asOrderedCollection
		equals: (OrderedCollection
				 with: aSpaceship 
				 with: yetAnotherSpaceship 
				 with: anotherSpaceship)
]

{ #category : #tests }
GameTest >> test024GameStoresADie [
	
	| aGame aSpaceship stack aBoard aLoadedDie someDice |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 10 wormholeBeginsAt: 1 andEndsAt: 2.
	aLoadedDie := LoadedDie of: 6.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship ) equals: 6.  	
	

]

{ #category : #tests }
GameTest >> test025GameCanUseMultipleDice [
	
	| aGame aSpaceship stack aBoard aLoadedDie anotherLoadedDie someDice |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 12 wormholeBeginsAt: 1 andEndsAt: 2.
	aLoadedDie := LoadedDie of: 6.
	anotherLoadedDie := LoadedDie of: 4.
	someDice := OrderedCollection with: aLoadedDie with: anotherLoadedDie.
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn .
	self assert: (aGame positionOf: aSpaceship ) equals: 10.  	 
	

]

{ #category : #tests }
GameTest >> test028GameWithOnePlayerReturnsLeaderboardWithPositions [

	| aGame aSpaceship aDie aBoard |
	self
		deprecated: 'Use #test021WhenGameIsOverLeaderboardIsShown instead'
		on: '19 May 2024'
		in:
		'Pharo-11.0.0+build.726.sha.aece1b5473acf3830a0e082c1bc3a15d4ff3522b (64 Bit)'.

	aSpaceship := Spaceship launch: 'Millenium Falcon'.
	aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie of: 5.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame playTurn .

	self
		assert: aGame leaderBoard first getName
		equals: 'Millenium Falcon'
]

{ #category : #tests }
GameTest >> test029GameWithMultiplePlayersReturnsLeaderBoardWithPositions [

	| aGame aSpaceship anotherSpaceship aDie aBoard leaderboard |
	self
		deprecated:
		'Use #test023GameWithMultiplePlayersShowsLeaderBoard instead'
		on: '19 May 2024'
		in:
		'Pharo-11.0.0+build.726.sha.aece1b5473acf3830a0e082c1bc3a15d4ff3522b (64 Bit)'.

	aSpaceship := Spaceship launch: 'Millenium Falcon'.
	anotherSpaceship := Spaceship launch: 'Death Star'.
	aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie of: 5.
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame playTurn.
	leaderboard := aGame leaderBoard.

	self assert: (leaderboard first getName = 'Millenium Falcon' and:
			 leaderboard last getName = 'Death Star')
]

{ #category : #tests }
GameTest >> test031TurnCannotBePlayedIfGameIsOver [

| aGame aSpaceship aDie aBoard|

aSpaceship := Spaceship launch: 'Millenium Falcon'.
aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
aDie := LoadedDie of: 5.
aGame := Game playedBy: (OrderedCollection  with: aSpaceship ) on: aBoard throwing: (OrderedCollection with: aDie).
aGame playTurn.

self should: [ aGame playTurn ] raise: Error withMessage: 'Game has already ended'.
	

]

{ #category : #tests }
GameTest >> test036GameCannotShowPositionOfSpaceshipsThatArentPlaying [

| aGame aSpaceship anotherSpaceship aDie aBoard|

aSpaceship := Spaceship launch: 'Millenium Falcon'.
anotherSpaceship := Spaceship launch: 'Death Star'.
aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
aDie := LoadedDie of: 5.
aGame := Game playedBy: (OrderedCollection  with: aSpaceship ) on: aBoard throwing: (OrderedCollection with: aDie).

self should: [ aGame positionOf: anotherSpaceship  ] raise: Error withMessage: 'That spaceship is not a player in this game'.
	

]
