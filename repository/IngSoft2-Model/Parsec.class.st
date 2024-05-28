"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  A parsec

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	squaresPerParsec:		<Object>


    Implementation Points
"
Class {
	#name : #Parsec,
	#superclass : #Object,
	#instVars : [
		'squaresPerParsec'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Parsec class >> of: squaresToParsecsRatio [

^self new initializeOf: squaresToParsecsRatio 
]

{ #category : #initialization }
Parsec >> initializeOf: squaresToParsecsRatio [ 

	squaresPerParsec := squaresToParsecsRatio 
]

{ #category : #accessing }
Parsec >> squaresPerParsec [ 

^squaresPerParsec
]
