Class {
	#name : 'SaganParameterDefinitionProvider',
	#superclass : 'Object',
	#category : 'Persistent-API-Skeleton',
	#package : 'Persistent-API-Skeleton'
}

{ #category : 'private' }
SaganParameterDefinitionProvider class >> defaultMaxActiveSessionsCount [

	^ 5
]

{ #category : 'private' }
SaganParameterDefinitionProvider class >> defaultMaxConnectionAttemps [

	^ 3
]

{ #category : 'private' }
SaganParameterDefinitionProvider class >> defaultMaxIdleSessionsCount [

	^ 5
]

{ #category : 'private' }
SaganParameterDefinitionProvider class >> defaultMinIdleSessionsCount [

	^ 2
]

{ #category : 'private' }
SaganParameterDefinitionProvider class >> defaultTimeSlotBetweenConnectionRetries [

	^ Duration milliSeconds: 3000
]

{ #category : 'private' }
SaganParameterDefinitionProvider class >> saganBasicConfigurationParameters [

	^ OrderedCollection new
		  add: ( OptionalConfigurationParameter
				    named: 'Log Database Events'
				    describedBy: 'A boolean indicating whether should log database events or not'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: false
				    convertingWith: #asBoolean );
		  add: ( OptionalConfigurationParameter
				    named: 'Maximum Connection Attemps'
				    describedBy: 'Number of retries login database attempts'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: self defaultMaxConnectionAttemps
				    convertingWith: #asNumber );
		  add: ( OptionalConfigurationParameter
				    named: 'Time Slot Between Connection Retries In ms'
				    describedBy: 'Timeframe in milliseconds to wait before retrying a login to database'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: self defaultTimeSlotBetweenConnectionRetries
				    convertingWith: [ :parameter | Duration milliSeconds: parameter asNumber ] );
		  yourself
]

{ #category : 'private' }
SaganParameterDefinitionProvider class >> saganSessionPoolingConfigurationParameters [

	^ OrderedCollection new
		  add: ( OptionalConfigurationParameter
				    named: 'Min Idle Sessions Count'
				    describedBy: 'Minimum number of idle sessions to keep alive in the pool'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: self defaultMinIdleSessionsCount
				    convertingWith: #asNumber );
		  add: ( OptionalConfigurationParameter
				    named: 'Max Idle Sessions Count'
				    describedBy: 'Maximum number of idle sessions to keep alive in the pool'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: self defaultMaxIdleSessionsCount
				    convertingWith: #asNumber );
		  add: ( OptionalConfigurationParameter
				    named: 'Max Active Sessions Count'
				    describedBy: 'Maximum number of sessions alive'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: self defaultMaxActiveSessionsCount
				    convertingWith: #asNumber );
		  yourself
]

{ #category : 'private' }
SaganParameterDefinitionProvider class >> sectionsForSaganConfiguration [

  ^ #( 'Sagan' )
]
