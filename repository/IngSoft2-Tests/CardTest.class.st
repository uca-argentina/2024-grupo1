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

	| aGame aSpaceship aBoard aDie squares aCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard with: SpeedCard)  ).
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: SpeedCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship   ).
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
		         playedBy: spaceshipsData 
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

	| aGame aSpaceship aBoard aDie squares aCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: AccelerationCard )  ) .
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: AccelerationCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship fourthSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	fourthSpaceship := Spaceship launch: 'Four'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: MercenaryCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ) with: (SpaceshipData randomCardsfor: fourthSpaceship ).
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
		         playedBy: spaceshipsData 
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship fourthSpaceship anotherCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	fourthSpaceship := Spaceship launch: 'Four'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: MercenaryCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ) with: (SpaceshipData randomCardsfor: fourthSpaceship ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship anotherCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: SpeedCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship anotherCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: AccelerationCard  with: AccelerationCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ) .
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship fourthSpaceship spaceshipsData anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	fourthSpaceship := Spaceship launch: 'Four'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: MercenaryCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: MercenaryCard  with: MercenaryCard )) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ) with: (SpaceshipData randomCardsfor: fourthSpaceship ).
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
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := MercenaryCard new.
	anotherCard := MercenaryCard new.
	aGame
		playCard: aCard
		from: aSpaceship
		withTarget: yetAnotherSpaceship.
	aGame playTurn.
	self
		should: [
			aGame
				playCard: anotherCard
				from: anotherSpaceship
				withTarget: yetAnotherSpaceship ]
		raise: Error
		withMessage: 'Selected spaceship is already a mercenary'
]

{ #category : #tests }
CardTest >> test094ASpaceshipDoesNotBattleWithItsMercenary [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: MercenaryCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ).
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 4 with: 4).
	aGame := Game
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: CancellationCard  with: AccelerationCard ) ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie squares aCard anotherCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: CancellationCard )  ).
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie squares aCard anotherCard spaceshipsData yetAnotherCard |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: CancellationCard   with: CancellationCard )).
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard := CancellationCard new.
	yetAnotherCard:= CancellationCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playCard: anotherCard from: aSpaceship withTarget: aCard.

	self
		should: [
		aGame playCard: yetAnotherCard from: aSpaceship withTarget: aCard ]
		raise: Error
		withMessage: 'Selected card is not active'
]

{ #category : #tests }
CardTest >> test098PermanentCardCannotBePlayedOutOfTurn [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: CancellationCard  with: AccelerationCard ) ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard ))  with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: CancellationCard  with: AccelerationCard )).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard new with: AccelerationCard new)  ) with: (SpaceshipData randomCardsfor:  anotherSpaceship ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RedoCard  with: AccelerationCard ) ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard anotherCard spaceshipsData yetAnotherCard |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard  with: RedoCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RedoCard  with: AccelerationCard ) ).
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
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard := RedoCard new.
	yetAnotherCard:= RedoCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	aGame playTurn.
	aGame
		playCard: anotherCard
		from: anotherSpaceship
		withTarget: anotherSpaceship.
	aGame playTurn.
	aGame
		playCard: yetAnotherCard
		from: aSpaceship 
		withTarget: aSpaceship .
	aGame playTurn.
	self assert: ((aGame positionOf: aSpaceship) = 11 and:
			 (aGame positionOf: anotherSpaceship) = 6)
]

{ #category : #tests }
CardTest >> test103RedoCardCannotBePlayedFirst [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares  anotherCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RedoCard  with: AccelerationCard ) ).
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 4 with: 5).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard blackholeEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard  with: AccelerationCard ) ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard  with: AccelerationCard ) ).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 4
		          andEndsAt: 8.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 4 with: 5).
	aGame := Game
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie hyperJumpEffect squares aParsecDistance anotherSpaceship aCard anotherParsecDistance spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard with: AccelerationCard)  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard with: AccelerationCard) ).
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
		         playedBy: spaceshipsData
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

	| aGame aSpaceship aBoard aDie anotherSpaceship yetAnotherSpaceship aCard  spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: RepeatCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard  with: AccelerationCard ) ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship ).
	aBoard := self createBoardOf: 20 parsecs: 20 withEffects: (OrderedCollection with: (MoonWalkEffect isIn: 6  moves: 2) ) wormholeBeginsAt: 18 andEndsAt: 19.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 4 with: 6).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 1.
	aCard:= RepeatCard new.
	
	aGame playTurn.
	aGame playTurn.
	aGame playCard: aCard from: aSpaceship  withTarget: aSpaceship.

	self assert: (((aGame positionOf: yetAnotherSpaceship) = 0) and: (((aGame positionOf: aSpaceship) = 2) and: ((aGame positionOf: anotherSpaceship ) = 4))   ) 
]

