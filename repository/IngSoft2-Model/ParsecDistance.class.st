Class {
	#name : #ParsecDistance,
	#superclass : #Object,
	#instVars : [
		'squareRatio',
		'travelDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
ParsecDistance class >> of: aDistance withRatio: aRatio [

^ self new initializeOf: aDistance withRatio: aRatio .
]

{ #category : #initialization }
ParsecDistance >> initializeOf: aDistance withRatio: aParsecRatio [

travelDistance := aDistance.
squareRatio := aParsecRatio.
]

{ #category : #action }
ParsecDistance >> squaresToMove [
^(travelDistance *squareRatio)//1 
]
