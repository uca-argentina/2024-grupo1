Class {
	#name : #PositionTracker,
	#superclass : #Object,
	#instVars : [
		'square'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionTracker class >> begin [
	^ self new initializeBegin.
]

{ #category : #initialization }
PositionTracker >> initializeBegin [
	square := 0.
]

{ #category : #accessing }
PositionTracker >> laps [
	^0.
]

{ #category : #accessing }
PositionTracker >> move: anAmountOfSquares [ 
	square := square + anAmountOfSquares.
]

{ #category : #shapes }
PositionTracker >> square [
	^square
]
