Class {
	#name : #MercenaryCard,
	#superclass : #PermanentCard,
	#instVars : [
		'ally',
		'mercenary'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
MercenaryCard >> from: aSpaceship withTarget: anotherSpaceship useIn: aGame [
	self validateIfCardCanBePlayedBy: aSpaceship in: aGame.
	self validateAllianceBetween: aSpaceship and: anotherSpaceship .
	aGame validateMercenaryAvailability: anotherSpaceship .
	mercenary:=anotherSpaceship.
	ally := aSpaceship.
	aGame addActiveCard: self.
]

{ #category : #testing }
MercenaryCard >> is: aSpaceship anAllyOf: anotherSpaceship [

^((aSpaceship = ally) and: anotherSpaceship = mercenary) or: ((aSpaceship = mercenary ) and: anotherSpaceship = ally)
]

{ #category : #accessing }
MercenaryCard >> mercenary [
^mercenary
]

{ #category : #playing }
MercenaryCard >> playOn: aSpaceship [

^0.
]

{ #category : #action }
MercenaryCard >> reduceShieldsOfAllyOf: aSpaceship in: aGame [

aSpaceship =ally ifTrue: [ aGame decreaseShieldByOneOf:  mercenary. ].
]

{ #category : #action }
MercenaryCard >> reinforce: aSpaceship in: aGame [


aSpaceship = ally ifTrue: [ ^aGame throwDice ].
^0.
]

{ #category : #validation }
MercenaryCard >> validateAllianceBetween: aSpaceship and: anotherSpaceship [
	aSpaceship = anotherSpaceship ifTrue: [ Error signal: 'A spaceship cannot be its own mercenary' ]
]
