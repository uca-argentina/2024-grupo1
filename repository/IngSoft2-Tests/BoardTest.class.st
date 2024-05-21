Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> should: anErrorBlock raise: anError withMessage: errorMessage [

self 
	should: anErrorBlock 
	raise: anError 
	withExceptionDo: [ :error |
										self assert: error messageText  equals: errorMessage  ].
]

{ #category : #tests }
BoardTest >> test007BoardCreatedWithTwoSquares [

	| aBoard |

	aBoard := Board of: 2 wormholeBeginsAt: 1 andEndsAt: 2.
	self assert: aBoard squares equals: 2
]

{ #category : #tests }
BoardTest >> test010BoardCreatedWithNSquares [

| aBoard |

aBoard := Board of: 2 wormholeBeginsAt: 1 andEndsAt: 2.
self assert: aBoard squares equals: 2.
]

{ #category : #tests }
BoardTest >> test013IfSpaceshipLandsOnWormholeInSquareThreePlayerGetsMovedToSquareFive [

	| aSpaceship aLoadedDie aGame aBoard stack someDice |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 6 wormholeBeginsAt: 3 andEndsAt: 5.
	aLoadedDie := LoadedDie of: 3.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship ) equals: 5
]

{ #category : #tests }
BoardTest >> test014IfSpaceshipLandsOnWormholeStartingPointEndsInEndpoint [

	| aSpaceship aLoadedDie aGame aBoard stack someDice |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship .
	aBoard := Board of: 10 wormholeBeginsAt: 3 andEndsAt: 7.
	aLoadedDie := LoadedDie of: 3.
	someDice:= OrderedCollection with: aLoadedDie .
	aGame := Game playedBy: stack on: aBoard throwing: someDice.

	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship ) equals: 7
]

{ #category : #tests }
BoardTest >> test015IfSpaceshipLandsOnWormholeEndpointEndsInStartingPoint [

	| aSpaceship aLoadedDie aGame aBoard stack someDice |
	aSpaceship := Spaceship launch: ''.
	aBoard := Board of: 10 wormholeBeginsAt: 3 andEndsAt: 7.
	aLoadedDie := LoadedDie of: 7.
	stack:= OrderedCollection with: aSpaceship .
	someDice:= OrderedCollection with: aLoadedDie .
	aGame := Game playedBy: stack on: aBoard throwing: someDice.

	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship ) equals: 3
]

{ #category : #tests }
BoardTest >> test022GameEndsAutomaticallyWhenSpaceshipLandsInLastSquare [

	| aBoard aSpaceship aGame stack aLoadedDie someDice |
	aBoard := Board of: 8 wormholeBeginsAt: 1 andEndsAt: 2.
	aSpaceship := Spaceship launch: ''.
	aLoadedDie := LoadedDie of: 8.
	stack := OrderedCollection with: aSpaceship.
	someDice := OrderedCollection with: aLoadedDie .
	aGame := Game playedBy: stack on: aBoard throwing: someDice.
	aGame playTurn .

	self deny: aGame isOngoing
]

{ #category : #tests }
BoardTest >> test032BoardMustBeCreatedWithAtLeastOneSquare [

	| aBoard |
	
	self should: [ aBoard := Board of: 0 wormholeBeginsAt: 0 andEndsAt: 0. ] raise: Error withMessage: 'Board must have at least 1 square'.
]

{ #category : #tests }
BoardTest >> test033BoardCannotBeCreatedIfWormholeIsOutOfBounds [

	| aBoard |
	
	self should: [ aBoard := Board of: 1 wormholeBeginsAt: 2 andEndsAt: 3. ] raise: Error withMessage: 'Wormhole out of bounds'. 
]

{ #category : #tests }
BoardTest >> test034BoardCannotBeCreatedIfWormholeEndpointsAreNegative [

	| aBoard |
	

	self should: [ aBoard := Board of: 1 wormholeBeginsAt: -1 andEndsAt: -2. ] raise: Error withMessage: 'Wormhole out of bounds'.  
]

{ #category : #tests }
BoardTest >> test035BoardCannotBeCreatedIfWormholeEndpointsAreInTheSameSquare [

	| aBoard | 

	self should: [ aBoard := Board of: 3 wormholeBeginsAt: 1 andEndsAt: 1. ] raise: Error withMessage: 'Wormhole endpoints cannot be in the same square'.  
]

{ #category : #tests }
BoardTest >> test37WhenSpaceshipPassesFinalSquareThenGoesBackToBeginning [


| aGame aSpaceship aBoard aDie|

aSpaceship := Spaceship launch: ''.
aBoard := Board of: 7 wormholeBeginsAt: 1 andEndsAt: 2.
aDie := LoadedDie of: 10.
aGame := Game playedBy: (OrderedCollection with: aSpaceship) on: aBoard  throwing: (OrderedCollection with: aDie ).

aGame playTurn.
self assert: (aGame positionOf: aSpaceship) equals: 3



]

{ #category : #tests }
BoardTest >> test38WhenSpaceshipMovesTenInBoardOfEightThenGoesToSquareTwo [


| aGame aSpaceship aBoard aDie|

aSpaceship := Spaceship launch: ''.
aBoard := Board of: 8 wormholeBeginsAt: 3 andEndsAt: 4.
aDie := LoadedDie of: 10.
aGame := Game playedBy: (OrderedCollection with: aSpaceship) on: aBoard  throwing: (OrderedCollection with: aDie ).

aGame playTurn.
self assert: (aGame positionOf: aSpaceship) equals: 2



]
