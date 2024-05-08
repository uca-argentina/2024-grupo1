Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> test007BoardCreatedWithOneSquare [

	| aBoard |

	aBoard := Board of: 1 wormholeBeginsAt: 0 andEndsAt: 0.
	self assert: aBoard squares equals: 1
]

{ #category : #tests }
BoardTest >> test010BoardCreatedWithNSquares [

| aBoard |

aBoard := Board of: 2 wormholeBeginsAt: 0 andEndsAt: 0.
self assert: aBoard squares equals: 2.
]

{ #category : #tests }
BoardTest >> test013IfSpaceshipLandsOnWormholeInSquareThreePlayerGetsMovedToSquareFive [

	| aSpaceship aLoadedDie aGame aBoard |
	aSpaceship := Spaceship launch.
	aBoard := Board of: 6 wormholeBeginsAt: 3 andEndsAt: 5.
	aGame := Game begin: aSpaceship with: aBoard with: nil.
	aLoadedDie := LoadedDie of: 3.

	aSpaceship playTurn: aLoadedDie in: aGame.


	self assert: aSpaceship getPosition equals: 5
]

{ #category : #tests }
BoardTest >> test014IfSpaceshipLandsOnWormholeStartingPointEndsInEndpoint [

	| aSpaceship aLoadedDie aGame aBoard |
	aSpaceship := Spaceship launch.
	aBoard := Board of: 10 wormholeBeginsAt: 3 andEndsAt: 7.
	aGame := Game begin: aSpaceship with: aBoard with: nil.
	aLoadedDie := LoadedDie of: 3.

	aSpaceship playTurn: aLoadedDie in: aGame.


	self assert: aSpaceship getPosition equals: 7
]

{ #category : #tests }
BoardTest >> test015IfSpaceshipLandsOnWormholeEndpointEndsInStartingPoint [

	| aSpaceship aLoadedDie aGame aBoard |
	aSpaceship := Spaceship launch.
	aBoard := Board of: 10 wormholeBeginsAt: 3 andEndsAt: 7.
	aGame := Game begin: aSpaceship with: aBoard with: nil.
	aLoadedDie := LoadedDie of: 7.

	aSpaceship playTurn: aLoadedDie in: aGame.


	self assert: aSpaceship getPosition equals: 3
]

{ #category : #tests }
BoardTest >> test022GameEndsAutomaticallyWhenSpaceshipLandsInLastSquare [

	| aBoard aSpaceship aGame stack aLoadedDie |
	aBoard := Board of: 8 wormholeBeginsAt: 0 andEndsAt: 0.
	aSpaceship := Spaceship launch.
	stack := OrderedCollection with: aSpaceship.
	aGame := Game begin: stack with: aBoard with: nil.
	aLoadedDie := LoadedDie of: 8.
	aSpaceship playTurn: aLoadedDie in: aGame.

	self deny: aGame isOngoing
]
