Class {
	#name : #MysteryCardEffect,
	#superclass : #NullEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
MysteryCardEffect >> applyIn: aGame for: aSpaceship [

aGame addRandomCardFor: aSpaceship .
aGame move: aSpaceship  to:  myPosition .
^0
]
