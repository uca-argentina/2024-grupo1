Class {
	#name : #PositionTracker,
	#superclass : #Object,
	#instVars : [
		'square',
		'laps',
		'boardLength'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionTracker class >> beginInABoardOf: aLengthOfSquares [

	^ self new initializeBeginInABoardOf: aLengthOfSquares
]

{ #category : #analyze }
PositionTracker >> adjustBounds [

	square >= boardLength ifTrue: [ square := (square % boardLength ) ].
	square < 0 ifTrue: [ square := boardLength - square ].
	
]

{ #category : #action }
PositionTracker >> calculateLapsFor: aSpaceship in: totalPosition [
	"	
	totalPosition >= board length ifTrue: [
		(self dataFor: aSpaceship )updateLapsBy: totalPosition // board length ].
	totalPosition < 0 ifTrue: [
		(self dataFor: aSpaceship ) updateLapsBy: totalPosition // board length - 1 ]
	"
]

{ #category : #initialization }
PositionTracker >> initializeBeginInABoardOf: aLengthOfSquares [
	square := 0.
	laps := 0.
	boardLength := aLengthOfSquares.
]

{ #category : #accessing }
PositionTracker >> laps [
	^laps.
]

{ #category : #accessing }
PositionTracker >> move: anAmountOfSquares [ 
	square := square + anAmountOfSquares.
	self adjustBounds.
]

{ #category : #shapes }
PositionTracker >> square [
	^square
]
