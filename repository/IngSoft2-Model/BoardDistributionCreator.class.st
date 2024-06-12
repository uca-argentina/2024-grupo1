Class {
	#name : #BoardDistributionCreator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
BoardDistributionCreator >> createOf: length with: someProbabilities [ 
	|squares specialEffect random aux|
	squares := ZeroBasedArray newEmpty .
	aux:=0.
	0 to: length -1 do: [ :position | 
		random:=100 atRandom.
		specialEffect := NullEffect isIn: position  .
		someProbabilities keysAndValuesDo:  [ :effect :probability | 
			(random between: (aux) and: (aux+probability )) ifTrue: [ specialEffect := effect  ].
			aux := probability +aux  ].

		squares  add: (Square with: (specialEffect ) ) ].

	^squares


]
