Class {
	#name : #LightyearDistance,
	#superclass : #Distance,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
LightyearDistance >> squaresToMove [
^(travelDistance *squareRatio)//3
]