{ #category : #tests }
CardTest >> test108RepeatCardWorksWithHyperSpaceJumpEffect [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard hyperSpaceJumpEffect yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: RepeatCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard  with: AccelerationCard ) ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship).
	hyperSpaceJumpEffect :=Square with:( HyperSpaceJumpEffect  isIn: 4).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: hyperSpaceJumpEffect .
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 8
		          andEndsAt: 9.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 4).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := RepeatCard new.
	aGame playTurn.
	aGame playTurn.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship  .
	
	self assert: (((aGame positionOf: aSpaceship)  = 9) and: ((aGame shieldsOf: aSpaceship) = 2)).
]

{ #category : #tests }
CardTest >> test109RepeatCardWorksWithAtomicBombEffect [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard atomicBombEffect yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: RepeatCard with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard with: AccelerationCard ) ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship).
	atomicBombEffect :=Square with:( AtomicBombEffect  isIn: 4).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: atomicBombEffect .
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 8
		          andEndsAt: 9.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 4).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := RepeatCard new.
	aGame playTurn.
	aGame playTurn.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship  .
	
	self assert: ((((aGame shieldsOf: aSpaceship)  = 1) and: ((aGame shieldsOf: anotherSpaceship ) = 1)) and: (aGame shieldsOf: yetAnotherSpaceship)=1) .
]

{ #category : #tests }
CardTest >> test110RepeatCardDoesNothingIfLastSquareHadNoEffect [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: RepeatCard with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard with: AccelerationCard ) ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 8
		          andEndsAt: 9.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 4).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := RepeatCard new.
	aGame playTurn.
	aGame playTurn.
	aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship  .
	
	self assert: (((aGame shieldsOf: anotherSpaceship )  = 3) and: ((aGame positionOf: anotherSpaceship ) = 4)) .
]

{ #category : #tests }
CardTest >> test111IfNoSpaceshipHasPlayedYetRepeatCardHasNoEffect [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: RepeatCard with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard with: AccelerationCard ) ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 8
		          andEndsAt: 9.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 4).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := RepeatCard new.
	aGame playCard: aCard from: aSpaceship withTarget: anotherSpaceship  .
	
	self assert: (((aGame shieldsOf: anotherSpaceship )  = 3) and: ((aGame positionOf: anotherSpaceship ) = 0)) .
]

{ #category : #tests }
CardTest >> test112SpaceshipDataCanBeCreatedWithTwoRandomCards [

	|  aSpaceship aSpaceshipData  |
	aSpaceship := Spaceship launch: 'One'.
	aSpaceshipData:= SpaceshipData randomCardsfor: aSpaceship .
	
	self assert: (aSpaceshipData cards size) equals:2 .
]

{ #category : #tests }
CardTest >> test113SpaceshipDataIsCreatedWithRandomValidCards [

	|  aSpaceship    aSpaceshipData cardTypes |
	aSpaceship := Spaceship launch: 'One'.
	aSpaceshipData:= SpaceshipData randomCardsfor: aSpaceship .
	cardTypes := OrderedCollection
		             with: AccelerationCard
		             with: SpeedCard
		             with: MercenaryCard
		             with: RedoCard
		             with: RepeatCard.
	
	self assert: (aSpaceshipData cards allSatisfy: [:card | cardTypes includes: (card class) ]) .
]

{ #category : #tests }
CardTest >> test114ASpaceshipCannotPlayACardThatIsNotInItsHand [

	| aGame aSpaceship aBoard aDie squares aCard spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: AccelerationCard with: AccelerationCard)  ).
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	
	self should: [ aGame playCard: aCard from: aSpaceship withTarget: aSpaceship ] raise: Error withMessage: 'A Spaceship cannot play a card that is not in its hand'
]

{ #category : #tests }
CardTest >> test115IfASpaceshipPlaysACardItIsRemovedFromItsHand [

	| aGame aSpaceship aBoard aDie squares aCard spaceshipsData anotherCard |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: SpeedCard with: AccelerationCard)  ).
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	anotherCard:= SpeedCard new.
	aGame playCard: aCard from: aSpaceship withTarget: aSpaceship.
	
	self should: [ aGame playCard: anotherCard from: aSpaceship withTarget: aSpaceship ] raise: Error withMessage: 'A Spaceship cannot play a card that is not in its hand'
]

