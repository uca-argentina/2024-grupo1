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
	aGame := Game playedBy: (OrderedCollection with: aSpaceship) on: nil throwing: nil.
	self assert: aGame players equals: (OrderedCollection with: aSpaceship)
]

{ #category : #tests }
GameTest >> test004SpaceshipChangedPositionByOneWhenMoved [

	| aSpaceship aGame |
	aSpaceship := Spaceship launch: ''.
	aGame := Game playedBy: (OrderedCollection with: aSpaceship) on: nil throwing: nil.
	aGame updatePositionOf: aSpaceship  to: 1.
	self assert: (aGame positionOf: aSpaceship ) equals: 1
]

{ #category : #tests }
GameTest >> test005SpaceshipIsCreatedAtStartPoint [

	| aSpaceship aGame |
	aSpaceship := Spaceship launch: ''.
	aGame := Game playedBy: (OrderedCollection with: aSpaceship ) on: nil throwing: nil.

	self assert: (aGame positionOf: aSpaceship ) equals: 1
]

{ #category : #tests }
GameTest >> test006WhenGameHasOnlyOnePlayerThenThatPlayerWins [

	| aGame aSpaceship aBoard stack |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 2 wormholeBeginsAt: 1 andEndsAt: 2.
	aGame := Game playedBy: stack on: aBoard throwing: nil.
	aGame positionOf: aSpaceship .
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

	self should: [ aGame winner ] raise: Error withMessage: 'The game is not over - there is no winner yet.' 
	

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
	aBoard := Board of: 10 wormholeBeginsAt: 2 andEndsAt: 7.
	stack:=OrderedCollection with: aSpaceship .
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn .
	self assert: (aGame positionOf: aSpaceship ) equals: 6
]

{ #category : #tests }
GameTest >> test012ASpaceshipMovesSevenSquaresWhenLoadedDieIsThrown [

	| aSpaceship aLoadedDie aBoard aGame stack someDice |
	aSpaceship := Spaceship launch: ''.
	stack:=OrderedCollection with: aSpaceship .
	aLoadedDie := LoadedDie of: 7.
	someDice:= OrderedCollection with: aLoadedDie .
	aBoard := Board of: 10 wormholeBeginsAt: 2 andEndsAt: 3.
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn .
	self assert: (aGame positionOf: aSpaceship ) equals: 8
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
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aLoadedDie := LoadedDie of: 9.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	someDice:= OrderedCollection with: aLoadedDie.
	aBoard := Board of: 10 wormholeBeginsAt: 2 andEndsAt: 3.
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
	aLoadedDie := LoadedDie of: 4.
	someDice:= OrderedCollection with: aLoadedDie .
	aGame := Game playedBy: stack on: aBoard throwing: someDice .
	aGame playTurn .
	aGame playTurn.

	self
		assert: aGame leaderBoard asOrderedCollection
		equals: (OrderedCollection with: aSpaceship with: anotherSpaceship )
]

{ #category : #tests }
GameTest >> test022GameEndsAutomaticallyWhenSpaceshipLandsInLastSquare [

	| aBoard aSpaceship aGame stack aLoadedDie someDice |
	aBoard := Board of: 8 wormholeBeginsAt: 1 andEndsAt: 2.
	aSpaceship := Spaceship launch: ''.
	aLoadedDie := LoadedDie of: 7.
	stack := OrderedCollection with: aSpaceship.
	someDice := OrderedCollection with: aLoadedDie .
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn .

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> test023GameWithMultiplePlayersShowsLeaderBoard [

	| aGame aSpaceship anotherSpaceship yetAnotherSpaceship stack aBoard aLoadedDie someDice leaderboard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	stack := OrderedCollection
		         with: aSpaceship
		         with: anotherSpaceship
		         with: yetAnotherSpaceship.
	aBoard := Board of: 10 wormholeBeginsAt: 5 andEndsAt: 6.
	aLoadedDie := LoadedDie arrayOf:
		              (OrderedCollection with: 3 with: 2 with: 1).
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	[ aGame isOngoing ] whileTrue: [ aGame playTurn ].
	leaderboard := aGame leaderBoard.
	self
		assert: leaderboard asOrderedCollection
		equals: (OrderedCollection
				 with: aSpaceship
				 with: anotherSpaceship
				 with: yetAnotherSpaceship)
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
	self assert: (aGame positionOf: aSpaceship ) equals: 7.	

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
	self assert: (aGame positionOf: aSpaceship ) equals: 11.
	

]

{ #category : #tests }
GameTest >> test031TurnCannotBePlayedIfGameIsOver [

| aGame aSpaceship aDie aBoard|

aSpaceship := Spaceship launch: 'Millenium Falcon'.
aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
aDie := LoadedDie of: 4.
aGame := Game playedBy: (OrderedCollection  with: aSpaceship ) on: aBoard throwing: (OrderedCollection with: aDie).
aGame playTurn.

self should: [ aGame playTurn ] raise: Error withMessage: 'Game has already ended'.
	

]

{ #category : #tests }
GameTest >> test036GameCannotShowPositionOfSpaceshipsThatArentPlaying [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'Millenium Falcon'.
	anotherSpaceship := Spaceship launch: 'Death Star'.
	aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie of: 5.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).

	self
		should: [ aGame positionOf: anotherSpaceship ]
		raise: Error
		withMessage: 'That spaceship is not a player in this game'
]

{ #category : #tests }
GameTest >> test39AfterSpaceshipPassesLastSquareForTheFirstTimeThenNumberOfLapsIsOne [


| aGame aSpaceship aBoard aDie|

aSpaceship := Spaceship launch: ''.
aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
aDie := LoadedDie of: 8.
aGame := Game playedBy: (OrderedCollection with: aSpaceship) on: aBoard  throwing: (OrderedCollection with: aDie ).

aGame playTurn.
self assert: (aGame lapsOf: aSpaceship) equals: 1



]

{ #category : #tests }
GameTest >> test40AfterSpaceshipCrossesTheFinishLineTwiceThenHasTwoLaps [


| aGame aSpaceship aBoard aDie|

aSpaceship := Spaceship launch: ''.
aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
aDie := LoadedDie of: 11.
aGame := Game playedBy: (OrderedCollection with: aSpaceship) on: aBoard  throwing: (OrderedCollection with: aDie ).

aGame playTurn.
self assert: (aGame lapsOf: aSpaceship) equals: 2



]

{ #category : #tests }
GameTest >> test41GameHasTheInformationForASpaceship [


| aGame aSpaceship aBoard aDie|

aSpaceship := Spaceship launch: ''.
aBoard := Board of: 5 wormholeBeginsAt: 1 andEndsAt: 2.
aDie := LoadedDie of: 3.
aGame := Game playedBy: (OrderedCollection with: aSpaceship) on: aBoard  throwing: (OrderedCollection with: aDie ).

aGame playTurn.
self assert: (aGame dataFor: aSpaceship ) equals: (Dictionary newFromKeys: #('Position' 'Laps' 'Shields' 'State') andValues: #(4 0 3 0))



]

{ #category : #tests }
GameTest >> test42ASpaceshipStartsWithThreeShields [

	| aGame aSpaceship aDie aBoard|
	aSpaceship := Spaceship launch: ''.
	aBoard := Board of: 4 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie of: 3.
	aGame := Game playedBy: (OrderedCollection with: aSpaceship ) on: aBoard throwing: (OrderedCollection with: aDie ).
	self assert: (aGame shieldsOf: aSpaceship) equals: 3



]

{ #category : #tests }
GameTest >> test43AfterLosingABattleSpaceshipLosesAShield [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 1 with: 3 ).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame processBattleBetween: aSpaceship and: anotherSpaceship.

	self assert: (aGame shieldsOf: aSpaceship) equals: 2
]

{ #category : #tests }
GameTest >> test44IfSpaceshipWinsBattleDoesntLoseShields [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 3 ).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame processBattleBetween: aSpaceship and: anotherSpaceship.

	self assert: (aGame shieldsOf: aSpaceship) equals: 3
]

{ #category : #tests }
GameTest >> test45SpaceshipLosesTwoBattlesAndLosesTwoShields [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 1 with: 3 ).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame processBattleBetween: aSpaceship and: anotherSpaceship.
	aGame processBattleBetween: aSpaceship and: anotherSpaceship.	

	self assert: (aGame shieldsOf: aSpaceship) equals: 1
]

{ #category : #tests }
GameTest >> test46AfterLosingBattleSpaceshipGetsSentToBeginning [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 3 with: 4).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame playTurn.
	aGame processBattleBetween: aSpaceship and: anotherSpaceship.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
GameTest >> test47WhenTwoSpaceshipsLandOnTheSameSquareTheyBattle [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 6 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 3 with: 2).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: anotherSpaceship ) equals: 1
	

]

{ #category : #tests }
GameTest >> test48IfBattleEndsOnADrawThenLastSpaceshipToArriveLoses [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 6 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie of: 3.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame playTurn.
	aGame playTurn.
	self assert: ((aGame positionOf: anotherSpaceship) = 1 and: ((aGame positionOf: aSpaceship) = 4) )
	
	

]

{ #category : #tests }
GameTest >> test49SpaceshipCanSkipTurn [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie of: 3.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame skipTurn.
		
	self assert: (aGame nextSpaceshipToPlay ) equals: anotherSpaceship.

]

{ #category : #tests }
GameTest >> test50SkippingATurnRechargesShields [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 1 with: 2).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame processBattleBetween: aSpaceship and: anotherSpaceship.
	aGame skipTurn.
		
	self assert: (aGame shieldsOf: aSpaceship ) equals: 3.

]

{ #category : #tests }
GameTest >> test51FirstSquareIsASafeZone [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 2 andEndsAt: 3.
	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	aGame playTurn.
	aGame playTurn.		
	self assert: (aGame shieldsOf: anotherSpaceship ) equals: 3.

]

{ #category : #tests }
GameTest >> test52IfSpaceshipLosesAllShieldsThenTheirTurnGetsSkipped [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 2 andEndsAt: 3.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 2 with: 3).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	3 timesRepeat: [ aGame processBattleBetween: aSpaceship  and: anotherSpaceship ].
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship ) equals: 1.

]

{ #category : #tests }
GameTest >> test53AfterLosingAllShieldsSpaceshipCannotPlayForTwoTurns [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 4 wormholeBeginsAt: 2 andEndsAt: 3.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 2 with: 3).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	3 timesRepeat: [ aGame processBattleBetween: aSpaceship  and: anotherSpaceship ].
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame positionOf: aSpaceship  ) equals: 1.

]

{ #category : #tests }
GameTest >> test54AfterLosingTwoTurnsSpaceshipCanPlayAgain [

	| aGame aSpaceship anotherSpaceship aDie aBoard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aBoard := Board of: 8 wormholeBeginsAt: 6 andEndsAt: 7.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 2 with: 3).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie).
	3 timesRepeat: [ aGame processBattleBetween: aSpaceship  and: anotherSpaceship ].
	5 timesRepeat: [ aGame playTurn  ].
	
	self assert: (aGame positionOf: aSpaceship  ) equals: 3.

]
