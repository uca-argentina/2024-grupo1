Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Spaceship class >> launch [ 

^ (self new) launch
]

{ #category : #accessing }
Spaceship >> getPosition [

	^position 
]

{ #category : #initialize }
Spaceship >> launch [ 

position := 0.
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
