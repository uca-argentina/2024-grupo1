"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State where a spaceship can play normally

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
	#name : #NoPenaltyState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NoPenaltyState >> playIn: aGame [

	aGame turn .
]
