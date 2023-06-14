Class {
	#name : #BaselineOfDocxTemplater,
	#superclass : #BaselineOf,
	#category : #BaselineOfDocxTemplater
}

{ #category : #baseline }
BaselineOfDocxTemplater >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			self
				declareMustacheOn: spec.

			spec
				package: 'DocxTemplater' with: [ spec requires: #('Mustache') ].
 ]
]

{ #category : #'external projects' }
BaselineOfDocxTemplater >> declareMustacheOn: spec [

	spec baseline: 'Mustache' with: [
		spec repository:
			'github://noha/mustache:v1.0/repository'
		]
]
