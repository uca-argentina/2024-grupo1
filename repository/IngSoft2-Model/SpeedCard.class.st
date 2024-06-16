Class {
	#name : #SpeedCard,
	#superclass : #PermanentCard,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> from: aSpaceship withTarget: anotherSpaceship useIn: aGame [
	self validateIfCardCanBePlayedBy: aSpaceship in: aGame.
	target := anotherSpaceship .
	aGame addActiveMovementCard: self.
]

{ #category : #playing }
SpeedCard >> playOn: aSpaceship withDiceThrow: aDiceThrow [
| cardModifier |
cardModifier:=0.
aSpaceship = target ifTrue:[cardModifier:= 1].
^aDiceThrow +cardModifier
]