{ #category : #tests }
CardTest >> test116MysteryCardEffectAddsACardToASpaceshipThatLandsInIt [

	| aGame aSpaceship aBoard aDie squares spaceshipsData mysteryCardEffect |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData randomCardsfor: aSpaceship  ).
	mysteryCardEffect :=Square with:( MysteryCardEffect isIn: 4).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: mysteryCardEffect .
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 8
		          andEndsAt: 9.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aGame playTurn .
	
	self assert: (spaceshipsData first cards size) equals: 3
]

{ #category : #tests }
CardTest >> test117MysteryCardEffectAddsValidCardTypesToSpaceships [

	| aGame aSpaceship aBoard aDie squares spaceshipsData mysteryCardEffect cardTypes |
	aSpaceship := Spaceship launch: 'One'.
	spaceshipsData := OrderedCollection with:
		                  (SpaceshipData randomCardsfor: aSpaceship).
	mysteryCardEffect := Square with: (MysteryCardEffect isIn: 4).
	squares := ZeroBasedArray newEmpty.
	0 to: 9 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: mysteryCardEffect.
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 8
		          andEndsAt: 9.

	aDie := LoadedDie of: 4.
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	cardTypes := OrderedCollection
		             with: AccelerationCard
		             with: SpeedCard
		             with: MercenaryCard
		             with: RedoCard
		             with: RepeatCard.
	aGame playTurn.


	self assert: (spaceshipsData first cards allSatisfy: [ :card |
			 cardTypes includes: card class ])
]

{ #category : #tests }
CardTest >> test118MercenarySpaceshipDoesNotRecieveHelpFromItsAlly [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship := Spaceship launch: 'Three'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard )  ) with: (SpaceshipData randomCardsfor: anotherSpaceship ) with: (SpaceshipData randomCardsfor: yetAnotherSpaceship  ).
	squares := ZeroBasedArray newEmpty.
	0 to: 7 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 6
		          andEndsAt: 7.

	aDie := LoadedDie arrayOf:
		        (OrderedCollection with: 1 with: 4 with: 4).
	aGame := Game
		         playedBy: spaceshipsData
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
	self assert: (aGame positionOf: yetAnotherSpaceship ) equals: 0 
]

{ #category : #tests }
CardTest >> test119RepeatCardWorksWithMysteryCardEffect [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard mysteryCardEffect spaceshipsData |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	spaceshipsData:= OrderedCollection with: (SpaceshipData for: aSpaceship  withDeck: (OrderedCollection with: MercenaryCard  with: AccelerationCard )  ) with: (SpaceshipData for: anotherSpaceship withDeck: (OrderedCollection with: RepeatCard  with: AccelerationCard ) ).
	mysteryCardEffect :=Square with:( MysteryCardEffect isIn: 4).
	squares := ZeroBasedArray newEmpty .
	0 to: 9 do: [: i| squares add: (Square with: (NullEffect isIn: i)) ].
	squares at: 4 put: mysteryCardEffect .
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 8
		          andEndsAt: 9.

	aDie := LoadedDie arrayOf: (OrderedCollection with: 5 with: 4).
	aGame := Game
		         playedBy: spaceshipsData
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := RepeatCard new.
	aGame playTurn.
	aGame playTurn.
	aGame playCard: aCard from: anotherSpaceship withTarget: aSpaceship .
	
	self assert: (spaceshipsData first cards size) equals: 3.
]
