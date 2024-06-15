"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  Parsecs

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
	parsecs:		<Object>


    Implementation Points
"
Class {
	#name : #HyperJumpEffect,
	#superclass : #NullEffect,
	#instVars : [
		'parsecRatio',
		'toMove',
		'distancesMeasurementUnit'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
HyperJumpEffect class >> isIn: aSquare moves: someDistances SquaresPerParsec: parsecRatio dataTypes: types [ 
	^self new initializeIsIn: aSquare moves: someDistances SquaresPerParsec: parsecRatio  dataTypes: types 
]

{ #category : #testing }
HyperJumpEffect class >> isIn: aSquare movesParsecs: someParsecs SquaresPerParsec: squaresToParsecsRatio [

	^ self new
		  initializeIsIn: aSquare
		  movesParsecs: someParsecs
		  squaresPerParsec: squaresToParsecsRatio
]

{ #category : #action }
HyperJumpEffect >> applyIn: aGame [

	| currentDistance squaresToMove finalPosition measurementUnit |
	currentDistance := toMove removeFirst.
	toMove addLast: currentDistance.
	measurementUnit := distancesMeasurementUnit removeFirst.
	distancesMeasurementUnit addLast: measurementUnit.

	measurementUnit = 'Lightyear'
		ifTrue: [ squaresToMove := currentDistance * parsecRatio // 3 ]
		ifFalse: [ squaresToMove := currentDistance * parsecRatio // 1 ].

	finalPosition := myPosition + squaresToMove.
	aGame moveCurrentTo: finalPosition.
	^ squaresToMove
]

{ #category : #initialization }
HyperJumpEffect >> initializeIsIn: aSquare moves: someDistances SquaresPerParsec: aRatio dataTypes: types [ 
	myPosition := aSquare .
	toMove := someDistances.
	parsecRatio := aRatio .
	distancesMeasurementUnit := types 
]

{ #category : #initialization }
HyperJumpEffect >> initializeIsIn: aSquare movesParsecs: someParsecs squaresPerParsec: aRatio [

	myPosition := aSquare.
	toMove  := someParsecs.
	parsecRatio := aRatio  .
	distancesMeasurementUnit := OrderedCollection new.
	toMove size timesRepeat: [ distancesMeasurementUnit add: 'Parsec' ]
]
