Class {
	#name : #PermanentCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
PermanentCard >> validateIfCardCanBePlayedBy: aSpaceship in: aGame [

aSpaceship = aGame nextSpaceshipToPlay ifFalse: [ Error signal: 'Card cannot be played out of turn' ].
]
