Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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

| aGame aSpaceship aBoard|

aSpaceship := Spaceship launch.
aBoard := Board new.
aGame := Game begin: aSpaceship  with: aBoard.

aGame end.

self deny: aGame winner equals: aSpaceship.
]

{ #category : #tests }
GameTest >> test010BoardCreatedWithNSquares [

| aBoard |

aBoard := Board of: 2.
self assert: aBoard squares equals: 2.
]

{ #category : #tests }
GameTest >> test011ASpaceshipMovesFiveSquaresWhenLoadedDieIsThrown [


| aSpaceship aDie |
aSpaceship := Spaceship launch.
aDie := LoadedDie of: 5.
aSpaceship playTurn: aDie.
self assert: aSpaceship getPosition equals: 5.
]

{ #category : #tests }
GameTest >> test012ASpaceshipMovesSevenSquaresWhenLoadedDieIsThrown [


| aSpaceship aDie |
aSpaceship := Spaceship launch.
aDie := LoadedDie of: 7.

aSpaceship playTurn: aDie.
self assert: aSpaceship getPosition equals: 7.
]

{ #category : #tests }
GameTest >> testBoardCreatedWithOneSquare [

	| aBoard |

	aBoard := Board of: 1.
	self assert: aBoard squares equals: 1
]

{ #category : #tests }
GameTest >> testGameBeginsWithAPlayer [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch.
	aGame := Game begin: aSpaceship with: nil.
	self assert: aGame players equals: aSpaceship
]

{ #category : #tests }
GameTest >> testGameWithOnePlayerReturnsWinner [

	| aGame aSpaceship aBoard|
	aSpaceship := Spaceship launch.
	aBoard := Board of: 1.
	aGame := Game begin: aSpaceship with: aBoard.
	aSpaceship move.
	aGame end.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
GameTest >> testIfGameIsOverReturnFalse [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch.
	aGame := Game begin: aSpaceship with: nil.
	aGame end.

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> testIfTheGameIsOngoingReturnTrue [
	"Let the games begin"

	| aGame aSpaceship |
	aSpaceship := Spaceship launch.
	aGame := Game begin: aSpaceship with: nil.
	^ self assert: aGame isOngoing
]

{ #category : #tests }
GameTest >> testSpaceshipChangedPositionByOneWhenMoved [

	| aSpaceship |
	aSpaceship := Spaceship launch.
	aSpaceship move.
	self assert: aSpaceship getPosition equals: 1
]

{ #category : #tests }
GameTest >> testSpaceshipIsCreatedAtStartPoint0 [

	| aSpaceship |
	aSpaceship := Spaceship launch.
	self assert: aSpaceship getPosition equals: 0
]
