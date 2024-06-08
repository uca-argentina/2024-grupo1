"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  Might be useful

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
	#name : #ZeroBasedArray,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
ZeroBasedArray class >> newy [
^(self new) initialize: (OrderedCollection new)
]

{ #category : #'instance creation' }
ZeroBasedArray class >> with: anObject [

^(self new) initialize: (OrderedCollection with: anObject )
]

{ #category : #'instance creation' }
ZeroBasedArray class >> with: anObject with: aSecondObject [

^(self new) initialize: (OrderedCollection with: anObject with: aSecondObject )
]

{ #category : #'instance creation' }
ZeroBasedArray class >> with: anObject with: aSecondObject with: aThirdObject [

^(self new) initialize: (OrderedCollection with: anObject with: aSecondObject with: aThirdObject )
]

{ #category : #'instance creation' }
ZeroBasedArray class >> withAll: aCollection [

^(self new) initialize: (OrderedCollection withAll: aCollection )
]

{ #category : #adding }
ZeroBasedArray >> add: aValue [

	collection add: aValue 
]

{ #category : #adding }
ZeroBasedArray >> addFirst: aValue [

	collection addFirst:  aValue 
]

{ #category : #adding }
ZeroBasedArray >> addLast: aValue [

	collection addLast:  aValue 
]

{ #category : #enumerating }
ZeroBasedArray >> asOrderedCollection [ 

	^collection 
]

{ #category : #accessing }
ZeroBasedArray >> at: anIndex [

	| realIndex |
	realIndex := self calculateRealIndexFor: anIndex.
	^ collection at: realIndex
]

{ #category : #accessing }
ZeroBasedArray >> at: anIndex put: aValue [

	| realIndex |
	realIndex := self calculateRealIndexFor: anIndex.
	^ collection at: realIndex put: aValue 
	

]

{ #category : #private }
ZeroBasedArray >> calculateRealIndexFor: anIndex [

	self validateWithinBounds: anIndex .
	^ anIndex + 1.
]

{ #category : #enumerating }
ZeroBasedArray >> do: aBlock [

	collection do: aBlock 
]

{ #category : #accessing }
ZeroBasedArray >> first [ 

	^collection first
]

{ #category : #initialization }
ZeroBasedArray >> initialize: aCollection [

 collection := aCollection 
]

{ #category : #accessing }
ZeroBasedArray >> last [

	^collection last
]

{ #category : #adding }
ZeroBasedArray >> remove: aValue ifAbsent: absentBlock [

	collection remove: aValue  ifAbsent: absentBlock 
]

{ #category : #adding }
ZeroBasedArray >> removeAt: index [

	collection removeAt: (self calculateRealIndexFor: index )
]

{ #category : #adding }
ZeroBasedArray >> removeFirst [

	collection removeFirst 
]

{ #category : #adding }
ZeroBasedArray >> removeLast [

	collection removeLast 
]

{ #category : #enumerating }
ZeroBasedArray >> reverseDo:  aBlock [

	collection reverseDo: aBlock 
]

{ #category : #enumerating }
ZeroBasedArray >> reversed [ 

	^collection reversed
]

{ #category : #private }
ZeroBasedArray >> validateWithinBounds: anIndex [

	(anIndex < 0 or: anIndex >= collection size) ifTrue: [
		Error signal: 'Index out of bounds ' , anIndex asString ]
]
