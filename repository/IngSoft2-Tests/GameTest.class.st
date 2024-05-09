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
GameTest >> test001IfTheGameIsOngoingReturnTrue [
	"Let the games begin"

	| aGame aSpaceship |
	aSpaceship := Spaceship launch: ''.
	aGame := Game begin: aSpaceship with: nil with: nil.
	^ self assert: aGame isOngoing
]

{ #category : #tests }
GameTest >> test002IfGameIsOverReturnFalse [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch: ''.
	aGame := Game begin: aSpaceship with: nil with: nil.
	aGame end.

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> test003GameBeginsWithAPlayer [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch: ''.
	aGame := Game begin: aSpaceship with: nil with: nil.
	self assert: aGame players equals: aSpaceship
]

{ #category : #tests }
GameTest >> test006GameWithOnePlayerReturnsWinner [

	| aGame aSpaceship aBoard stack |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 1 wormholeBeginsAt: 0 andEndsAt: 1.
	aGame := Game begin: stack with: aBoard with: nil.
	aSpaceship move: 1.
	aGame end.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
GameTest >> test008WhenGameIsOngoingWinnerIsNil [

	| aGame aSpaceship aBoard |
	aBoard := Board new.
	aSpaceship := Spaceship launch: ''.
	aGame := Game begin: aSpaceship with: aBoard with: nil.

	self assert: aGame winner equals: nil
]

{ #category : #tests }
GameTest >> test009GameDoesntReturnWinnerIfSpaceshipIsNotInTheLastSquare [

	| aGame aSpaceship aBoard stack |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 2 wormholeBeginsAt: 1 andEndsAt: 2.
	aGame := Game begin: stack with: aBoard with: nil.

	aGame end.

	self should: [ aGame winner equals: aSpaceship ] raise: NotFound
]

{ #category : #tests }
GameTest >> test016GameIndicatesTurnWithOnePlayer [

	| aGame aSpaceship stack |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aGame := Game begin: stack with: nil with: nil.
	self assert: aGame whoseTurn equals: aSpaceship
]

{ #category : #tests }
GameTest >> test017GameIndicatesFirstTurnWithTwoPlayers [

	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aGame := Game begin: stack with: nil with: nil.
	self assert: aGame whoseTurn equals: aSpaceship
]

{ #category : #tests }
GameTest >> test018GameIndicatesSecondTurnWithTwoPlayers [

	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aGame := Game begin: stack with: nil with: nil.
	aGame nextTurn.
	self assert: aGame whoseTurn equals: anotherSpaceship
]

{ #category : #tests }
GameTest >> test019GameResetsTurnsForNextRound [

	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aGame := Game begin: stack with: nil with: nil.
	aGame
		nextTurn;
		nextTurn.
	self assert: aGame whoseTurn equals: aSpaceship
]

{ #category : #tests }
GameTest >> test020GameReturnsWinnerWithMultiplePlayers [

	| aGame aSpaceship anotherSpaceship stack aBoard aLoadedDie someDice |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	aLoadedDie := LoadedDie of: 3.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	someDice:= OrderedCollection with: aLoadedDie.
	aBoard := Board of: 3 wormholeBeginsAt: 0 andEndsAt: 1.
	aGame := Game begin: stack with: aBoard with: someDice.
	aSpaceship playTurnIn: aGame.
	aGame end.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
GameTest >> test021AfterGameEndsReturnsLeaderboard [

	| aGame aSpaceship anotherSpaceship stack aBoard aLoadedDie someDice |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship with: anotherSpaceship.
	aBoard := Board of: 6 wormholeBeginsAt: 0 andEndsAt: 1.
	aLoadedDie := LoadedDie of: 5.
	someDice:= OrderedCollection with: aLoadedDie .
	aGame := Game begin: stack with: aBoard with: someDice .
	aSpaceship playTurnIn: aGame.
	anotherSpaceship move: 1.
	anotherSpaceship playTurnIn: aGame.
	aGame end.
	self
		assert: aGame leaderBoard asOrderedCollection
		equals: (OrderedCollection with: anotherSpaceship with: aSpaceship)
]

{ #category : #tests }
GameTest >> test023ReturnLeaderboardWithThreePlayers [

	| aGame aSpaceship anotherSpaceship stack aBoard aLoadedDie yetAnotherSpaceship someDice |
	aSpaceship := Spaceship launch: ''.
	anotherSpaceship := Spaceship launch: ''.
	yetAnotherSpaceship := Spaceship launch: ''.
	stack := OrderedCollection
		         with: aSpaceship
		         with: anotherSpaceship
		         with: yetAnotherSpaceship.
	aBoard := Board of: 6 wormholeBeginsAt: 0 andEndsAt: 1.
	aGame := Game begin: stack with: aBoard with: nil.
	aLoadedDie := LoadedDie of: 4.
	someDice:= OrderedCollection with: aLoadedDie .
	aGame := Game begin: stack with: aBoard with: someDice.
	anotherSpaceship move: 2.
	aSpaceship playTurnIn: aGame.
	anotherSpaceship playTurnIn: aGame.

	self
		assert: aGame leaderBoard asOrderedCollection
		equals: (OrderedCollection
				 with: anotherSpaceship 
				 with: aSpaceship
				 with: yetAnotherSpaceship)
]

{ #category : #tests }
GameTest >> test024GameStoresADie [
	
	| aGame aSpaceship stack aBoard aLoadedDie someDice |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 10 wormholeBeginsAt: 0 andEndsAt: 1.
	aLoadedDie := LoadedDie of: 6.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game begin: stack with: aBoard with: someDice.
	aSpaceship playTurnIn: aGame.
	self assert: aSpaceship getPosition equals: 6.  	
	

]

{ #category : #tests }
GameTest >> test025GameCanUseMultipleDice [
	
	| aGame aSpaceship stack aBoard aLoadedDie anotherLoadedDie someDice |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 12 wormholeBeginsAt: 0 andEndsAt: 1.
	aLoadedDie := LoadedDie of: 6.
	anotherLoadedDie := LoadedDie of: 4.
	someDice := OrderedCollection with: aLoadedDie with: anotherLoadedDie.
	aGame := Game begin: stack with: aBoard with: someDice.
	aSpaceship playTurnIn: aGame.
	self assert: aSpaceship getPosition equals: 10.  	 
	

]

{ #category : #tests }
GameTest >> test028GameWithOnePlayerReturnsLeaderboardWithPositions [


| aGame aSpaceship aDie aBoard|

aSpaceship := Spaceship launch: 'Millenium Falcon'.
aBoard := Board of: 5 wormholeBeginsAt: 0 andEndsAt: 1.
aDie := LoadedDie of: 5.
aGame := Game begin: (OrderedCollection  with: aSpaceship ) with: aBoard with: (OrderedCollection with: aDie).
aSpaceship playTurnIn: aGame.


self assert: aGame leaderboardString equals: 'Millenium Falcon in position 5', (Character cr asString).
	

]

{ #category : #tests }
GameTest >> test029GameWithMultiplePlayersReturnsLeaderBoardWithPositions [


| aGame aSpaceship anotherSpaceship aDie aBoard |

aSpaceship := Spaceship launch: 'Millenium Falcon'.
anotherSpaceship := Spaceship launch: 'Death Star'.
aBoard := Board of: 5 wormholeBeginsAt: 0 andEndsAt: 1.
aDie := LoadedDie of: 5.
aGame := Game begin: (OrderedCollection  with: aSpaceship with: anotherSpaceship) with: aBoard with: (OrderedCollection with: aDie).
aSpaceship playTurnIn: aGame.


self assert: aGame leaderboardString equals: ('Millenium Falcon in position 5' , (Character cr asString),'Death Star in position 0', (Character cr asString)).
	

]

{ #category : #tests }
GameTest >> test030GameRaisesAnExceptionWhenPlayerMovesOutOfTurn [


| aGame aSpaceship anotherSpaceship aDie aBoard |

aSpaceship := Spaceship launch: 'Millenium Falcon'.
anotherSpaceship := Spaceship launch: 'Death Star'.
aBoard := Board of: 5 wormholeBeginsAt: 0 andEndsAt: 1.
aDie := LoadedDie of: 5.
aGame := Game begin: (OrderedCollection  with: aSpaceship with: anotherSpaceship) with: aBoard with: (OrderedCollection with: aDie).

self should: [ anotherSpaceship playTurnIn: aGame ] raise: Error withMessage: 'It is not your turn!'.
	

]

{ #category : #tests }
GameTest >> test031SpaceshipCannotPlayIfGameIsOver [


| aGame aSpaceship aDie aBoard|

aSpaceship := Spaceship launch: 'Millenium Falcon'.
aBoard := Board of: 5 wormholeBeginsAt: 0 andEndsAt: 1.
aDie := LoadedDie of: 5.
aGame := Game begin: (OrderedCollection  with: aSpaceship ) with: aBoard with: (OrderedCollection with: aDie).
aSpaceship playTurnIn: aGame.

self should: [ aSpaceship playTurnIn: aGame ] raise: Error withMessage: 'Game has already ended'.
	

]
