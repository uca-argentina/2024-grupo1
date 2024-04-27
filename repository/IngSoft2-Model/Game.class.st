Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isOver'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Game class >> begin [ 
^ (self new) begin
]

{ #category : #'as yet unclassified' }
Game >> begin [
isOver :=false.
]

{ #category : #accessing }
Game >> end [
	isOver:= true.
]

{ #category : #testing }
Game >> isOngoing [

^ isOver not.
]
