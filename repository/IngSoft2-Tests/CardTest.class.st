Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'set up' }
CardTest >> createBoardOf: length parsecs: someParsecs withEffects: someEffects wormholeBeginsAt: startPoint andEndsAt: endPoint [

	| squares |
	squares := ZeroBasedArray newEmpty .
	0 to: length -1 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	
	someEffects do: [ :effect | squares at: (effect position) put: (Square with:effect)  ].
	^Board with: squares  parsecs: someParsecs  wormholeBeginsAt: startPoint  andEndsAt: endPoint .
]

{ #category : #asserting }
CardTest >> should: anErrorBlock raise: anError withMessage: errorMessage [ 

	

self 
	should: anErrorBlock 
	raise: anError 
	withExceptionDo: [ :error |
										self assert: error messageText  equals: errorMessage  ]

]

{ #category : #tests }
CardTest >> test083SpeedCardWorksWithOnlyOneSpaceship [

	| aGame aSpaceship aBoard aDie squares aCard |
	aSpaceship := Spaceship launch: 'One'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
CardTest >> test084SpeedCardWorksWithMultipleSpaceships [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 3).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (((aGame positionOf: aSpaceship) = 4 and:
			  (aGame positionOf: anotherSpaceship) = 5) and:
			 (aGame positionOf: yetAnotherSpaceship) = 3)
]

{ #category : #tests }
CardTest >> test085AccelerationCardWorksWithOneSpaceship [

	| aGame aSpaceship aBoard aDie squares aCard |
	aSpaceship := Spaceship launch: 'One'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := AccelerationCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
CardTest >> test086AccelerationCardWorksForAllSpaceShips [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 5 with: 3).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := AccelerationCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (((aGame positionOf: aSpaceship) = 5 and:
			  (aGame positionOf: anotherSpaceship) = 6) and:
			 (aGame positionOf: yetAnotherSpaceship) = 4)
]

{ #category : #tests }
CardTest >> test087MercenaryCardCanRecruitOneMercenaryThatHelpsInBattles [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 5).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	aGame
		playCard: aCard
		from: aSpaceship
		withTarget: yetAnotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	self assert: ((aGame positionOf: aSpaceship) = 4 and:
			 (aGame positionOf: anotherSpaceship) = 0)
]

{ #category : #tests }
CardTest >> test088IfSpaceshipAndOneMercenaryLoseTheBattleBothLoseShields [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 9).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	aGame
		playCard: aCard
		from: aSpaceship
		withTarget: yetAnotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	self assert: ((aGame shieldsOf: aSpaceship) = 2 and:
			 (aGame shieldsOf: yetAnotherSpaceship) = 2)
]

{ #category : #tests }
CardTest >> test089ASpaceshipCanRecruitMultipleMercenariesThetHelpInBattle [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship fourthSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	fourthSpaceship := Spaceship launch: 'Four'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 9).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship
				          with: fourthSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	aGame
		playCard: aCard
		from: aSpaceship
		withTarget: yetAnotherSpaceship.
	aGame playCard: aCard from: aSpaceship withTarget: fourthSpaceship.
	aGame playTurn.
	aGame playTurn.
	self assert: ((aGame positionOf: aSpaceship) = 4 and:
			 (aGame positionOf: anotherSpaceship) = 0)
]

{ #category : #tests }
CardTest >> test090IfSpaceshipAndMultipleMercenariesLoseTheBattleTheyAllLoseShields [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship fourthSpaceship anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	fourthSpaceship := Spaceship launch: 'Four'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf: (OrderedCollection
			         with: 4
			         with: 4
			         with: 13
			         with: 4).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship
				          with: fourthSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	anotherCard := MercenaryCard new.
	aGame
		playCard: aCard
		from: aSpaceship
		withTarget: yetAnotherSpaceship.
	aGame
		playCard: anotherCard
		from: aSpaceship
		withTarget: fourthSpaceship.
	aGame playTurn.
	aGame playTurn.
	self assert: (((aGame shieldsOf: aSpaceship) = 2 and:
			  (aGame shieldsOf: yetAnotherSpaceship) = 2) and:
			 (aGame shieldsOf: fourthSpaceship) = 2)
]

{ #category : #tests }
CardTest >> test091MultipleSpeedCardsCanBeActiveAtTheSameTime [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 3).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard := SpeedCard new.
	aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship.
	aGame
		playCard: anotherCard
		from: aSpaceship
		withTarget: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (((aGame positionOf: aSpaceship) = 8 and:
			  (aGame positionOf: anotherSpaceship) = 12) and:
			 (aGame positionOf: yetAnotherSpaceship) = 3)
]

{ #category : #tests }
CardTest >> test092MultipleAccelerationCardsCanBeActiveAtTheSameTime [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 5 with: 4 with: 3).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := AccelerationCard new.
	anotherCard := AccelerationCard new.
	aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship.
	aGame
		playCard: anotherCard
		from: aSpaceship
		withTarget: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (((aGame positionOf: aSpaceship) = 7 and:
			  (aGame positionOf: anotherSpaceship) = 6) and:
			 (aGame positionOf: yetAnotherSpaceship) = 5)
]

{ #category : #tests }
CardTest >> test093MultipleSpaceshipsCannotHaveTheSameMercenary [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship fourthSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	fourthSpaceship := Spaceship launch: 'Four'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 9).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship
				          with: fourthSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	aGame
		playCard: aCard
		from: aSpaceship
		withTarget: yetAnotherSpaceship.
	aGame playTurn.
	self
		should: [
			aGame
				playCard: aCard
				from: anotherSpaceship
				withTarget: yetAnotherSpaceship ]
		raise: Error
		withMessage: 'Selected spaceship is already a mercenary'
]

{ #category : #tests }
CardTest >> test094ASpaceshipDoesNotBattleWithItsMercenary [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 4 with: 4).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	self assert: ((aGame positionOf: aSpaceship) = 4 and:
			 (aGame positionOf: anotherSpaceship) = 4)
]

{ #category : #tests }
CardTest >> test095CancellationCardCanRemoveActiveMercenaryCards [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	anotherCard := CancellationCard new.
	aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship.
	aGame playTurn.
	aGame playCard: anotherCard from: anotherSpaceship withTarget: aCard.
	aGame playTurn.
	self assert: ((aGame positionOf: aSpaceship) = 0 and:
			 (aGame positionOf: anotherSpaceship) = 4)
]

{ #category : #tests }
CardTest >> test096CancellationCardCanRemoveActiveMovementCards [

	| aGame aSpaceship aBoard aDie squares aCard anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard := CancellationCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playCard: anotherCard from: aSpaceship withTarget: aCard.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 4
]

{ #category : #tests }
CardTest >> test097CancellationCardCanNotBePlayedOnACardThatIsNotActive [

	| aGame aSpaceship aBoard aDie squares aCard anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard := CancellationCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playCard: anotherCard from: aSpaceship withTarget: aCard.

	self
		should: [
		aGame playCard: anotherCard from: aSpaceship withTarget: aCard ]
		raise: Error
		withMessage: 'Selected card is not active'
]

{ #category : #tests }
CardTest >> test098PermanentCardCannotBePlayedOutOfTurn [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 3).
	aGame := Game
		         playedBy: (OrderedCollection
				          with: aSpaceship
				          with: anotherSpaceship
				          with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	aGame playTurn.
	self
		should: [
		aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship ]
		raise: Error
		withMessage: 'Card cannot be played out of turn'
]

{ #category : #tests }
CardTest >> test099InstantaneousCardCanBePlayedOutOfTurn [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	anotherCard := CancellationCard new.
	aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship.
	aGame playCard: anotherCard from: anotherSpaceship withTarget: aCard.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 4
]

{ #category : #tests }
CardTest >> test100CardsCannotBePlayedAfterGameIsOver [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 4 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.

	aGame end.
	self
		should: [
		aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship ]
		raise: Error
		withMessage: 'Cards cannot be played after game is over'
]

{ #category : #tests }
CardTest >> test101RedoCardCanCopyLastCardPlayed [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 5 with: 3).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard := RedoCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playTurn.
	aGame
		playCard: anotherCard
		from: anotherSpaceship
		withTarget: anotherSpaceship.
	aGame playTurn.
	self assert: ((aGame positionOf: aSpaceship) = 5 and:
			 (aGame positionOf: anotherSpaceship) = 6)
]

{ #category : #tests }
CardTest >> test102RedoCardCanCopyAnotherRedoCard [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 4 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard := RedoCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playTurn.
	aGame
		playCard: anotherCard
		from: anotherSpaceship
		withTarget: anotherSpaceship.
	aGame playTurn.
	aGame
		playCard: anotherCard
		from: aSpaceship 
		withTarget: aSpaceship .
	aGame playTurn.
	self assert: ((aGame positionOf: aSpaceship) = 11 and:
			 (aGame positionOf: anotherSpaceship) = 6)
]

{ #category : #tests }
CardTest >> test103RedoCardCannotBePlayedFirst [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 4 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard := RedoCard new.
	aGame playTurn.

	self
		should: [
			aGame
				playCard: anotherCard
				from: anotherSpaceship
				withTarget: anotherSpaceship ]
		raise: Error
		withMessage: 'There are no cards played to redo'
]

{ #category : #tests }
CardTest >> test104RepeatCardWorksWithBlackholeEffect [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard blackholeEffect |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	blackholeEffect :=Square with:( BlackholeEffect isIn: 4).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: blackholeEffect .
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 8
		          andEndsAt: 9.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 4).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := RepeatCard new.
	aGame playTurn.
	aGame playTurn.
	aGame playCard: aCard from: anotherSpaceship withTarget: aSpaceship  .
	
	self assert: (aGame positionOf: aSpaceship ) equals: 1.
]

{ #category : #tests }
CardTest >> test105RepeatCardWorksWithWormholeEffect [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 4
		          andEndsAt: 8.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 4 with: 5).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := RepeatCard new.
	aGame playTurn.
	aGame playCard: aCard from: anotherSpaceship withTarget: anotherSpaceship .
	
	self assert: (aGame positionOf: anotherSpaceship) equals: 8.
]

{ #category : #tests }
CardTest >> test106RepeatCardWorksWithHyperJump [

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares aParsecDistance anotherSpaceship aCard anotherParsecDistance |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	aParsecDistance:= ParsecDistance of: 1 withRatio: 20/5. 
	anotherParsecDistance:= ParsecDistance of: 2 withRatio: 20/5.
	hyperJumpEffect :=Square with: (HyperJumpEffect
		                   isIn: 6
		                   movesDistance: (OrderedCollection with: aParsecDistance with: anotherParsecDistance)).
	squares := ZeroBasedArray newEmpty .
	0 to: 19 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 6 put: hyperJumpEffect    .
	aBoard := Board with: squares  parsecs: 5 wormholeBeginsAt: 0 andEndsAt: 1.


	aDie := LoadedDie of: 6.
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship )
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aCard:= RepeatCard new.
	aGame playTurn.
	aGame playCard: aCard from: anotherSpaceship withTarget: anotherSpaceship .

	self assert: (aGame positionOf: anotherSpaceship) equals: 4
]

{ #category : #tests }
CardTest >> test107RepeatCardWorksWithMoonWalk [

	| aGame aSpaceship aBoard aDie anotherSpaceship yetAnotherSpaceship aCard  |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	
	aBoard := self createBoardOf: 20 parsecs: 20 withEffects: (OrderedCollection with: (MoonWalkEffect isIn: 6  moves: 2) ) wormholeBeginsAt: 18 andEndsAt: 19.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 4 with: 6).
	aGame := Game
		         playedBy: (OrderedCollection with: aSpaceship with: anotherSpaceship with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aCard:= RepeatCard new.
	
	aGame playTurn.
	aGame playTurn.
	aGame playCard: aCard from: aSpaceship  withTarget: aSpaceship.

	self assert: (((aGame positionOf: yetAnotherSpaceship) = 0) and: (((aGame positionOf: aSpaceship) = 2) and: ((aGame positionOf: anotherSpaceship ) = 4))   ) 
]
