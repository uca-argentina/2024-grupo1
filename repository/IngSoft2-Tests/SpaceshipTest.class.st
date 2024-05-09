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

	| aSpaceship aLoadedDie aBoard aGame someDice stack |
	aSpaceship := Spaceship launch: ''.
	aLoadedDie := LoadedDie of: 5.
	someDice:=OrderedCollection with: aLoadedDie .
	aBoard := Board of: 10 wormholeBeginsAt: 6 andEndsAt: 7.
	stack:=OrderedCollection with: aSpaceship .
	aGame := Game begin: stack with: aBoard with: someDice.
	aSpaceship playTurnIn: aGame.
	self assert: aSpaceship getPosition equals: 5
]

{ #category : #tests }
SpaceshipTest >> test012ASpaceshipMovesSevenSquaresWhenLoadedDieIsThrown [

	| aSpaceship aLoadedDie aBoard aGame stack someDice |
	aSpaceship := Spaceship launch: ''.
	stack:=OrderedCollection with: aSpaceship .
	aLoadedDie := LoadedDie of: 7.
	someDice:= OrderedCollection with: aLoadedDie .
	aBoard := Board of: 10 wormholeBeginsAt: 6 andEndsAt: 8.
	aGame := Game begin: stack with: aBoard with: someDice.
	aSpaceship playTurnIn: aGame.
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
