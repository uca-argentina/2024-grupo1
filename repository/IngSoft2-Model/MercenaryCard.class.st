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
	aGame validateMercenaryAvailability: anotherSpaceship .
	mercenary:=anotherSpaceship.
	ally := aSpaceship.
	aGame addMercenary: self.
]

{ #category : #testing }
MercenaryCard >> is: aSpaceship anAllyOf: anotherSpaceship [

^((aSpaceship = ally) and: anotherSpaceship = mercenary) or: ((aSpaceship = mercenary ) and: anotherSpaceship = ally)
]

{ #category : #accessing }
MercenaryCard >> mercenary [
^mercenary
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
