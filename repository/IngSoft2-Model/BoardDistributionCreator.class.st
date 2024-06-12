Class {
	#name : #BoardDistributionCreator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardDistributionCreator >> createHyperJumpIn: aSquare withParsecs: anAmountOfParsecs [

	|hyperJumpEffect parsecsToMove randomAmount|
	
	parsecsToMove := OrderedCollection new.
	randomAmount := 7 atRandom .
	randomAmount timesRepeat: [ parsecsToMove add: (anAmountOfParsecs atRandom ) ].
	
	hyperJumpEffect := HyperJumpEffect isIn: aSquare  movesParsecs: parsecsToMove  SquaresPerParsec: anAmountOfParsecs .

	^hyperJumpEffect 
]

{ #category : #action }
BoardDistributionCreator >> createOf: length with: someProbabilities withParsecs: anAmountOfParsecs [ 
	|squares specialEffect random aux|
	squares := ZeroBasedArray newEmpty .
	aux:=0.
	0 to: length -1 do: [ :position | 
		random:=100 atRandom.
		specialEffect := NullEffect isIn: position  .
		someProbabilities keysAndValuesDo:  [ :effect :probability | 
			(random between: (aux) and: (aux+probability )) ifTrue: [ 
				effect = 'HyperJump' ifTrue:  [ specialEffect := self createHyperJumpIn: position  withParsecs: anAmountOfParsecs  ].
				effect = 'Moonwalk' ifTrue: [ specialEffect := MoonWalkEffect isIn: position  moves: length atRandom  ].
				effect = 'AtomicBomb' ifTrue: [ specialEffect := AtomicBombEffect isIn: position  ].
				effect = 'Blackhole' ifTrue: [ specialEffect := BlackholeEffect isIn: position  ].
				effect = 'HyperSpaceJump' ifTrue: [ specialEffect := HyperSpaceJumpEffect isIn: position  ]. ].
			aux := probability +aux  ].

		squares  add: (Square with: (specialEffect ) ) ].

	^squares


]
