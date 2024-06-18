Class {
	#name : #AccelerationCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> from: aSpaceship withTarget: anotherSpaceship useIn: aGame [
	self validateIfCardCanBePlayedBy: aSpaceship in: aGame.
	aGame addActiveCard: self.
]

{ #category : #testing }
AccelerationCard >> isMovementCard [ 
	^true 
]

{ #category : #playing }
AccelerationCard >> playOn: aSpaceship withDiceThrow: aDiceThrow [

^aDiceThrow  +1
]
