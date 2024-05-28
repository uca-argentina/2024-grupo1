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
	aBoard := Board of: 6 wormholeBeginsAt: 4 andEndsAt: 5.
	aLoadedDie := LoadedDie of: 3.
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
	aLoadedDie := LoadedDie of: 3.
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
	aLoadedDie := LoadedDie of: 6.
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
	self assert: (aGame positionOf: aSpaceship) equals: 4
]

{ #category : #tests }
BoardTest >> test38WhenSpaceshipMovesTenInBoardOfEightThenGoesToSquareThree [

	| aGame aSpaceship aBoard aDie |
	aSpaceship := Spaceship launch: ''.
	aBoard := Board of: 8 wormholeBeginsAt: 2 andEndsAt: 4.
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
BoardTest >> test55WhenLandingInABlackholeSpaceshipGoesBackFourSquares [

	| aGame aSpaceship aBoard aDie specialSquares blackholeEffect |
	aSpaceship := Spaceship launch: 'One'.
	blackholeEffect := BlackholeEffect isIn: 6.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: blackholeEffect).
	aBoard := Board of: 10 parsecs: 1 with: specialSquares.
	aDie := LoadedDie of: 5.
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

	| aGame aSpaceship aBoard aDie specialSquares hyperSpaceJumpEffect |
	aSpaceship := Spaceship launch: 'One'.
	hyperSpaceJumpEffect := HyperSpaceJumpEffect isIn: 6.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: hyperSpaceJumpEffect).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
	aDie := LoadedDie of: 5.
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

	| aGame aSpaceship aBoard aDie specialSquares hyperSpaceJumpEffect |
	aSpaceship := Spaceship launch: 'One'.
	hyperSpaceJumpEffect := HyperSpaceJumpEffect isIn: 6.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: hyperSpaceJumpEffect).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
	aDie := LoadedDie of: 5.
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

	| aGame aSpaceship anotherSpaceship aBoard aDie specialSquares moonWalkEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	moonWalkEffect := MoonWalkEffect isIn: 6 moves: 3.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: moonWalkEffect).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
BoardTest >> test59WhenSpaceshipLandsOnMoonwalkSquareThenItDoesntMove [

	| aGame aSpaceship anotherSpaceship aBoard aDie specialSquares moonWalkEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	moonWalkEffect := MoonWalkEffect isIn: 6 moves: 3.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: moonWalkEffect).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 5).
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

	| aGame aSpaceship aDie aBoard atomicBombEffect specialSquare |
	aSpaceship := Spaceship launch: 'One'.
	aDie := LoadedDie of: 5.
	atomicBombEffect := AtomicBombEffect new.
	specialSquare := Dictionary
		                 newFromKeys: (OrderedCollection with: 6)
		                 andValues:
		                 (OrderedCollection with: atomicBombEffect).
	aBoard := Board of: 10 parsecs: 1 with: specialSquare.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
BoardTest >> test61WhenSpaceshipLandsOnAtomicBombEffectThenEveryoneGetsSentToSquareOne [

	| aGame aSpaceship anotherSpaceship aBoard aDie specialSquares atomicBombEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	atomicBombEffect := AtomicBombEffect new.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: atomicBombEffect).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	aGame playTurn.

	self assert: ((aGame positionOf: anotherSpaceship) = 1 and:
			 (aGame positionOf: aSpaceship) = 1)
]

{ #category : #tests }
BoardTest >> test62WhenSpaceshipLandsOnAtomicBombAllShieldsGetReducedByOne [

	| aGame aSpaceship anotherSpaceship aBoard aDie specialSquares atomicBombEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	atomicBombEffect := AtomicBombEffect new.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: atomicBombEffect).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 5).
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

	| aGame aSpaceship anotherSpaceship aBoard aDie specialSquares atomicBombEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	atomicBombEffect := AtomicBombEffect new.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: atomicBombEffect).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
	aDie := LoadedDie arrayOf: (OrderedCollection with: 3 with: 5).
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

	| aGame aSpaceship anotherSpaceship aBoard aDie specialSquares moonwalk |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	moonwalk := MoonWalkEffect isIn: 6 moves: 3.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues: (OrderedCollection with: moonwalk).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
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

	| aGame aSpaceship anotherSpaceship aBoard aDie specialSquares blackholeEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	blackholeEffect := BlackholeEffect isIn: 6.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: blackholeEffect).
	aBoard := Board of: 11 parsecs: 1 with: specialSquares.
	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 1 with: 5 with: 5).
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

	| aGame aSpaceship aBoard aDie specialSquares hyperJumpEffect |
	aSpaceship := Spaceship launch: 'One'.

	hyperJumpEffect := HyperJumpEffect
		                   isIn: 6
		                   movesParsecs: (OrderedCollection with: 1)
		                   SquaresPerParsec: 1.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: hyperJumpEffect).
	aBoard := Board of: 11 parsecs: 11 with: specialSquares.
	aDie := LoadedDie of: 5.
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

	| aGame aSpaceship anotherSpaceship yetAnotherSpaceship aBoard aDie specialSquares hyperJumpEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	hyperJumpEffect := HyperJumpEffect
		                   isIn: 6
		                   movesParsecs:
		                   (OrderedCollection with: -1 with: 2)
		                   SquaresPerParsec: 1.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: hyperJumpEffect).
	aBoard := Board of: 11 parsecs: 11 with: specialSquares.
	aDie := LoadedDie of: 5.
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
				  (aGame positionOf: yetAnotherSpaceship) = 1))
]

{ #category : #tests }
BoardTest >> test71WhenSpaceshipLandsOnHyperJumpSquareGetsMovedOneParsecAndFourSquares [

	| aGame aSpaceship aBoard aDie specialSquares hyperJumpEffect |
	aSpaceship := Spaceship launch: 'One'.
	
	hyperJumpEffect  := HyperJumpEffect isIn: 6 movesParsecs: (OrderedCollection with: 1) SquaresPerParsec: 4.
	specialSquares := Dictionary
		                  newFromKeys: (OrderedCollection with: 6)
		                  andValues:
		                  (OrderedCollection with: hyperJumpEffect ).
	aBoard := Board of: 20 parsecs: 5 with: specialSquares.
	aDie := LoadedDie of: 5.
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship )
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aGame playTurn.
	
	self assert: (aGame positionOf: aSpaceship ) equals: 10
]
