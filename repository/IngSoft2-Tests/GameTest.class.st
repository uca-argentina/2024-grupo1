Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testIfGameIsOverReturnFalse [ 

|aGame|

aGame:= Game begin.
aGame end.

self deny: (aGame isOngoing  )
]

{ #category : #tests }
GameTest >> testIfTheGameIsOngoingReturnTrue [
"Let the games begin"

| aGame |
aGame:= Game begin.
^self assert: (aGame isOngoing) .
]

{ #category : #tests }
GameTest >> testSpaceshipChangedPositionByOneWhenMoved [

	| aSpaceship |
	aSpaceship := Spaceship launch.
	aSpaceship move.
	self assert: aSpaceship getPosition equals: 1
]

{ #category : #tests }
GameTest >> testSpaceshipIsCreatedAtStartPoint0 [

	| aSpaceship |
	aSpaceship := Spaceship launch.
	self assert: aSpaceship getPosition equals: 0
]
