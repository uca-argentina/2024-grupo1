Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #creation }
BoardTest >> createArrayOf: length with: someEffects [

	|squares|

	squares  := ZeroBasedArray newEmpty .

	0 to: (length  -1) do: [ :square |
		squares  add: (Square with: (NullEffect isIn: square)) ].


	someEffects keysDo: [ :index |
		squares  at: index put: (Square with: (someEffects at: index)) ].
	 ^ squares 
]

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

	aBoard := Board of: 2 wormholeBeginsAt: 0 andEndsAt: 1.
	self assert: aBoard length equals: 2
]

{ #category : #tests }
BoardTest >> test010BoardCreatedWithNSquares [

| aBoard |

aBoard := Board of: 20 wormholeBeginsAt: 1 andEndsAt: 2.
self assert: aBoard length equals: 20.
]

{ #category : #tests }
BoardTest >> test013IfSpaceshipLandsOnWormholeInSquareThreePlayerGetsMovedToSquareFive [

	| aSpaceship aLoadedDie aGame aBoard stack someDice |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 6 wormholeBeginsAt: 4 andEndsAt: 5.
	aLoadedDie := LoadedDie of: 4.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game
		         playedBy: stack
		         on: aBoard
		         throwing: someDice
		         wonAfter: 1.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
BoardTest >> test014IfSpaceshipLandsOnWormholeStartingPointEndsInEndpoint [

	| aSpaceship aLoadedDie aGame aBoard stack someDice |
	aSpaceship := Spaceship launch: ''.
	stack := OrderedCollection with: aSpaceship.
	aBoard := Board of: 10 wormholeBeginsAt: 4 andEndsAt: 7.
	aLoadedDie := LoadedDie of: 4.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game
		         playedBy: stack
		         on: aBoard
		         throwing: someDice
		         wonAfter: 1.

	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
BoardTest >> test015IfSpaceshipLandsOnWormholeEndpointEndsInStartingPoint [

	| aSpaceship aLoadedDie aGame aBoard stack someDice |
	aSpaceship := Spaceship launch: ''.
	aBoard := Board of: 10 wormholeBeginsAt: 3 andEndsAt: 7.
	aLoadedDie := LoadedDie of: 7.
	stack := OrderedCollection with: aSpaceship.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game
		         playedBy: stack
		         on: aBoard
		         throwing: someDice
		         wonAfter: 1.

	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 3
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

	| aGame aSpaceship aBoard aDie |
	aSpaceship := Spaceship launch: ''.
	aBoard := Board of: 7 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie of: 10.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.

	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 3
]

{ #category : #tests }
BoardTest >> test38WhenSpaceshipMovesTenInBoardOfEightThenGoesToSquareThree [

	| aGame aSpaceship aBoard aDie |
	aSpaceship := Spaceship launch: ''.
	aBoard := Board of: 8 wormholeBeginsAt: 3 andEndsAt: 4.
	aDie := LoadedDie of: 10.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.

	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 2
]

{ #category : #tests }
BoardTest >> test55WhenLandingInABlackholeSpaceshipGoesBackFourSquares [

	| aGame aSpaceship aBoard aDie squares blackholeEffect |
	aSpaceship := Spaceship launch: 'One'.
	blackholeEffect :=Square with:( BlackholeEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: blackholeEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.
	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 2
]

{ #category : #tests }
BoardTest >> test56IfSpaceshipLandsOnHyperSpaceJumpSquareThenAdvancesFourSquares [

	| aGame aSpaceship aBoard aDie squares hyperSpaceJumpEffect |
	aSpaceship := Spaceship launch: 'One'.
	hyperSpaceJumpEffect :=Square with:( HyperSpaceJumpEffect isIn: 6).
	
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperSpaceJumpEffect.
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 10
]

{ #category : #tests }
BoardTest >> test57IfSpaceshipLandsOnHyperSpaceJumpSquareThenLosesAShield [

	| aGame aSpaceship aBoard aDie squares hyperSpaceJumpEffect |
	aSpaceship := Spaceship launch: 'One'.
	hyperSpaceJumpEffect := Square with: ( HyperSpaceJumpEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperSpaceJumpEffect.
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	self assert: (aGame shieldsOf: aSpaceship) equals: 2
]

{ #category : #tests }
BoardTest >> test58WhenSpaceshipLandsOnMoonWalkSquareThenOtherSpaceshipsGetSentBackN [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares moonWalkEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	moonWalkEffect := Square with:( MoonWalkEffect isIn: 6 moves: 3).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: moonWalkEffect.
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test59WhenSpaceshipLandsOnMoonwalkSquareThenItDoesntMove [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares moonWalkEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	moonWalkEffect := Square with: (MoonWalkEffect isIn: 6 moves: 3).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: moonWalkEffect.
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: anotherSpaceship) equals: 6
]

{ #category : #tests }
BoardTest >> test60WhenSpaceshipLandsOnAtomicBombSquareThenGetsSentBackToBeginning [

	| aGame aSpaceship aDie aBoard atomicBombEffect squares |
	aSpaceship := Spaceship launch: 'One'.
	aDie := LoadedDie of: 6.
	atomicBombEffect :=Square with: (AtomicBombEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: atomicBombEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test61WhenSpaceshipLandsOnAtomicBombEffectThenEveryoneGetsSentToSquareOne [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares atomicBombEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	atomicBombEffect := Square with:( AtomicBombEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: atomicBombEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.

	self assert: ((aGame positionOf: anotherSpaceship) = 0 and:
			 (aGame positionOf: aSpaceship) = 0)
]

{ #category : #tests }
BoardTest >> test62WhenSpaceshipLandsOnAtomicBombAllShieldsGetReducedByOne [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares atomicBombEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	atomicBombEffect := Square with: (AtomicBombEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: atomicBombEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.

	self assert: ((aGame shieldsOf: anotherSpaceship) = 2 and:
			 (aGame shieldsOf: aSpaceship) = 2)
]

{ #category : #tests }
BoardTest >> test63WhenSpaceshipLandsOnAtomicBombAllShieldsGoDownByOne [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares atomicBombEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	atomicBombEffect := Square with: (AtomicBombEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: atomicBombEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame decreaseShieldByOne.
	aGame playTurn.

	self assert: ((aGame shieldsOf: anotherSpaceship) = 1 and:
			 (aGame shieldsOf: aSpaceship) = 2)
]

{ #category : #tests }
BoardTest >> test64WhenTwoSpaceshipOnAnEffectSquareThenTheEffectsHappensBeforeBattle [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares moonwalk |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	moonwalk :=Square with:( MoonWalkEffect isIn: 6 moves: 3).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: moonwalk  .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 3 with: 5 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	3 timesRepeat: [ aGame playTurn ].


	self assert: (aGame shieldsOf: aSpaceship) equals: 3
]

{ #category : #tests }
BoardTest >> test65WhenSpaceshipLandsOnSquareWithEffectAndGetsMovedToASquareWithAnotherSpaceshipThenTheyBattle [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares blackholeEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	blackholeEffect := Square with:( BlackholeEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: blackholeEffect   .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 2 with: 6 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	2 timesRepeat: [ aGame playTurn ].

	self assert: (aGame shieldsOf: aSpaceship) equals: 2
]

{ #category : #tests }
BoardTest >> test68WhenSpaceshipLandsOnHyperJumpSquareGetsMovedOneParsecAhead [

	| aGame aSpaceship aBoard aDie squares hyperJumpEffect |
	aSpaceship := Spaceship launch: 'One'.

	hyperJumpEffect :=Square with: (HyperJumpEffect
		                   isIn: 6
		                   movesParsecs: (OrderedCollection with: 1)
		                   SquaresPerParsec: 1).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect    .
	aBoard := Board with: squares  parsecs: 11 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
BoardTest >> test70HyperJumpStoresAnArrayOfParsecsAndLoopsThroughThem [

	| aGame aSpaceship anotherSpaceship yetAnotherSpaceship aBoard aDie hyperJumpEffect squares |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.

	hyperJumpEffect :=Square with: (HyperJumpEffect
		                   isIn: 6
		                   movesParsecs:
		                   (OrderedCollection with: -1 with: 2)
		                   SquaresPerParsec: 1).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect    .
	aBoard := Board with: squares  parsecs: 11 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: ((aGame positionOf: aSpaceship) = 5 and:
			 ((aGame positionOf: anotherSpaceship) = 8 and:
				  (aGame positionOf: yetAnotherSpaceship) = 0))
]

{ #category : #tests }
BoardTest >> test71WhenSpaceshipLandsOnHyperJumpSquareGetsMovedOneParsecAndFourSquares [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares |
	aSpaceship := Spaceship launch: 'One'.

	hyperJumpEffect :=Square with: (HyperJumpEffect
		                   isIn: 6
		                   movesParsecs: (OrderedCollection with: 1)
		                   SquaresPerParsec:  20 / 5).
	squares := ZeroBasedArray newEmpty .
	0 to: 19 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect    .
	aBoard := Board with: squares  parsecs: 5 wormholeBeginsAt: 0 andEndsAt: 1.


	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10
]

{ #category : #tests }
BoardTest >> test72WhenBoardHasMoreParsecsThanSquaresThenSpaceshipMovesTwoParsecsAndOneSquare [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares |
	aSpaceship := Spaceship launch: 'One'.

	hyperJumpEffect :=Square with: (HyperJumpEffect
		                   isIn: 6
		                   movesParsecs: (OrderedCollection with: 2)
		                   SquaresPerParsec: 20 / 40).
	squares := ZeroBasedArray newEmpty .
	0 to: 19 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect    .
	aBoard := Board with: squares  parsecs: 40 wormholeBeginsAt: 0 andEndsAt: 1.


	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
BoardTest >> test73SpaceshipOnlyMovesWhenParsecsToSquaresRatioIsAnEvenNumber [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares |
	aSpaceship := Spaceship launch: 'One'.

	hyperJumpEffect :=Square with: (HyperJumpEffect
		                   isIn: 6
		                   movesParsecs: (OrderedCollection with: 3)
		                   SquaresPerParsec:  20 / 40).
	squares := ZeroBasedArray newEmpty .
	0 to: 19 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect    .
	aBoard := Board with: squares  parsecs: 40 wormholeBeginsAt: 0 andEndsAt: 1.


	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
BoardTest >> test74SpaceshipLosesALapIfItGetsSentBackPastTheFirstSquare [

	| aGame aSpaceship aBoard aDie blackholeEffect squares |
	aSpaceship := Spaceship launch: 'One'.
	blackholeEffect :=Square with: (BlackholeEffect isIn: 2).
	squares := ZeroBasedArray newEmpty .
	0 to: 4 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 2 put: blackholeEffect .
	aBoard := Board with: squares  parsecs: 20 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 7.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame lapsOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test75SpaceshipCantGoBackFurtherThanTheFirstSquareOnTheFirstLap [

	| aGame aSpaceship aBoard aDie blackholeEffect squares |
	aSpaceship := Spaceship launch: 'One'.
	blackholeEffect :=Square with:( BlackholeEffect isIn: 3).
	squares := ZeroBasedArray newEmpty .
	0 to: 4 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 3 put: blackholeEffect .
	aBoard := Board with: squares  parsecs: 20 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 3.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test76IfSpaceshipCompletesALapsAndGoesBackBeyondTheFirstSquareThenItLosesTheLap [

	| aGame aSpaceship aBoard aDie blackholeEffect squares |
	aSpaceship := Spaceship launch: 'One'.
	blackholeEffect :=Square with:( BlackholeEffect isIn: 4).
	squares := ZeroBasedArray newEmpty .
	0 to: 4 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: blackholeEffect .
	aBoard := Board with: squares  parsecs: 20 wormholeBeginsAt: 1 andEndsAt: 2.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 4).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 2.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame lapsOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test77WhenSpaceshipGoesBackMultipleLapsWithMoonwalkEffectThenLosesThoseLaps [

	| aGame aSpaceship anotherSpaceship aBoard aDie moonwalkEffect squares |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	moonwalkEffect :=Square with:( MoonWalkEffect isIn: 4 moves: 10).
	squares := ZeroBasedArray newEmpty .
	0 to: 4 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: moonwalkEffect .
	aBoard := Board with: squares  parsecs: 5 wormholeBeginsAt: 1 andEndsAt: 2.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 11 with: 4).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame lapsOf: aSpaceship) equals: 0
]
