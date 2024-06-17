"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  If you land here, you go back 4 squares

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	myPosition:		<Object>


    Implementation Points
"
Class {
	#name : #BlackholeEffect,
	#superclass : #NullEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BlackholeEffect class >> isIn: aPosition [

	^self new initializeIsIn: aPosition 
]

{ #category : #action }
BlackholeEffect >> applyIn: aGame [
	aGame moveCurrentTo: (myPosition -4).
	^ -4.
]

{ #category : #action }
BlackholeEffect >> applyIn: aGame for: aSpaceship [
	aGame moveBackFour: aSpaceship.
	^ -4.
]
