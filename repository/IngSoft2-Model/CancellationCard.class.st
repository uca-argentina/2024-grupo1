Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard >> from: aSpaceship withTarget: aCard useIn: aGame [ 
	aGame removeCard: aCard.
]
