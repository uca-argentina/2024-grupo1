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

	^ self new launch: aName
]

{ #category : #private }
Spaceship >> getName [
^ myName.
]

{ #category : #accessing }
Spaceship >> getPosition [

	^position 
]

{ #category : #initialize }
Spaceship >> launch: aName [ 

position := 0.
myName := aName.
]

{ #category : #action }
Spaceship >> move: squares [
position := position + squares.
]

{ #category : #action }
Spaceship >> playTurn: aDie in: aGame [


	self move: ( aDie throw).
	aGame finalPositionFor: self.
	
	
	
]

{ #category : #'as yet unclassified' }
Spaceship >> playTurnIn: aGame [ 
	| squaresToMove |
	squaresToMove := 0.
	aGame getDice do: [:aDie | squaresToMove := squaresToMove + (aDie throw)].
	self move: ( squaresToMove ).
	aGame finalPositionFor: self.
	
]
