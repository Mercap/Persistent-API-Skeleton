Class {
	#name : 'PersistentAPIApplication',
	#superclass : 'ConsulAwareStargateApplication',
	#instVars : [
		'rootSystem'
	],
	#category : 'Persistent-API-Skeleton',
	#package : 'Persistent-API-Skeleton'
}

{ #category : 'private' }
PersistentAPIApplication class >> allowedOriginsConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Allowed Origins'
		  describedBy:
		  'A comma-separated list of URLs used as allowed origins for CORS'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: [ :api |  ]
		  convertingWith: [ :string | 
			  | webOrigins |
			  webOrigins := self parseWebOriginsFrom: string.
			  [ :api | self configureAllowOrigins: webOrigins to: api ] ]
]

{ #category : 'accessing' }
PersistentAPIApplication class >> configurationParameters [

	^ super configurationParameters , self saganConfigurationParameters
]

{ #category : 'private' }
PersistentAPIApplication class >> configureAllowOrigins: allowedOrigins to: api [

	^ LogRecord
		  emitInfo: 'Enabling CORS'
		  during: [ 
		  (ConfigureAllowedOrigins allowing: allowedOrigins exposing: self exposedHeaders) applyOn: api ]
]

{ #category : 'private - accessing' }
PersistentAPIApplication class >> exposedHeaders [

	^ OrderedCollection with: 'Etag'
]

{ #category : 'testing' }
PersistentAPIApplication class >> isAbstract [

	^ self = PersistentAPIApplication
]

{ #category : 'private' }
PersistentAPIApplication class >> parseWebOriginsFrom: string [

	^ [ (string splitOn: $,) collect: #asWebOrigin as: Array ]
		  on: InstanceCreationFailed
		  do: [ :error | 
			  | parameter |
			  parameter := self allowedOriginsConfigurationParameter.
			  LogRecord emitError:
				  ('"<1s>" parameter value is invalid. <2s>'
					   expandMacrosWith: parameter name
					   with: error messageText).
			  RequiredConfigurationNotFound signal:
				  ('"<1s>" parameter value is invalid.' expandMacrosWith:
					   parameter name) ]
]

{ #category : 'accessing' }
PersistentAPIApplication class >> saganConfigurationParameters [

	^ self subclassResponsibility
]

{ #category : 'private' }
PersistentAPIApplication class >> sectionsForSaganConfiguration [

	^ #( 'Sagan' )
]

{ #category : 'private' }
PersistentAPIApplication class >> serviceDiscoveryHealthCheckIntervalConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Healthcheck interval ms'
		  describedBy: 'Milliseconds to wait between service discovery health check invocations'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 10000
		  convertingWith: #asNumber
]

{ #category : 'private' }
PersistentAPIApplication class >> serviceDiscoveryTimeSlotBetweenRetriesConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Time Slot between retries in ms'
		  describedBy: 'Milliseconds to wait before retrying a call against Consul'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 100
		  convertingWith: #asNumber
]

{ #category : 'private' }
PersistentAPIApplication class >> serviceDiscoveryTimeoutConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Timeout ms'
		  describedBy:
		  'Milliseconds to wait before Consul will consider the service as dead when not responding'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 60000
		  convertingWith: #asNumber
]

{ #category : 'accessing' }
PersistentAPIApplication class >> stargateConfigurationParameters [

	^ super stargateConfigurationParameters , { 
		  self serviceDiscoveryHealthCheckIntervalConfigurationParameter.
		  self serviceDiscoveryTimeoutConfigurationParameter.
		  self serviceDiscoveryTimeSlotBetweenRetriesConfigurationParameter.
		  self allowedOriginsConfigurationParameter }
]

{ #category : 'private - activation/deactivation' }
PersistentAPIApplication >> basicStartWithin: context [

	self installAndStartRootSystem.
	self handleOptionsIn: context.
	super basicStartWithin: context
]

{ #category : 'private - activation/deactivation' }
PersistentAPIApplication >> basicStop [ 

	super basicStop.
	LogRecord emitInfo: 'Stopping system'.
	rootSystem ifNotNil: #shutDown
]

{ #category : 'private - activation/deactivation' }
PersistentAPIApplication >> configureAllowedOriginsTo: api [

	self stargateConfiguration allowedOrigins value: api.
	
]

{ #category : 'private - activation/deactivation' }
PersistentAPIApplication >> createAPI [

	| api |
	api := super createAPI.
	self configureAllowedOriginsTo: api.
	^ api
]

{ #category : 'private - activation/deactivation' }
PersistentAPIApplication >> handleOptionsIn: context [

	"I'm a template method. Subclasses can re-implement me to handle options."
]

{ #category : 'private - activation/deactivation' }
PersistentAPIApplication >> installAndStartRootSystem [

	LogRecord emitInfo: 'Installing system'.
	rootSystem := self installation install: self class version.
	LogRecord emitInfo: 'Starting up system'.
	rootSystem startUp
]

{ #category : 'private - accessing' }
PersistentAPIApplication >> installation [

	^ self subclassResponsibility
]

{ #category : 'private - accessing' }
PersistentAPIApplication >> saganConfiguration [

	^ self configuration sagan
]

{ #category : 'private - building' }
PersistentAPIApplication >> serviceDiscoveryHealthCheckInterval [

	^ self stargateConfiguration serviceDiscoveryHealthcheckIntervalMs milliSeconds
]

{ #category : 'private - building' }
PersistentAPIApplication >> serviceDiscoveryHealthCheckTimeout [

	^ self stargateConfiguration serviceDiscoveryTimeoutMs milliSeconds
]

{ #category : 'private - building' }
PersistentAPIApplication >> serviceDiscoveryTimeSlotBetweenRetries [

	^ self stargateConfiguration serviceDiscoveryTimeSlotBetweenRetriesInMs milliSeconds
]

{ #category : 'private - building' }
PersistentAPIApplication >> stackTraceDumpFileReference [

	^ self class logsDirectory / ( '<1s>-<2s>' expandMacrosWith: self class commandName
		    with: ( ( ZTimestampFormat fromString: '2001-02-03_16-05-06.07' ) format: ZTimestamp now ) )
]

{ #category : 'private - building' }
PersistentAPIApplication >> stackTraceDumper [

	^ CompositeStackTraceDumper composingAll: {
			  ( StackTraceTextDumper on: [ :dumpAction |
				    ( self stackTraceDumpFileReference withExtension: 'log' ) writeStreamDo: dumpAction ] ).
			  ( StackTraceBinarySerializer on: [ :dumpAction |
				    ( self stackTraceDumpFileReference withExtension: 'fuel' ) binaryWriteStreamDo: dumpAction ] ) }
]
