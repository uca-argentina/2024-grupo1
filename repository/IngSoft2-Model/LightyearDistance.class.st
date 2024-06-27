Class {
	#name : #LightyearDistance,
	#superclass : #Object,
	#instVars : [
		'travelDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LightyearDistance class >> of: aDistance [

	^ self new initializeOf: aDistance
]

{ #category : #action }
LightyearDistance >> inParsecs [
^travelDistance //3
]

{ #category : #initialization }
LightyearDistance >> initializeOf: aDistance [

travelDistance := aDistance.

]
