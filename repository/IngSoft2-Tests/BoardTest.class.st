Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
BoardTest >> createBoardOf: length parsecs: someParsecs withEffects: someEffects wormholeBeginsAt: startPoint andEndsAt: endPoint [

	| squares |
	squares := ZeroBasedArray newEmpty .
	0 to: length -1 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	
	someEffects do: [ :effect | squares at: (effect position) put: (Square with:effect)  ].
	^Board with: squares  parsecs: someParsecs  wormholeBeginsAt: startPoint  andEndsAt: endPoint .
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

	| aSpaceship aLoadedDie aGame aBoard  someDice spaceshipsData |
	aSpaceship := Spaceship launch: ''.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	aBoard := Board of: 6 wormholeBeginsAt: 4 andEndsAt: 5.
	aLoadedDie := LoadedDie of: 4.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game
		         playedBy: spaceshipsData 
		         on: aBoard
		         throwing: someDice
		         wonAfter: 1.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
BoardTest >> test014IfSpaceshipLandsOnWormholeStartingPointEndsInEndpoint [

	| aSpaceship aLoadedDie aGame aBoard someDice spaceshipsData |
	aSpaceship := Spaceship launch: ''.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) .
	aBoard := Board of: 10 wormholeBeginsAt: 4 andEndsAt: 7.
	aLoadedDie := LoadedDie of: 4.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game
		         playedBy: spaceshipsData 
		         on: aBoard
		         throwing: someDice
		         wonAfter: 1.

	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
BoardTest >> test015IfSpaceshipLandsOnWormholeEndpointEndsInStartingPoint [

	| aSpaceship aLoadedDie aGame aBoard someDice spaceshipsData |
	aSpaceship := Spaceship launch: ''.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	aBoard := Board of: 10 wormholeBeginsAt: 3 andEndsAt: 7.
	aLoadedDie := LoadedDie of: 7.
	someDice := OrderedCollection with: aLoadedDie.
	aGame := Game
		         playedBy: spaceshipsData 
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
BoardTest >> test037WhenSpaceshipPassesFinalSquareThenGoesBackToBeginning [

	| aGame aSpaceship aBoard aDie spaceshipsData |
	aSpaceship := Spaceship launch: ''.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	aBoard := Board of: 7 wormholeBeginsAt: 1 andEndsAt: 2.
	aDie := LoadedDie of: 10.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.

	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 3
]

{ #category : #tests }
BoardTest >> test038WhenSpaceshipMovesTenInBoardOfEightThenGoesToSquareThree [

	| aGame aSpaceship aBoard aDie spaceshipsData |
	aSpaceship := Spaceship launch: ''.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	aBoard := Board of: 8 wormholeBeginsAt: 3 andEndsAt: 4.
	aDie := LoadedDie of: 10.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.

	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 2
]

{ #category : #tests }
BoardTest >> test055WhenLandingInABlackholeSpaceshipGoesBackFourSquares [

	| aGame aSpaceship aBoard aDie squares blackholeEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	blackholeEffect :=Square with:( BlackholeEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: blackholeEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.
	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: spaceshipsData 
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 2
]

{ #category : #tests }
BoardTest >> test056IfSpaceshipLandsOnHyperSpaceJumpSquareThenAdvancesFourSquares [

	| aGame aSpaceship aBoard aDie squares hyperSpaceJumpEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	hyperSpaceJumpEffect :=Square with:( HyperSpaceJumpEffect isIn: 6).
	
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperSpaceJumpEffect.
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 10
]

{ #category : #tests }
BoardTest >> test057IfSpaceshipLandsOnHyperSpaceJumpSquareThenLosesAShield [

	| aGame aSpaceship aBoard aDie squares hyperSpaceJumpEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	hyperSpaceJumpEffect := Square with: ( HyperSpaceJumpEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperSpaceJumpEffect.
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	self assert: (aGame shieldsOf: aSpaceship) equals: 2
]

{ #category : #tests }
BoardTest >> test058WhenSpaceshipLandsOnMoonWalkSquareThenOtherSpaceshipsGetSentBackN [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares moonWalkEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) with: (SpaceshipData randomCardsfor: anotherSpaceship).
	moonWalkEffect := Square with:( MoonWalkEffect isIn: 6 moves: 3).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: moonWalkEffect.
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test059WhenSpaceshipLandsOnMoonwalkSquareThenItDoesntMove [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares moonWalkEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) with: (SpaceshipData randomCardsfor: anotherSpaceship) .
	moonWalkEffect := Square with: (MoonWalkEffect isIn: 6 moves: 3).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: moonWalkEffect.
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: anotherSpaceship) equals: 6
]

{ #category : #tests }
BoardTest >> test060WhenSpaceshipLandsOnAtomicBombSquareThenGetsSentBackToBeginning [

	| aGame aSpaceship aDie aBoard atomicBombEffect squares spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	aDie := LoadedDie of: 6.
	atomicBombEffect :=Square with: (AtomicBombEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: atomicBombEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test061WhenSpaceshipLandsOnAtomicBombEffectThenEveryoneGetsSentToSquareOne [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares atomicBombEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) with: (SpaceshipData randomCardsfor: anotherSpaceship).
	atomicBombEffect := Square with:( AtomicBombEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: atomicBombEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.

	self assert: ((aGame positionOf: anotherSpaceship) = 0 and:
			 (aGame positionOf: aSpaceship) = 0)
]

{ #category : #tests }
BoardTest >> test062WhenSpaceshipLandsOnAtomicBombAllShieldsGetReducedByOne [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares atomicBombEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) with: (SpaceshipData randomCardsfor: anotherSpaceship).
	atomicBombEffect := Square with: (AtomicBombEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: atomicBombEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.

	self assert: ((aGame shieldsOf: anotherSpaceship) = 2 and:
			 (aGame shieldsOf: aSpaceship) = 2)
]

{ #category : #tests }
BoardTest >> test063WhenSpaceshipLandsOnAtomicBombAllShieldsGoDownByOne [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares atomicBombEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) with: (SpaceshipData randomCardsfor: anotherSpaceship).
	atomicBombEffect := Square with: (AtomicBombEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: atomicBombEffect .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt:  8 andEndsAt: 9.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 6).
	aGame := Game
		         playedBy: spaceshipsData 
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame decreaseShieldByOneOf: anotherSpaceship .
	aGame playTurn.

	self assert: ((aGame shieldsOf: anotherSpaceship) = 1 and:
			 (aGame shieldsOf: aSpaceship) = 2)
]

{ #category : #tests }
BoardTest >> test064WhenTwoSpaceshipOnAnEffectSquareThenTheEffectsHappensBeforeBattle [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares moonwalk spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) with: (SpaceshipData randomCardsfor: anotherSpaceship).
	moonwalk :=Square with:( MoonWalkEffect isIn: 6 moves: 3).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: moonwalk  .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 3 with: 5 with: 5).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	3 timesRepeat: [ aGame playTurn ].


	self assert: (aGame shieldsOf: aSpaceship) equals: 3
]

{ #category : #tests }
BoardTest >> test065WhenSpaceshipLandsOnSquareWithEffectAndGetsMovedToASquareWithAnotherSpaceshipThenTheyBattle [

	| aGame aSpaceship anotherSpaceship aBoard aDie squares blackholeEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) with: (SpaceshipData randomCardsfor: anotherSpaceship).
	blackholeEffect := Square with:( BlackholeEffect isIn: 6).
	squares := ZeroBasedArray newEmpty .
	0 to: 10 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: blackholeEffect   .
	aBoard := Board with: squares  parsecs: 1 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 2 with: 6 with: 5).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	2 timesRepeat: [ aGame playTurn ].

	self assert: (aGame shieldsOf: aSpaceship) equals: 2
]

{ #category : #tests }
BoardTest >> test068WhenSpaceshipLandsOnHyperJumpSquareGetsMovedOneParsecAhead [

	| aGame aSpaceship aBoard aDie squares hyperJumpEffect aParsecDistance spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData := OrderedCollection with:
		                  (SpaceshipData randomCardsfor: aSpaceship).
	aParsecDistance := ParsecDistance of: 1.
	hyperJumpEffect := Square with: (HyperJumpEffect
			                    isIn: 6
			                    movesDistance:
			                    (OrderedCollection with: aParsecDistance)).

	squares := ZeroBasedArray newEmpty.
	0 to: 10 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect.
	aBoard := Board
		          with: squares
		          parsecs: 11
		          wormholeBeginsAt: 0
		          andEndsAt: 1.

	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
BoardTest >> test070HyperJumpStoresAnArrayOfParsecsAndLoopsThroughThem [

	| aGame aSpaceship anotherSpaceship yetAnotherSpaceship aBoard aDie hyperJumpEffect squares aParsecDistance anotherParsecDistance spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData := OrderedCollection
		                  with: (SpaceshipData randomCardsfor: aSpaceship)
		                  with:
		                  (SpaceshipData randomCardsfor: anotherSpaceship)
		                  with:
		                  (SpaceshipData randomCardsfor: yetAnotherSpaceship).
	aParsecDistance := ParsecDistance of: -1.
	anotherParsecDistance := ParsecDistance of: 2.

	hyperJumpEffect := Square with: (HyperJumpEffect
			                    isIn: 6
			                    movesDistance:
			                    (OrderedCollection
				                     with: aParsecDistance
				                     with: anotherParsecDistance)).
	squares := ZeroBasedArray newEmpty.
	0 to: 10 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect.
	aBoard := Board
		          with: squares
		          parsecs: 11
		          wormholeBeginsAt: 0
		          andEndsAt: 1.

	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: spaceshipsData
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
BoardTest >> test071WhenSpaceshipLandsOnHyperJumpSquareGetsMovedOneParsecAndFourSquares [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares aParsecDistance spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData := OrderedCollection with:
		                  (SpaceshipData randomCardsfor: aSpaceship).

	aParsecDistance := ParsecDistance of: 1.

	hyperJumpEffect := Square with: (HyperJumpEffect
			                    isIn: 6
			                    movesDistance:
			                    (OrderedCollection with: aParsecDistance)).
	squares := ZeroBasedArray newEmpty.
	0 to: 19 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect.
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 0
		          andEndsAt: 1.


	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10
]

{ #category : #tests }
BoardTest >> test072WhenBoardHasMoreParsecsThanSquaresThenSpaceshipMovesTwoParsecsAndOneSquare [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares aParsecDistance spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData := OrderedCollection with:
		                  (SpaceshipData randomCardsfor: aSpaceship).
	aParsecDistance := ParsecDistance of: 2.

	hyperJumpEffect := Square with: (HyperJumpEffect
			                    isIn: 6
			                    movesDistance:
			                    (OrderedCollection with: aParsecDistance)).
	squares := ZeroBasedArray newEmpty.
	0 to: 19 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect.
	aBoard := Board
		          with: squares
		          parsecs: 40
		          wormholeBeginsAt: 0
		          andEndsAt: 1.


	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
BoardTest >> test073SpaceshipOnlyMovesWhenParsecsToSquaresRatioIsAnEvenNumber [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares aParsecDistance spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData := OrderedCollection with:
		                  (SpaceshipData randomCardsfor: aSpaceship).
	aParsecDistance := ParsecDistance of: 3.

	hyperJumpEffect := Square with: (HyperJumpEffect
			                    isIn: 6
			                    movesDistance:
			                    (OrderedCollection with: aParsecDistance)).
	squares := ZeroBasedArray newEmpty.
	0 to: 19 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect.
	aBoard := Board
		          with: squares
		          parsecs: 40
		          wormholeBeginsAt: 0
		          andEndsAt: 1.


	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
BoardTest >> test074SpaceshipLosesALapIfItGetsSentBackPastTheFirstSquare [

	| aGame aSpaceship aBoard aDie blackholeEffect squares spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	blackholeEffect :=Square with: (BlackholeEffect isIn: 2).
	squares := ZeroBasedArray newEmpty .
	0 to: 4 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 2 put: blackholeEffect .
	aBoard := Board with: squares  parsecs: 20 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 7.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame lapsOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test075SpaceshipCantGoBackFurtherThanTheFirstSquareOnTheFirstLap [

	| aGame aSpaceship aBoard aDie blackholeEffect squares spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).
	blackholeEffect :=Square with:( BlackholeEffect isIn: 3).
	squares := ZeroBasedArray newEmpty .
	0 to: 4 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 3 put: blackholeEffect .
	aBoard := Board with: squares  parsecs: 20 wormholeBeginsAt: 0 andEndsAt: 1.

	aDie := LoadedDie of: 3.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test076IfSpaceshipCompletesALapAndGoesBackBeyondTheFirstSquareThenItLosesTheLap [

	| aGame aSpaceship aBoard aDie spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship).

	aBoard := self createBoardOf: 10 parsecs: 10 withEffects: { BlackholeEffect isIn: 2 } wormholeBeginsAt: 8 andEndsAt: 9.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 2).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 2.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame lapsOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test077WhenSpaceshipGoesBackMultipleLapsWithMoonwalkEffectThenLosesThoseLaps [

	| aGame aSpaceship anotherSpaceship aBoard aDie moonwalkEffect squares spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship) with: (SpaceshipData randomCardsfor: anotherSpaceship).
	moonwalkEffect :=Square with:( MoonWalkEffect isIn: 4 moves: 10).
	squares := ZeroBasedArray newEmpty .
	0 to: 4 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: moonwalkEffect .
	aBoard := Board with: squares  parsecs: 5 wormholeBeginsAt: 1 andEndsAt: 2.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 11 with: 4).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame lapsOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test081HyperJumpEffectCanJumpLightyears [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares aLightyearDistance spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData := OrderedCollection with:
		                  (SpaceshipData randomCardsfor: aSpaceship).
	aLightyearDistance := LightyearDistance of: 3.
	hyperJumpEffect := Square with: (HyperJumpEffect
			                    isIn: 4
			                    movesDistance:
			                    (OrderedCollection with: aLightyearDistance)).
	squares := ZeroBasedArray newEmpty.
	0 to: 4 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: hyperJumpEffect.
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 1
		          andEndsAt: 2.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 0
]

{ #category : #tests }
BoardTest >> test082HyperJumpEffectStoresParsecAndLightYearArray [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares aLightyearDistance aParsecDistance spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData := OrderedCollection with:
		                  (SpaceshipData randomCardsfor: aSpaceship).
	aLightyearDistance := LightyearDistance of: 3.
	aParsecDistance := ParsecDistance of: 4.
	hyperJumpEffect := Square with: (HyperJumpEffect
			                    isIn: 4
			                    movesDistance:
			                    (OrderedCollection
				                     with: aLightyearDistance
				                     with: aParsecDistance)).
	squares := ZeroBasedArray newEmpty.
	0 to: 4 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: hyperJumpEffect.
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 1
		          andEndsAt: 2.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 3
]

{ #category : #tests }
BoardTest >> test121WhenSpaceshipUsesRepeatCardAndMovesFurtherThanTheLastSquareThenGainsALap [

	| aGame aSpaceship anotherSpaceship yetAnotherSpaceship aCard aBoard aDie spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData := OrderedCollection
		                  with: (SpaceshipData randomCardsfor: aSpaceship)
		                  with:
		                  (SpaceshipData randomCardsfor: anotherSpaceship)
		                  with: (SpaceshipData
				                   for: yetAnotherSpaceship
				                   withDeck:
				                   (OrderedCollection
					                    with: RepeatCard
					                    with: RedoCard)).
	aBoard := self
		          createBoardOf: 6
		          parsecs: 6
		          withEffects: { (HyperJumpEffect
				           isIn: 3
				           movesDistance:
				           (OrderedCollection with: (ParsecDistance of: 7))) }
		          wormholeBeginsAt: 0
		          andEndsAt: 1.
	aDie := LoadedDie of: 3.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := RepeatCard new.
	aGame playTurn.
	aGame
		playCard: aCard
		from: yetAnotherSpaceship
		withTarget: yetAnotherSpaceship.

	self assert: (aGame lapsOf: yetAnotherSpaceship) equals: 1
]

{ #category : #tests }
BoardTest >> test131WhenBoardWithFiveSquaresAndFiveParsecsReturnsLengthInParsecsEqualsToFive [

	| aBoard |
	aBoard := self createBoardOf: 5 parsecs: (ParsecDistance of: 5) withEffects: OrderedCollection new wormholeBeginsAt: 3 andEndsAt: 4.
	self assert: aBoard lengthInParsecs  equals: 5.
]

{ #category : #tests }
BoardTest >> test132BoardWithFiveParsecsEqualsFifteenLightYears [

	| aBoard |
	aBoard := self createBoardOf: 5 parsecs: (ParsecDistance of: 5) withEffects: OrderedCollection new wormholeBeginsAt: 3 andEndsAt: 4.
	self assert: aBoard lengthInLightYears  equals: 15.
]

{ #category : #tests }
BoardTest >> test133LengthInLightYearsEqualsThreeTimesLengthInParsecs [

	| aBoard |
	aBoard := self createBoardOf: 5 parsecs: (ParsecDistance of: 6) withEffects: OrderedCollection new wormholeBeginsAt: 3 andEndsAt: 4.
	self assert: aBoard lengthInLightYears  equals: 18.
]

{ #category : #tests }
BoardTest >> test134BoardCanExpressItsLengthInParsecs [

	| aBoard |
	aBoard := self createBoardOf: 5 parsecs: (ParsecDistance of: 6) withEffects: OrderedCollection new wormholeBeginsAt: 3 andEndsAt: 4.
	self assert: aBoard lengthInParsecs equals: 6.
]

{ #category : #tests }
BoardTest >> test135BoardCreatedWithAParsecDistance [

	| aBoard aParsecDistance |
	aParsecDistance := ParsecDistance of: 6.
	aBoard := self createBoardOf: 5 parsecs: aParsecDistance withEffects: OrderedCollection new wormholeBeginsAt: 3 andEndsAt: 4.
	self assert: aBoard lengthInParsecs equals: 6.
	
]

{ #category : #tests }
BoardTest >> test136BoardCreatedWithLightYearsDistance [

	| aBoard aLightYearsDistance |
	aLightYearsDistance := LightyearDistance of: 6.
	aBoard := self createBoardOf: 5 parsecs: aLightYearsDistance withEffects: OrderedCollection new wormholeBeginsAt: 3 andEndsAt: 4.
	self assert: aBoard lengthInLightYears equals: 6.
	
]
