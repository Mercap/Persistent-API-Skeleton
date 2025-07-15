Class {
	#name : 'ConfigureAllowedOrigins',
	#superclass : 'Object',
	#instVars : [
		'allowedUrls',
		'exposedHeaders'
	],
	#category : 'Persistent-API-Skeleton',
	#package : 'Persistent-API-Skeleton'
}

{ #category : 'instance creation' }
ConfigureAllowedOrigins class >> allowing: anUrlCollection exposing: aHeaderCollection [

	^ self new initializeAllowing: anUrlCollection exposing: aHeaderCollection
]

{ #category : 'applying' }
ConfigureAllowedOrigins >> applyOn: anAPI [

	anAPI allowCrossOriginSharingApplying: [ :cors |
		cors
			allowOnlyFrom: allowedUrls;
			expose: exposedHeaders
		]
]

{ #category : 'initialization' }
ConfigureAllowedOrigins >> initializeAllowing: anUrlCollection [

	allowedUrls := anUrlCollection
]

{ #category : 'initialization' }
ConfigureAllowedOrigins >> initializeAllowing: anUrlCollection exposing: aHeaderCollection [

	allowedUrls := anUrlCollection.
	exposedHeaders := aHeaderCollection
]
