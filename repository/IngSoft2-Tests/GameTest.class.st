Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> test001IfTheGameIsOngoingReturnTrue [
	"Let the games begin"

	| aGame aSpaceship |
	aSpaceship := Spaceship launch.
	aGame := Game begin: aSpaceship with: nil.
	^ self assert: aGame isOngoing
]

{ #category : #tests }
GameTest >> test002IfGameIsOverReturnFalse [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch.
	aGame := Game begin: aSpaceship with: nil.
	aGame end.

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> test003GameBeginsWithAPlayer [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch.
	aGame := Game begin: aSpaceship with: nil.
	self assert: aGame players equals: aSpaceship
]

{ #category : #tests }
GameTest >> test006GameWithOnePlayerReturnsWinner [

	| aGame aSpaceship aBoard stack |
	aSpaceship := Spaceship launch.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 1 wormholeBeginsAt: 0 andEndsAt: 0.
	aGame := Game begin: stack with: aBoard.
	aSpaceship move: 1.
	aGame end.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
GameTest >> test008WhenGameIsOngoingWinnerIsNil [

	| aGame aSpaceship aBoard|

aBoard := Board new.
aSpaceship := Spaceship launch.
aGame := Game begin: aSpaceship with: aBoard.

self assert: aGame winner equals: nil.
]

{ #category : #tests }
GameTest >> test009GameDoesntReturnWinnerIfSpaceshipIsNotInTheLastSquare [

| aGame aSpaceship aBoard stack |

aSpaceship := Spaceship launch.
stack := OrderedCollection with: aSpaceship.
aBoard := Board of: 2 wormholeBeginsAt: 1 andEndsAt: 1.
aGame := Game begin: stack  with: aBoard.

aGame end.

self should: [aGame winner equals: aSpaceship] raise: NotFound.
]

{ #category : #tests }
GameTest >> test016GameIndicatesTurnWithOnePlayer [
	
	| aGame aSpaceship stack |
	aSpaceship := Spaceship launch.
	stack := OrderedCollection with: (aSpaceship).
	aGame := Game begin: stack with: nil.
	self assert: aGame whoseTurn equals: aSpaceship.  	
	

]

{ #category : #tests }
GameTest >> test017GameIndicatesFirstTurnWithTwoPlayers [
	
	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch.
	anotherSpaceship := Spaceship launch.
	stack := OrderedCollection with: aSpaceship  with: anotherSpaceship.
	aGame := Game begin: stack with: nil. 
	self assert: aGame whoseTurn equals: aSpaceship.  	
	

]

{ #category : #tests }
GameTest >> test018GameIndicatesSecondTurnWithTwoPlayers [
	
	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch.
	anotherSpaceship := Spaceship launch.
	stack := OrderedCollection with: aSpaceship  with: anotherSpaceship.
	aGame := Game begin: stack with: nil.
	aGame nextTurn. 
	self assert: aGame whoseTurn equals: anotherSpaceship.  	
	

]

{ #category : #tests }
GameTest >> test019GameResetsTurnsForNextRound [
	
	| aGame aSpaceship anotherSpaceship stack |
	aSpaceship := Spaceship launch.
	anotherSpaceship := Spaceship launch.
	stack := OrderedCollection with: aSpaceship  with: anotherSpaceship.
	aGame := Game begin: stack with: nil.
	aGame nextTurn; nextTurn. 
	self assert: aGame whoseTurn equals: aSpaceship.  	
	

]

{ #category : #tests }
GameTest >> test020GameReturnsWinnerWithMultiplePlayers [
	
	| aGame aSpaceship anotherSpaceship stack aBoard aLoadedDie |
	aSpaceship := Spaceship launch.
	anotherSpaceship := Spaceship launch.
	stack := OrderedCollection with: aSpaceship  with: anotherSpaceship.
	aBoard := Board of: 3 wormholeBeginsAt: 0 andEndsAt: 0.
	aGame := Game begin: stack with: aBoard.
	aLoadedDie := LoadedDie of: 3.
	aSpaceship playTurn: aLoadedDie.
	aGame end.
	self assert: aGame winner equals: aSpaceship.  	
	

]

{ #category : #tests }
GameTest >> test021AfterGameEndsReturnsLeaderboard [
	
	| aGame aSpaceship anotherSpaceship stack aBoard aLoadedDie anotherLoadedDie |
	aSpaceship := Spaceship launch.
	anotherSpaceship := Spaceship launch.
	stack := OrderedCollection with: aSpaceship  with: anotherSpaceship.
	aBoard := Board of: 6 wormholeBeginsAt: 0 andEndsAt: 0.
	aGame := Game begin: stack with: aBoard.
	aLoadedDie := LoadedDie of: 3.
	anotherLoadedDie := LoadedDie of: 6.
	aSpaceship playTurn: aLoadedDie.
	anotherSpaceship playTurn: anotherLoadedDie.
	aGame end.
	self assert: aGame leaderBoard equals: (OrderedCollection with: anotherSpaceship with: aSpaceship).  	
	

]
