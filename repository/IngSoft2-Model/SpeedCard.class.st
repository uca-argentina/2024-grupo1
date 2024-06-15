Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
SpeedCard >> playOn: aSpaceship [

aSpaceship = target ifTrue:[^1].
^0
]

{ #category : #action }
SpeedCard >> useOn: aSpaceship [
target:= aSpaceship.
]
