Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isOver',
		'spaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> begin: aSpaceship [
^ (self new) begin: aSpaceship
]

{ #category : #initialization }
Game >> begin: spaceship [
spaceships := spaceship.  
isOver :=false.
]

{ #category : #adding }
Game >> end [
	isOver:= true.
]

{ #category : #testing }
Game >> isOngoing [

^ isOver not.
]

{ #category : #accessing }
Game >> players [
^ spaceships.
]

{ #category : #accessing }
Game >> winner [
	^ spaceships
]
