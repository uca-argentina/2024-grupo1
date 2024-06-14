"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  ""A board""

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSquares',
		'boardOfSquares',
		'parsecs',
		'parsec'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> of: aNumberOfSquares wormholeBeginsAt: startingPoint andEndsAt: endPoint [

	| boardOfSquares |
	boardOfSquares := ZeroBasedArray newEmpty.
	0 to: aNumberOfSquares - 1 do: [ :square |
		boardOfSquares add: (Square with: (NullEffect isIn: square)) ].

	self validate: aNumberOfSquares and: endPoint and: startingPoint.

	^ self new
		  initializeWith: boardOfSquares
		  parsecs: 1
		  wormholeBeginsAt: startingPoint
		  andEndsAt: endPoint
]

{ #category : #'argument validation' }
Board class >> validate: aNumberOfSquares and: endPoint and: startingPoint [

	self validateSizeOf: aNumberOfSquares.
	self validate: endPoint isNotEqualTo: startingPoint.
	self
		validateWormholeEndpointsOf: startingPoint
		and: endPoint
		areWithin: aNumberOfSquares
]

{ #category : #'argument validation' }
Board class >> validate: endPoint isNotEqualTo: startingPoint [

	startingPoint = endPoint ifTrue: [
		Error signal: 'Wormhole endpoints cannot be in the same square' ]
]

{ #category : #'argument validation' }
Board class >> validateSizeOf: aNumberOfSquares [
	aNumberOfSquares <= 0 ifTrue: [ Error signal: 'Board must have at least 1 square' ].
	
]

{ #category : #'argument validation' }
Board class >> validateWormholeEndpointsOf: startingPoint and: endPoint areWithin: aNumberOfSquares [

	(startingPoint >= 0 and: (endPoint >= 0 and:
			  (startingPoint < aNumberOfSquares and:
				   endPoint <= aNumberOfSquares))) ifFalse: [
		Error signal: 'Wormhole out of bounds' ].
	
]

{ #category : #accessing }
Board class >> with: theSquares parsecs: someParsecs wormholeBeginsAt: startPoint andEndsAt: endpoint [

	^self new initializeWith: theSquares parsecs: someParsecs wormholeBeginsAt: startPoint andEndsAt: endpoint
]

{ #category : #accessing }
Board >> finalSquareAfterMovingTo: aSquare whenPlaying: aGame [

	| squaresMovedByEffect squareToLand |
	squareToLand := boardOfSquares at:
		                (self validateWithinBounds: aSquare).
	squaresMovedByEffect := squareToLand landIn: aGame.

	^ squaresMovedByEffect
]

{ #category : #initialization }
Board >> initializeOf: anAmountOfSquares parsecs: someParsecs having: someEffects [ 

	numberOfSquares := anAmountOfSquares.
	boardOfSquares := ZeroBasedArray newEmpty .
	parsecs := someParsecs.
	parsec := Parsec of: self squares // someParsecs.


	0 to: (numberOfSquares -1) do: [ :square |
		boardOfSquares add: (Square with: (NullEffect isIn: square)) ].


	someEffects keysDo: [ :index |
		boardOfSquares at: index put: (Square with: (someEffects at: index)) ]
]

{ #category : #initialization }
Board >> initializeOf: aNumberOfSquares wormholeBeginsAt: startingPoint andEndsAt: endPoint [

	numberOfSquares := aNumberOfSquares.
	boardOfSquares := ZeroBasedArray newEmpty .
	0 to: (numberOfSquares -1) do: [:square |  boardOfSquares add: (Square with: (NullEffect isIn: square) )].
	boardOfSquares at: startingPoint put: (Square with: (WormholeEffect isIn: startingPoint  goesTo: endPoint)).
	boardOfSquares at: endPoint put: (Square with: (WormholeEffect isIn: endPoint  goesTo: startingPoint)).
	
	
	
		
]

{ #category : #initialization }
Board >> initializeWith: theSquares parsecs: someParsecs wormholeBeginsAt: startingPoint andEndsAt: endPoint [

	numberOfSquares := theSquares size.
	boardOfSquares := ZeroBasedArray withAll: theSquares.
	parsecs := someParsecs.
	parsec := Parsec of: self squares // someParsecs.

	boardOfSquares at: startingPoint put: (Square with: (WormholeEffect isIn: startingPoint  goesTo: endPoint)).
	boardOfSquares at: endPoint put: (Square with: (WormholeEffect isIn: endPoint  goesTo: startingPoint)).



]

{ #category : #accessing }
Board >> squares [ 


^ boardOfSquares size.
]

{ #category : #accessing }
Board >> squaresPerParsec [

^(self squares )//parsecs
]

{ #category : #analyze }
Board >> validateWithinBounds: aSquare [

	aSquare >= self squares ifTrue: [ ^ aSquare % self squares ].
	aSquare < 0 ifTrue: [ ^0 ].

	^ aSquare
]
