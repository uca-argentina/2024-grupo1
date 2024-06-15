Class {
	#name : #LightyearDistance,
	#superclass : #Object,
	#instVars : [
		'squareRatio',
		'travelDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
LightyearDistance class >> of: aDistance withRatio: aRatio [

^ self new initializeOf: aDistance withRatio: aRatio .
]

{ #category : #initialization }
LightyearDistance >> initializeOf: aDistance withRatio: aParsecRatio [

travelDistance := aDistance.
squareRatio := aParsecRatio/3.
]

{ #category : #action }
LightyearDistance >> squaresToMove [
^(travelDistance *squareRatio)//1 
]
