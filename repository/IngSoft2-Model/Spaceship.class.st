Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position',
		'myName'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Spaceship class >> launch: aName [

	^ self new initializeLaunch: aName
]

{ #category : #accessing }
Spaceship >> getName [
^ myName.
]

{ #category : #accessing }
Spaceship >> getPosition [

	^position 
]

{ #category : #initialize }
Spaceship >> initializeLaunch: aName [ 

position := 0.
myName := aName.
]

{ #category : #action }
Spaceship >> move: squares [
position := position + squares.
]

{ #category : #action }
Spaceship >> playTurnIn: aGame [ 
	| squaresToMove |
	
	aGame canIPlay: self.
	
	squaresToMove := 0.
	aGame getDice do: [:aDie | squaresToMove := squaresToMove + (aDie throw)].
	self move: ( squaresToMove ).
	aGame finalPositionFor: self.
	aGame nextTurn.
	
]
