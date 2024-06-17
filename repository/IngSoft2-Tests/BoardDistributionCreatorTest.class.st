Class {
	#name : #BoardDistributionCreatorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardDistributionCreatorTest >> test079BoardDistributionCreatorMakesABoardOfIndicatedLength [

	| aBoardDistributionCreator probabilites |
	aBoardDistributionCreator := BoardDistributionCreator new.
	probabilites := Dictionary
		                newFromKeys: #( AtomicBombEffect )
		                andValues: #( 100 ).
	self
		assert: (aBoardDistributionCreator
				 createOf: 1
				 with: probabilites
				 withParsecs: 1
				 maximumHyperJumpValues: 1) size
		equals: 1
]

{ #category : #tests }
BoardDistributionCreatorTest >> test080WhenProbabilityIs100ThenEffectIsCreated [

	| aBoardDistributionCreator probabilites |
	aBoardDistributionCreator := BoardDistributionCreator new.
	probabilites := Dictionary
		                newFromKeys: #( 'MysteryCard' )
		                andValues: #( 100 ).
	self
		assert: ((aBoardDistributionCreator
				  createOf: 1
				  with: probabilites
				  withParsecs: 1
				  maximumHyperJumpValues: 1) at: 0) effect class
		equals: MysteryCardEffect 
]
