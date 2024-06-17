Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RepeatCard >> from: aSpaceship withTarget: aTarget useIn: aGame [
	aGame repeatLastEffectFor: aTarget
]
