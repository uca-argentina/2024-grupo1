Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipTest >> test004SpaceshipChangedPositionByOneWhenMoved [

	| aSpaceship |
	aSpaceship := Spaceship launch: ''.
	aSpaceship move: 1.
	self assert: aSpaceship getPosition equals: 1
]

{ #category : #tests }
SpaceshipTest >> test005SpaceshipIsCreatedAtStartPoint0 [

	| aSpaceship |
	aSpaceship := Spaceship launch: ''.
	self assert: aSpaceship getPosition equals: 0
]

{ #category : #tests }
SpaceshipTest >> test011ASpaceshipMovesFiveSquaresWhenLoadedDieIsThrown [

	| aSpaceship aDie aBoard aGame |
	aSpaceship := Spaceship launch: ''.
	aDie := LoadedDie of: 5.
	aBoard := Board of: 10 wormholeBeginsAt: 6 andEndsAt: 7.
	aGame := Game begin: aSpaceship with: aBoard with: nil.
	aSpaceship playTurn: aDie in: aGame.
	self assert: aSpaceship getPosition equals: 5
]

{ #category : #tests }
SpaceshipTest >> test012ASpaceshipMovesSevenSquaresWhenLoadedDieIsThrown [

	| aSpaceship aDie aBoard aGame |
	aSpaceship := Spaceship launch: ''.
	aDie := LoadedDie of: 7.
	aBoard := Board of: 10 wormholeBeginsAt: 6 andEndsAt: 8.
	aGame := Game begin: aSpaceship with: aBoard with: nil.
	aSpaceship playTurn: aDie in: aGame.
	self assert: aSpaceship getPosition equals: 7
]

{ #category : #tests }
SpaceshipTest >> test026SpaceshipReturnsName [
	
	| aSpaceship |
	aSpaceship := Spaceship launch: 'Millenium Falcon'.
	self assert: aSpaceship getName equals: 'Millenium Falcon'	
]

{ #category : #tests }
SpaceshipTest >> test027SpaceshipReturnsAnotherName [

	| aSpaceship |
	aSpaceship := Spaceship launch: 'Death Star'.
	self assert: aSpaceship getName equals: 'Death Star'	
]
