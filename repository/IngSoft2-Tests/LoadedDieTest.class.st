Class {
	#name : #LoadedDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDieTest >> should: anErrorBlock raise: anError withMessage: errorMessage [

self 
	should: anErrorBlock 
	raise: anError 
	withExceptionDo: [ :error |
										self assert: error messageText  equals: errorMessage  ]

	.
]

{ #category : #tests }
LoadedDieTest >> testDieCannotHaveLessThanThreeFaces [

self should: [ LoadedDie of: 2 ] raise: Error withMessage: 'Faces should be more than 2'
]

{ #category : #tests }
LoadedDieTest >> testDieCreatedWithThreeFaces [

|aDie|

aDie := LoadedDie  of: 3.

self assert:  aDie throw equals: 3.
]

{ #category : #tests }
LoadedDieTest >> testWhenDieIsThrownValueIsAmountOfFaces [

|aDie|

aDie := LoadedDie  of: 5.

self assert:  aDie throw equals: 5.
]
