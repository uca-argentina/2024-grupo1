Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isOver',
		'spaceships',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> begin: aSpaceship with: aBoard [

	^ self new begin: aSpaceship with: nil
]

{ #category : #initialization }
Game >> begin: spaceship with: aBoard [
spaceships := spaceship.  
isOver :=false.
board := aBoard.
]

{ #category : #adding }
Game >> end [
	isOver:= true.
]

{ #category : #testing }
Game >> isOngoing [

^ isOver not.
]

{ #category : #'as yet unclassified' }
Game >> players [
^ spaceships.
]

{ #category : #'as yet unclassified' }
Game >> winner [

	self isOngoing ifTrue: [ ^nil ].
	^ spaceships
]
