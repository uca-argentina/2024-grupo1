"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  Increases dice result by one for a specific spaceship

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	target:		<Object>


    Implementation Points
"
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
	aGame addActiveCard: self.
]

{ #category : #testing }
SpeedCard >> is: aSpaceship anAllyOf: anotherSpaceship [

^false.
]

{ #category : #accessing }
SpeedCard >> mercenary [
^0
]

{ #category : #playing }
SpeedCard >> playOn: aSpaceship [
| cardModifier |
cardModifier:=0.
aSpaceship = target ifTrue:[cardModifier:= 1].
^cardModifier
]

{ #category : #action }
SpeedCard >> reduceShieldsOfAllyOf: aSpaceship in: aGame [
]

{ #category : #action }
SpeedCard >> reinforce: aSpaceship in: aGame [

^0.
]

{ #category : #validation }
SpeedCard >> validateAllianceBetween: aSpaceship and: anotherSpaceship [
]
