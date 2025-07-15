Class {
	#name : 'ConfigureAllowedOriginsTest',
	#superclass : 'TestCase',
	#instVars : [
		'allowedOrigins',
		'exposedHeaders'
	],
	#category : 'Persistent-API-Skeleton-Tests',
	#package : 'Persistent-API-Skeleton-Tests'
}

{ #category : 'Mocking' }
ConfigureAllowedOriginsTest >> allowCrossOriginSharingApplying: aOneArgBlock [

	aOneArgBlock value: self
]

{ #category : 'Mocking' }
ConfigureAllowedOriginsTest >> allowOnlyFrom: aCollection [

	allowedOrigins := aCollection
]

{ #category : 'Mocking' }
ConfigureAllowedOriginsTest >> expose: aCollection [

	exposedHeaders := aCollection
]

{ #category : 'tests' }
ConfigureAllowedOriginsTest >> testApplyOnNoOriginsAllowed [

	( ConfigureAllowedOrigins allowing: #(  ) exposing: #(  ) ) applyOn: self.

	self
		assert: allowedOrigins isEmpty;
		assert: exposedHeaders isEmpty
]

{ #category : 'tests' }
ConfigureAllowedOriginsTest >> testApplyOnOneOriginAllowed [

	( ConfigureAllowedOrigins
		  allowing: ( Array with: 'http://allowed-origin-test/' )
		  exposing: ( Array with: 'Etag' ) ) applyOn: self.

	self
		assert: allowedOrigins size equals: 1;
		assert: allowedOrigins first equals: 'http://allowed-origin-test/';
		assert: exposedHeaders size equals: 1;
		assert: exposedHeaders first equals: 'Etag'
]
