Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isOver'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> begin [ 
^ (self new) begin
]

{ #category : #initialization }
Game >> begin [
isOver :=false.
]

{ #category : #adding }
Game >> end [
	isOver:= true.
]

{ #category : #testing }
Game >> isOngoing [

^ isOver not.
]
