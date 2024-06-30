"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  Can only be played during the spaceship's turn. The effect continues to apply until removed

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #PermanentCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
PermanentCard >> from: aSpaceship withTarget: anotherSpaceship useIn: aGame [
	self subclassResponsibility 
]

{ #category : #validation }
PermanentCard >> validateIfCardCanBePlayedBy: aSpaceship in: aGame [

	aSpaceship = aGame nextSpaceshipToPlay ifFalse: [
		Error signal: 'Card cannot be played out of turn' ]
]
