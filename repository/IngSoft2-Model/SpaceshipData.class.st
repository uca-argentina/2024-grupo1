"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  Data for a spaceship

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	laps:		<Object>
	position:		<Object>
	shields:		<Object>
	spaceship:		<Object>


    Implementation Points
"
Class {
	#name : #SpaceshipData,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'laps',
		'shields',
		'position',
		'state',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipData class >> for: aSpaceship [

	^self new initializeFor: aSpaceship 
]

{ #category : #'instance creation' }
SpaceshipData class >> for: aSpaceship withDeck: someCards [

	^self new initializeFor: aSpaceship withDeck: someCards
]

{ #category : #'instance creation' }
SpaceshipData class >> randomCardsfor: aSpaceship [

	^self new initializeRandomCardsFor: aSpaceship
]

{ #category : #comparing }
SpaceshipData >> = anotherSpaceship [

	^laps = anotherSpaceship laps and:  position = anotherSpaceship position 
]

{ #category : #comparing }
SpaceshipData >> >= anotherSpaceship [

	laps = anotherSpaceship laps
		ifFalse: [ ^ laps >= anotherSpaceship laps ]
		ifTrue: [ ^ position >= anotherSpaceship position ]
]

{ #category : #adding }
SpaceshipData >> addCard: aCard [

cards add: aCard .
]

{ #category : #accessing }
SpaceshipData >> cards [
^cards 
]

{ #category : #accessing }
SpaceshipData >> changeLapsTo: anAmountOfLaps [

laps := anAmountOfLaps 
]

{ #category : #accessing }
SpaceshipData >> changeShieldsTo: aShieldValue [

shields := aShieldValue 
]

{ #category : #accessing }
SpaceshipData >> changeStateTo: aState [ 

state := aState 
]

{ #category : #comparing }
SpaceshipData >> hash [ 

^laps 
]

{ #category : #initialization }
SpaceshipData >> initializeFor: aSpaceship [ 

	spaceship := aSpaceship .
	position := 0.
	laps := 0.
	state := NoPenaltyState new.
	shields := 3.
]

{ #category : #initialization }
SpaceshipData >> initializeFor: aSpaceship withDeck: someCards [

	spaceship := aSpaceship .
	position := 0.
	laps := 0.
	state := NoPenaltyState new.
	shields := 3.
	cards:=someCards.
]

{ #category : #initialization }
SpaceshipData >> initializeRandomCardsFor: aSpaceship [

	spaceship := aSpaceship .
	position := 0.
	laps := 0.
	state := NoPenaltyState new.
	shields := 3.
	cards:= OrderedCollection new.
	self setRandomCards.
]

{ #category : #accessing }
SpaceshipData >> laps [
^laps 
]

{ #category : #accessing }
SpaceshipData >> moveTo: aPosition [

	position := aPosition 
]

{ #category : #accessing }
SpaceshipData >> position [
^position 
]

{ #category : #removing }
SpaceshipData >> removeCardFromHand: aCard [

 cards remove: (aCard class)
]

{ #category : #initialization }
SpaceshipData >> setRandomCards [

	| cardTypes randomCard |
	cardTypes := OrderedCollection
		             with: AccelerationCard
		             with: SpeedCard
		             with: MercenaryCard
		             with: RedoCard
		             with: RepeatCard.
	2 timesRepeat: [
		randomCard := cardTypes atRandom.
		cards add: randomCard new ]
]

{ #category : #accessing }
SpaceshipData >> shields [
^shields 
]

{ #category : #accessing }
SpaceshipData >> spaceship [
^spaceship 
]

{ #category : #accessing }
SpaceshipData >> state [ 
^state 
]

{ #category : #validation }
SpaceshipData >> validateThatSpaceshipHasCard: aCard [
	
	(cards includes: aCard class) ifFalse: [
		Error signal:
			'A Spaceship cannot play a card that is not in its hand' ]
]
