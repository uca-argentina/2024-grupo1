Class {
	#name : #ZeroBasedArrayTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZeroBasedArrayTest >> test1 [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray with: 1.
	self assert: (zeroBasedArray at: 0) equals: 1
]

{ #category : #tests }
ZeroBasedArrayTest >> test10ZeroBasedArrayUnderstandsLast [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray withAll: #(1  2  3).

	self assert: (zeroBasedArray last) equals: 3
]

{ #category : #tests }
ZeroBasedArrayTest >> test11ZeroBasedArrayUnderstandsRemoveLast [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray withAll: #(1  2  3).
	zeroBasedArray removeLast .
	self assert: (zeroBasedArray last) equals: 2
]

{ #category : #tests }
ZeroBasedArrayTest >> test2 [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray with: 1 with: 2.
	self assert: (zeroBasedArray at: 1) equals: 2
]

{ #category : #tests }
ZeroBasedArrayTest >> test3 [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray with: 1 with: 2 with: 3.
	zeroBasedArray at: 0 put: 5.
	self assert: (zeroBasedArray at: 0) equals: 5
]

{ #category : #tests }
ZeroBasedArrayTest >> test4ZeroBasedArrayInitializedWithAnArray [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray withAll: #(1  2  3).

	self assert: (zeroBasedArray at: 0) equals: 1
]

{ #category : #tests }
ZeroBasedArrayTest >> test5ZeroBasedArrayUnderstandsDo [

	| zeroBasedArray reducer|
	zeroBasedArray := ZeroBasedArray withAll: #(1  2  3).
	reducer := 0.
	zeroBasedArray do: [ :value | reducer := reducer +value  ].
	self assert: reducer equals: 6
]

{ #category : #tests }
ZeroBasedArrayTest >> test6ZeroBasedArrayUnderstandsAddFirst [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray withAll: #(1  2  3).
	zeroBasedArray addFirst: 6.
	self assert: (zeroBasedArray at:0) equals: 6
]

{ #category : #tests }
ZeroBasedArrayTest >> test7ZeroBasedArrayUnderstandsAddLast [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray withAll: #(1  2  3).
	zeroBasedArray addLast: 6.
	self assert: (zeroBasedArray at:3) equals: 6
]

{ #category : #tests }
ZeroBasedArrayTest >> test8ZeroBasedArrayUnderstandsRemoveFirst [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray withAll: #(1  2  3).
	zeroBasedArray removeFirst.
	self assert: (zeroBasedArray at:0) equals: 2
]

{ #category : #tests }
ZeroBasedArrayTest >> test9ZeroBasedArrayUnderstandsFirst [

	| zeroBasedArray |
	zeroBasedArray := ZeroBasedArray withAll: #(1  2  3).

	self assert: (zeroBasedArray first) equals: 1
]
