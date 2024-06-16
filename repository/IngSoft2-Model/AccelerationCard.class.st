Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> from: aSpaceship withTarget: anotherSpaceship useIn: aGame [
	aGame addActiveMovementCard: self.
]

{ #category : #playing }
AccelerationCard >> playOn: aSpaceship withDiceThrow: aDiceThrow [

^aDiceThrow  +1
]
