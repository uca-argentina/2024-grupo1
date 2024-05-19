Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'position',
		'myName'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Spaceship class >> launch: aName [

	^ self new initializeLaunch: aName
]

{ #category : #accessing }
Spaceship >> getName [
^ myName.
]

{ #category : #initialize }
Spaceship >> initializeLaunch: aName [ 

myName := aName.
]
