Class {
	#name : #ParsecDistance,
	#superclass : #Distance,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
ParsecDistance >> squaresToMove [
^(travelDistance *squareRatio)//1 
]
