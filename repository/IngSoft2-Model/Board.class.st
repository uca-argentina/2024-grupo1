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
Board class >> of: squares parsecs: someParsecs with: someEffects [ 
	^self new initializeOf: squares parsecs: someParsecs  with: someEffects 
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfSquares parsecs: aNumberOfParsecs withHyperJumpIn: aSquare movesParsecs: someParsecs [ 
^self new initializeOf: aNumberOfSquares  parsecs: aNumberOfParsecs  withHyperJumpIn: aSquare movesParsecs: someParsecs 
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfSquares wormholeBeginsAt: startingPoint andEndsAt: endPoint [

	self
		validate: aNumberOfSquares
		and: endPoint
		and: startingPoint.
		
	^ self new
		  initializeOf: aNumberOfSquares
		  wormholeBeginsAt: startingPoint
		  andEndsAt: endPoint
]

{ #category : #'instance creation' }
Board class >> randomOf: aNumberOfSquares parsecs: aNumberOfParsecs wormholeBeginsAt: startingPoint andEndsAt: endPoint [ 

	self
		validate: aNumberOfSquares
		and: endPoint
		and: startingPoint.
		
	^ self new
		  initializeRandomOf: aNumberOfSquares
			parsecs: aNumberOfParsecs 
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
Board >> checkLapsIn: aGame AfterMoving: squaresMoved [

	aGame updateLaps: squaresMoved // self squares.
	squaresMoved <= 0 ifTrue: [ aGame updateLaps: -1 ].
	aGame players 
]

{ #category : #initialization }
Board >> createHyperJumpIn: aSquare [

	|hyperJumpEffect parsecsToMove randomAmount|
	
	parsecsToMove := OrderedCollection new.
	randomAmount := 7 atRandom .
	randomAmount timesRepeat: [ parsecsToMove add: (parsecs atRandom ) ].
	
	hyperJumpEffect := HyperJumpEffect isIn: aSquare  movesParsecs: parsecsToMove  SquaresPerParsec: parsec .

	^hyperJumpEffect 
]

{ #category : #accessing }
Board >> finalSquareFor: aSpaceship afterLandingIn: aSquare whenPlaying: aGame [

	| aux squaresMoved finalSquare aux1 |
	aux1 := boardOfSquares at:
		        (self
			         validateThat: aSpaceship 
			         isWithinBounds: aSquare
			         whenPlaying: aGame).
	aux := aux1 landIn: aGame.
	squaresMoved := aux1 position + aux.
	"	self checkLapsIn: aGame AfterMoving: squaresMoved."
	finalSquare := self
		               validateThat: aSpaceship 
		               isWithinBounds: squaresMoved
		               whenPlaying: aGame.
	^ finalSquare
]

{ #category : #initialization }
Board >> initializeOf: squares parsecs: someParsecs with: someEffects [ 
	numberOfSquares := squares.
	boardOfSquares := OrderedCollection new.
	parsecs := someParsecs .
	parsec := Parsec of: (self squares //someParsecs ).
	
	
	1 to: numberOfSquares do: [:square |  boardOfSquares add: (Square with: (NullEffect isIn: square) )].
	
	
	someEffects keysDo:  [ :index | boardOfSquares at: index put: (Square with: (someEffects at: index )) ] 
	
]

{ #category : #initialization }
Board >> initializeOf: aNumberOfSquares  parsecs: aNumberOfParsecs  withHyperJumpIn: aSquare movesParsecs: someParsecs [ 

	numberOfSquares := aNumberOfSquares .
	boardOfSquares := OrderedCollection new.
	parsecs := aNumberOfParsecs  .
	parsec := Parsec of: (numberOfSquares  / aNumberOfParsecs  ).
	
	1 to: numberOfSquares do: [:square |  boardOfSquares add: (Square with: (NullEffect isIn: square) )].
	boardOfSquares at: aSquare put: (Square with: (HyperJumpEffect isIn: aSquare  movesParsecs: someParsecs  SquaresPerParsec:  parsec )).
]

{ #category : #initialization }
Board >> initializeOf: aNumberOfSquares wormholeBeginsAt: startingPoint andEndsAt: endPoint [

	numberOfSquares := aNumberOfSquares.
	boardOfSquares := OrderedCollection new.
	1 to: numberOfSquares do: [:square |  boardOfSquares add: (Square with: (NullEffect isIn: square) )].
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
Board >> validateThat: aSpaceship isWithinBounds: aSquare whenPlaying: aGame [

	|res|
	aSquare > self squares ifTrue: [ 
		aGame updateLaps: (aSquare //(self squares +1)) of: aSpaceship .
		res := aSquare % self squares .
		res = 0 ifTrue: [ ^self squares  ] ifFalse: [ ^res  ]
		  ].
	aSquare <= 0 ifTrue: [
		(aGame lapsOf: aSpaceship ) = 0
			ifTrue: [ ^ 1 ]
			ifFalse: [
				aGame updateLaps:(( aSquare //self squares) -1) of: aSpaceship .
				^ aSquare + self squares   ] ].
		
	
	^ aSquare
	
"
aGame updateLaps: squaresMoved // self squares.
	squaresMoved <= 0 ifTrue: [ aGame updateLaps: -1 ].
	aGame players "
]
