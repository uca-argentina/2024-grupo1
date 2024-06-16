Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> from: aSpaceship withTarget: anotherSpaceship useIn: aGame [
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
