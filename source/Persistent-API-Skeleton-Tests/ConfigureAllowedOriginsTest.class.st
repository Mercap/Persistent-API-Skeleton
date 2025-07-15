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

  ( ConfigureAllowedOrigins allowing: #( 'http://allowed-origin-test/' ) exposing: #( 'Etag' ) )
    applyOn: self.

  self
    withTheOnlyOneIn: allowedOrigins
    do: [ :allowedOrigin | self assert: allowedOrigin equals: 'http://allowed-origin-test/' ];
    withTheOnlyOneIn: exposedHeaders do: [ :header | self assert: header equals: 'Etag' ]
]
