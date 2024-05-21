Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipTest >> test026SpaceshipCreatedWithAName [
	
	| aSpaceship |
	aSpaceship := Spaceship launch: 'Millenium Falcon'.
	self assert: aSpaceship getName equals: 'Millenium Falcon'	
]

{ #category : #tests }
SpaceshipTest >> test027SpaceshipCreatedWithAnotherName [

	| aSpaceship |
	aSpaceship := Spaceship launch: 'Death Star'.
	self assert: aSpaceship getName equals: 'Death Star'	
]
