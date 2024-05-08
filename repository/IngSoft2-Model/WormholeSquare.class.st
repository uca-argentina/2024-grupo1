Class {
	#name : #WormholeSquare,
	#superclass : #Object,
	#instVars : [
		'otherSide'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormholeSquare class >> of: otherSquare [
^ self new of: otherSquare.
]

{ #category : #'instance creation' }
WormholeSquare >> land [
^ otherSide.
]

{ #category : #'instance creation' }
WormholeSquare >> of: otherSquare [
otherSide := otherSquare.
]
