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
		'boardOfSquares'
	],
	#category : #'IngSoft2-Model'
}

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
Board >> finalSquareAfterLandingIn: aSquare whenPlaying: aGame [
	
	
	^ (boardOfSquares at: (self validateWithinBounds: aSquare whenPlaying: aGame )) land.
]

{ #category : #'instance creation' }
Board >> initializeOf: aNumberOfSquares wormholeBeginsAt: startingPoint andEndsAt: endPoint [

	numberOfSquares := aNumberOfSquares.
	boardOfSquares := OrderedCollection new.
	1 to: numberOfSquares do: [:square |  boardOfSquares add: (Square with: (NullEffect isIn: square) )].
	boardOfSquares at: startingPoint put: (Square with: (WormholeEffect goesTo: endPoint)).
	boardOfSquares at: endPoint put: (Square with: (WormholeEffect goesTo: startingPoint)).
	
	
	
		
]

{ #category : #accessing }
Board >> squares [ 


^ boardOfSquares size.
]

{ #category : #analyze }
Board >> validateWithinBounds: aSquare whenPlaying: aGame [

	aSquare > self squares ifTrue: [
		aGame addLaps: (aSquare // self squares ).
		^ aSquare % self squares ].

	^ aSquare
]
