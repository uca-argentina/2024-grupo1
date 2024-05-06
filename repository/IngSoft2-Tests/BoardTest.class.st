Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> test010BoardCreatedWithNSquares [

| aBoard |

aBoard := Board of: 2.
self assert: aBoard squares equals: 2.
]

{ #category : #tests }
BoardTest >> testBoardCreatedWithOneSquare [

	| aBoard |

	aBoard := Board of: 1.
	self assert: aBoard squares equals: 1
]
