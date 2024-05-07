Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipTest >> test004SpaceshipChangedPositionByOneWhenMoved [

	| aSpaceship |
	aSpaceship := Spaceship launch.
	aSpaceship move: 1.
	self assert: aSpaceship getPosition equals: 1
]

{ #category : #tests }
SpaceshipTest >> test005SpaceshipIsCreatedAtStartPoint0 [

	| aSpaceship |
	aSpaceship := Spaceship launch.
	self assert: aSpaceship getPosition equals: 0
]

{ #category : #tests }
SpaceshipTest >> test011ASpaceshipMovesFiveSquaresWhenLoadedDieIsThrown [


| aSpaceship aDie |
aSpaceship := Spaceship launch.
aDie := LoadedDie of: 5.
aSpaceship playTurn: aDie.
self assert: aSpaceship getPosition equals: 5.
]

{ #category : #tests }
SpaceshipTest >> test012ASpaceshipMovesSevenSquaresWhenLoadedDieIsThrown [


| aSpaceship aDie |
aSpaceship := Spaceship launch.
aDie := LoadedDie of: 7.

aSpaceship playTurn: aDie.
self assert: aSpaceship getPosition equals: 7.
]
