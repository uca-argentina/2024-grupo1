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
Spaceship >> move [
position := position +1.
]

{ #category : #action }
Spaceship >> playTurn: aDie [ 
	|i squaresToMove|
	
	squaresToMove := aDie throw.
	i:=1.
	[i <= squaresToMove] whileTrue: [  
		self move.
		i := i+1.
	].

	
	
	
]
