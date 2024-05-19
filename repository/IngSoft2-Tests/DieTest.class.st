Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: anErrorBlock raise: anError withMessage: errorMessage [ 

	

self 
	should: anErrorBlock 
	raise: anError 
	withExceptionDo: [ :error |
										self assert: error messageText  equals: errorMessage  ]

]

{ #category : #tests }
DieTest >> testDieCannotHaveLessThanThreeFaces [ 

self should: [Die of: 1] raise: Error  withMessage: 'Faces should be more than 2'
]

{ #category : #tests }
DieTest >> testDieThrowBetweenOneAndAmountOfFaces [

| aDie |

aDie := Die of: 5.
self assert:  ((aDie throw) between: 1 and: 5)
]
