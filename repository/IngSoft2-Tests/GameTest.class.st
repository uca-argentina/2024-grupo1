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
aGame:= Game begin: aSpaceship.
^self assert: (aGame isOngoing) .
]

{ #category : #tests }
GameTest >> test002IfGameIsOverReturnFalse [ 

|aGame aSpaceship |
aSpaceship := Spaceship launch.
aGame:= Game begin: aSpaceship.
aGame end.

self deny: (aGame isOngoing  )
]

{ #category : #tests }
GameTest >> test003GameBeginsWithAPlayer [ 

| aGame aSpaceship |
aSpaceship := Spaceship launch.
aGame := Game begin: aSpaceship.
self assert: aGame players equals: aSpaceship. 
]

{ #category : #tests }
GameTest >> test004SpaceshipIsCreatedAtStartPoint0 [

	| aSpaceship |
	aSpaceship := Spaceship launch.
	self assert: aSpaceship getPosition equals: 0
]

{ #category : #tests }
GameTest >> test005SpaceshipChangedPositionByOneWhenMoved [

	| aSpaceship |
	aSpaceship := Spaceship launch.
	aSpaceship move.
	self assert: aSpaceship getPosition equals: 1
]

{ #category : #tests }
GameTest >> test006GameWithOnePlayerReturnsWinner [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch.
	aGame := Game begin: aSpaceship.
	aGame end.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
GameTest >> test007BoardCreatedWithOneSquare [

	| aBoard |
	aBoard := Board new.
	self assert: aBoard squares equals: 1
]

{ #category : #tests }
GameTest >> test008WhenGameIsOngoingWinnerIsNil [

| aGame aSpaceship aBoard|

aBoard := Board new.
aSpaceship := Spaceship launch.
aGame := Game begin: aSpaceship with: aBoard.

self assert: aGame winner equals: nil.


]
