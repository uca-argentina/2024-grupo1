Class {
	#name : #NormalSquare,
	#superclass : #Object,
	#instVars : [
		'myPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #evaluating }
NormalSquare class >> in: position [
^ self new in: position.
]

{ #category : #evaluating }
NormalSquare >> in: position [
myPosition := position.
]

{ #category : #'instance creation' }
NormalSquare >> land [
^ myPosition.
]
