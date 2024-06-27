Class {
	#name : #ParsecDistance,
	#superclass : #Object,
	#instVars : [
		'travelDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ParsecDistance class >> of: aDistance [

	^ self new initializeOf: aDistance
]

{ #category : #action }
ParsecDistance >> inParsecs [
^travelDistance //1 
]

{ #category : #initialization }
ParsecDistance >> initializeOf: aDistance [

travelDistance := aDistance.

]
