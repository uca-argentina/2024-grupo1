Class {
	#name : #RealDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
RealDieTest >> should: anErrorBlock raise: anError withMessage: errorMessage [ 

	

self 
	should: anErrorBlock 
	raise: anError 
	withExceptionDo: [ :error |
										self assert: error messageText  equals: errorMessage  ]

]

{ #category : #tests }
RealDieTest >> testDieCannotHaveLessThanThreeFaces [ 

self should: [Die of: 1] raise: Error  withMessage: 'Faces should be more than 2'
]

{ #category : #tests }
RealDieTest >> testDieThrowBetweenOneAndAmountOfFaces [

| aDie |

aDie := Die of: 5.
self assert:  ((aDie throw) between: 1 and: 5)
]
