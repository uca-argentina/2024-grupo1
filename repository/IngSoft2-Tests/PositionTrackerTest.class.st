Class {
	#name : #PositionTrackerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTrackerTest >> test137NewPositionTrackerStartsAtSquareZero [

	| position |
	position := PositionTracker beginInABoardOf: 10.
	self assert: position square equals: 0
]

{ #category : #tests }
PositionTrackerTest >> test138PositionTrackerSquareEqualsThreeWhenMovedThreeSpaces [

	| position |
	position := PositionTracker beginInABoardOf: 10.
	position move: 3.
	self assert: position square equals: 3
]

{ #category : #tests }
PositionTrackerTest >> test139NewPositionTrackerStartsAtZeroLaps [

	| position |
	position := PositionTracker beginInABoardOf: 10.
	self assert: position laps equals: 0
]
