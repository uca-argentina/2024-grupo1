Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testBanana [ 

|aGame|

aGame:= Game new.
aGame end.

self deny: (aGame isOngoing  )
]

{ #category : #tests }
GameTest >> testIfTheGameIsOngoingReturnTrue [
"Let the games begin"

| aGame |
aGame:= Game begin.
^self assert: (aGame isOngoing) .
]
