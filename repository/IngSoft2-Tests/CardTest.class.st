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
