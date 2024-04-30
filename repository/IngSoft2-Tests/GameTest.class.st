Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGameBeginsWithAPlayer [ 

| aGame aSpaceship |
aSpaceship := Spaceship launch.
aGame := Game begin: aSpaceship.
self assert: aGame players equals: aSpaceship. 
]

{ #category : #tests }
GameTest >> testGameWithOnePlayerReturnsWinner [

	| aGame aSpaceship |
	aSpaceship := Spaceship launch.
	aGame := Game begin: aSpaceship.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
GameTest >> testIfGameIsOverReturnFalse [ 

|aGame aSpaceship |
aSpaceship := Spaceship launch.
aGame:= Game begin: aSpaceship.
aGame end.

self deny: (aGame isOngoing  )
]

{ #category : #tests }
GameTest >> testIfTheGameIsOngoingReturnTrue [
"Let the games begin"

| aGame aSpaceship |
aSpaceship := Spaceship launch.
aGame:= Game begin: aSpaceship.
^self assert: (aGame isOngoing) .
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
