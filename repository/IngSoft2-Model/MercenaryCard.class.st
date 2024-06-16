Class {
	#name : #MercenaryCard,
	#superclass : #Object,
	#instVars : [
		'ally',
		'mercenary'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
MercenaryCard >> from: aSpaceship withTarget: anotherSpaceship useIn: aGame [
	mercenary:=anotherSpaceship.
	ally := aSpaceship.
	aGame addMercenary: self.
]

{ #category : #action }
MercenaryCard >> reduceShieldsOfAllyOf: aSpaceship in: aGame [

aSpaceship =ally ifTrue: [ aGame reduceShieldsByOneOf: mercenary. ].
]

{ #category : #action }
MercenaryCard >> reinforce: aSpaceship in: aGame [


aSpaceship = ally ifTrue: [ ^aGame throwDice ].
^0.
]
