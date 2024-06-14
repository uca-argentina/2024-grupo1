Class {
	#name : #BoardDistributionCreator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardDistributionCreator >> createHyperJumpIn: aSquare withParsecs: anAmountOfParsecs maximumAmountOfValues: anAmount [

	|hyperJumpEffect parsecsToMove randomAmount|
	
	parsecsToMove := OrderedCollection new.
	randomAmount := anAmount atRandom .
	randomAmount timesRepeat: [ parsecsToMove add: (anAmountOfParsecs atRandom ) ].
	
	hyperJumpEffect := HyperJumpEffect isIn: aSquare  movesParsecs: parsecsToMove  SquaresPerParsec: anAmountOfParsecs .

	^hyperJumpEffect 
]

{ #category : #action }
BoardDistributionCreator >> createOf: length with: someProbabilities withParsecs: anAmountOfParsecs maximumHyperJumpValues: anAmount [

	| squares specialEffect random lowerLimit |
	
	squares := ZeroBasedArray newEmpty.
	lowerLimit := 0.
	0 to: length - 1 do: [ :position |
		random := 100 atRandom.
		specialEffect := NullEffect isIn: position.
		someProbabilities keysAndValuesDo: [ :effect :probability |
			(random between: lowerLimit and: lowerLimit + probability) ifTrue: [
				effect = 'HyperJump' ifTrue: [
					specialEffect := self
						                 createHyperJumpIn: position
						                 withParsecs: anAmountOfParsecs
						                 maximumAmountOfValues: anAmount  ].
				effect = 'Moonwalk' ifTrue: [
					specialEffect := MoonWalkEffect
						                 isIn: position
						                 moves: length atRandom ].
				effect = 'AtomicBomb' ifTrue: [
					specialEffect := AtomicBombEffect isIn: position ].
				effect = 'Blackhole' ifTrue: [
					specialEffect := BlackholeEffect isIn: position ].
				effect = 'HyperSpaceJump' ifTrue: [
					specialEffect := HyperSpaceJumpEffect isIn: position ] ].
			lowerLimit := probability + lowerLimit ].

		squares add: (Square with: specialEffect) ].

	^ squares
]
