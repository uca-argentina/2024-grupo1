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

{ #category : #tests }
SpaceshipTest >> test120SpaceshipsShieldsCannotBeLessThanZero [

	| aSpaceship |
	aSpaceship :=SpaceshipLog randomCardsfor: ( Spaceship launch: 'Death Star').
	6 timesRepeat: [ aSpaceship decreaseShieldsByOne ].
	self assert: aSpaceship shields  equals: 0
]
