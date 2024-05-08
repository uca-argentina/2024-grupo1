Class {
	#name : #NormalSquare,
	#superclass : #Object,
	#instVars : [
		'myPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
NormalSquare class >> isIn: position [
^ self new isIn: position.
]

{ #category : #testing }
NormalSquare >> isIn: position [
myPosition := position.
]

{ #category : #'instance creation' }
NormalSquare >> land [
^ myPosition.
]
