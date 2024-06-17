"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  A generic distance

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	squareRatio:		<Object>
	travelDistance:		<Object>


    Implementation Points
"
Class {
	#name : #Distance,
	#superclass : #Object,
	#instVars : [
		'squareRatio',
		'travelDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Distance class >> of: aDistance withRatio: aRatio [

^ self new initializeOf: aDistance withRatio: aRatio .
]

{ #category : #initialization }
Distance >> initializeOf: aDistance withRatio: aParsecRatio [

travelDistance := aDistance.
squareRatio := aParsecRatio.
]

{ #category : #action }
Distance >> squaresToMove [
	self subclassResponsibility 
]
