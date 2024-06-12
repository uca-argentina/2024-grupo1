Class {
	#name : #BoardDistributionCreatorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardDistributionCreatorTest >> test079 [

	| aBoardDistributionCreator probabilites |
	aBoardDistributionCreator := BoardDistributionCreator new.
	probabilites := Dictionary newFromKeys: #(AtomicBombEffect ) andValues: #(100).
	self assert: ((aBoardDistributionCreator createOf: 1 with: probabilites) size) equals: 1
]
