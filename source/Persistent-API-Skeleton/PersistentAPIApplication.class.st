Class {
	#name : #PersistentAPIApplication,
	#superclass : #ConsulAwareStargateApplication,
	#instVars : [
		'rootSystem'
	],
	#category : #'Persistent-API-Skeleton'
}

{ #category : #accessing }
PersistentAPIApplication class >> configurationParameters [

	^ super configurationParameters , self saganConfigurationParameters
]

{ #category : #private }
PersistentAPIApplication class >> defaultMaxActiveSessionsCount [

	^ self subclassResponsibility
]

{ #category : #private }
PersistentAPIApplication class >> defaultMaxIdleSessionsCount [

	^ self subclassResponsibility
]

{ #category : #private }
PersistentAPIApplication class >> defaultMinIdleSessionsCount [

	^ self subclassResponsibility
]

{ #category : #testing }
PersistentAPIApplication class >> isAbstract [

	^ self = PersistentAPIApplication
]

{ #category : #accessing }
PersistentAPIApplication class >> saganConfigurationParameters [

	^ self subclassResponsibility
]

{ #category : #private }
PersistentAPIApplication class >> saganSessionPoolingConfigurationParameters [

	^ Array
		  with: ( OptionalConfigurationParameter
				    named: 'Min Idle Sessions Count'
				    describedBy: 'Minimum number of idle sessions to keep alive in the pool'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: self defaultMinIdleSessionsCount
				    convertingWith: #asNumber )
		  with: ( OptionalConfigurationParameter
				    named: 'Max Idle Sessions Count'
				    describedBy: 'Maximum number of idle sessions to keep alive in the pool'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: self defaultMaxIdleSessionsCount
				    convertingWith: #asNumber )
		  with: ( OptionalConfigurationParameter
				    named: 'Max Active Sessions Count'
				    describedBy: 'Maximum number of sessions alive'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: self defaultMaxActiveSessionsCount
				    convertingWith: #asNumber )
]

{ #category : #private }
PersistentAPIApplication class >> sectionsForSaganConfiguration [

	^ #( 'Sagan' )
]

{ #category : #private }
PersistentAPIApplication class >> serviceDiscoveryHealthCheckIntervalConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Healthcheck interval ms'
		  describedBy: 'Milliseconds to wait between service discovery health check invocations'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 10000
		  convertingWith: #asNumber
]

{ #category : #private }
PersistentAPIApplication class >> serviceDiscoveryTimeSlotBetweenRetriesConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Time Slot between retries in ms'
		  describedBy: 'Milliseconds to wait before retrying a call against Consul'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 100
		  convertingWith: #asNumber
]

{ #category : #private }
PersistentAPIApplication class >> serviceDiscoveryTimeoutConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Timeout ms'
		  describedBy:
		  'Milliseconds to wait before Consul will consider the service as dead when not responding'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 60000
		  convertingWith: #asNumber
]

{ #category : #accessing }
PersistentAPIApplication class >> stargateConfigurationParameters [

	^ super stargateConfigurationParameters , { 
		  self serviceDiscoveryHealthCheckIntervalConfigurationParameter.
		  self serviceDiscoveryTimeoutConfigurationParameter.
		  self serviceDiscoveryTimeSlotBetweenRetriesConfigurationParameter }
]

{ #category : #'private - activation/deactivation' }
PersistentAPIApplication >> basicStartWithin: context [

	self installAndStartRootSystem.
	self handleOptionsIn: context.
	super basicStartWithin: context
]

{ #category : #'private - activation/deactivation' }
PersistentAPIApplication >> basicStop [ 

	super basicStop.
	LaunchpadLogRecord emitInfo: 'Stopping system'.
	rootSystem ifNotNil: #shutDown
]

{ #category : #'private - activation/deactivation' }
PersistentAPIApplication >> handleOptionsIn: context [

	"I'm a template method. Subclasses can re-implement me to handle options."
]

{ #category : #'private - activation/deactivation' }
PersistentAPIApplication >> installAndStartRootSystem [

	LaunchpadLogRecord emitInfo: 'Installing system'.
	rootSystem := self installation install: self class version.
	LaunchpadLogRecord emitInfo: 'Starting up system'.
	rootSystem startUp
]

{ #category : #'private - accessing' }
PersistentAPIApplication >> installation [

	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
PersistentAPIApplication >> saganConfiguration [

	^ self configuration sagan
]

{ #category : #'private - building' }
PersistentAPIApplication >> serviceDiscoveryHealthCheckInterval [

	^ self stargateConfiguration serviceDiscoveryHealthcheckIntervalMs milliSeconds
]

{ #category : #'private - building' }
PersistentAPIApplication >> serviceDiscoveryHealthCheckTimeout [

	^ self stargateConfiguration serviceDiscoveryTimeoutMs milliSeconds
]

{ #category : #'private - building' }
PersistentAPIApplication >> serviceDiscoveryTimeSlotBetweenRetries [

	^ self stargateConfiguration serviceDiscoveryTimeSlotBetweenRetriesInMs milliSeconds
]
