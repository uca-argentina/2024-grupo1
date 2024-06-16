Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCard >> from: aSpaceship withTarget: aTarget useIn: aGame [
	aGame redoLastCardPlayedFor: aSpaceship withTarget: aTarget
]
