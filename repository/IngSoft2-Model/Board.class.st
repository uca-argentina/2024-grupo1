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
		'wormholeStartPoint',
		'wormholeEndPoint',
		'boardOfSquares'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> of: aNumberOfSquares wormholeBeginsAt: startingPoint andEndsAt: endPoint [

	aNumberOfSquares <= 0 ifTrue: [ Error signal: 'Board must have at least 1 square' ].
	((((startingPoint > aNumberOfSquares) or: (endPoint > aNumberOfSquares ))) or: ((startingPoint < 0) or: (endPoint < 0))) ifTrue: [ Error signal: 'Wormhole out of bounds' ].
	startingPoint = endPoint ifTrue: [ Error signal: 'Wormhole endpoints cannot be in the same square'].
	^ self new of: aNumberOfSquares wormholeBeginsAt: startingPoint andEndsAt: endPoint  
]

{ #category : #accessing }
Board >> finalSquareAfterLandingIn: aSquare [

	"aSquare = wormholeStartPoint ifTrue: [ ^ wormholeEndPoint  ].
	aSquare = wormholeEndPoint ifTrue: [ ^ wormholeStartPoint  ].
	
	^ aSquare 
	"
	^ (boardOfSquares at: aSquare) land. 
]

{ #category : #'instance creation' }
Board >> of: aNumberOfSquares wormholeBeginsAt: startingPoint andEndsAt: endPoint [

	| i |
	i := 1.
	numberOfSquares := aNumberOfSquares.
	wormholeStartPoint := startingPoint.
	wormholeEndPoint := endPoint.
	boardOfSquares := OrderedCollection new.
	[ i <= numberOfSquares ] whileTrue: [
		i = startingPoint ifTrue: [
			boardOfSquares add: (WormholeSquare of: endPoint) ].
		i = endPoint ifTrue: [
			boardOfSquares add: (WormholeSquare of: startingPoint) ].
		(i ~= startingPoint and: i ~= endPoint) ifTrue: [
			boardOfSquares add: (NormalSquare isIn: i) ]. 
		i := i + 1. 
		]
	
	
	
		
]

{ #category : #accessing }
Board >> squares [ 

"^numberOfSquares" 
^ boardOfSquares size.
]
