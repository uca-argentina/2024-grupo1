Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> test083SpeedCardWorksWithOnlyOneSpaceship [

	| aGame aSpaceship aBoard aDie  squares   aCard |
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
	aCard:= SpeedCard new.
	aGame playCard: aCard from: aSpaceship target: aSpaceship .
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
CardTest >> test084SpeedCardWorksWithMultipleSpaceships [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship:= Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf: (OrderedCollection with:4 with:4 with:3).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := SpeedCard new.
	aGame playCard: aCard from: aSpaceship target: anotherSpaceship .
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: ((((aGame positionOf: aSpaceship) =4) and: (aGame positionOf: anotherSpaceship ) =5) and: ((aGame positionOf: yetAnotherSpaceship) = 3 ))
]

{ #category : #tests }
CardTest >> test085AccelerationCardWorksWithOneSpaceship [

	| aGame aSpaceship aBoard aDie  squares   aCard |
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
	aCard:= AccelerationCard new.
	aGame playCard: aCard .
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
CardTest >> test086AccelerationCardWorksForAllSpaceShips [

	| aGame aSpaceship aBoard aDie anotherSpaceship squares aCard yetAnotherSpaceship |
	aSpaceship := Spaceship launch: 'One'.
	anotherSpaceship := Spaceship launch: 'Two'.
	yetAnotherSpaceship:= Spaceship launch: 'Three'.
	squares := ZeroBasedArray newEmpty.
	0 to: 15 do: [ :i | squares add: (Square with: (NullEffect isIn: i)) ].
	aBoard := Board
		          with: squares
		          parsecs: 5
		          wormholeBeginsAt: 13
		          andEndsAt: 14.

	aDie := LoadedDie arrayOf: (OrderedCollection with:4 with:5 with:3).
	aGame := Game
		         playedBy:
		         (OrderedCollection with: aSpaceship with: anotherSpaceship with: yetAnotherSpaceship)
		         on: aBoard
		         throwing: (OrderedCollection with: aDie)
		         wonAfter: 3.
	aCard := AccelerationCard new.
	aGame playCard: aCard .
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: ((((aGame positionOf: aSpaceship) =5) and: (aGame positionOf: anotherSpaceship ) =6) and: ((aGame positionOf: yetAnotherSpaceship) = 4 ))
]
