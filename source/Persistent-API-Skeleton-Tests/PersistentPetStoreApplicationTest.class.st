Class {
	#name : 'PersistentPetStoreApplicationTest',
	#superclass : 'LaunchpadTest',
	#instVars : [
		'port',
		'petRepository',
		'allowedOrigins',
		'exposedHeaders'
	],
	#category : 'Persistent-API-Skeleton-Tests',
	#package : 'Persistent-API-Skeleton-Tests'
}

{ #category : 'configuring' }
PersistentPetStoreApplicationTest >> allowCrossOriginSharingApplying: aBlock [

  aBlock value: self
]

{ #category : 'configuring' }
PersistentPetStoreApplicationTest >> allowOnlyFrom: aCollection [

  allowedOrigins := aCollection
]

{ #category : 'configuring' }
PersistentPetStoreApplicationTest >> expose: aCollection [

  exposedHeaders := aCollection
]

{ #category : 'running' }
PersistentPetStoreApplicationTest >> setUp [

	super setUp.
	port := self freeListeningTCPPort.
	StargateApplication logsDirectory ensureCreateDirectory.
	petRepository := InMemoryPetRepository new.
	self assert: petRepository findAll isEmpty.
	allowedOrigins := #().
	exposedHeaders := #().
]

{ #category : 'tests' }
PersistentPetStoreApplicationTest >> testAllowedOriginParameter [

  | logRecords |
  self
    start: PersistentPetStoreApplication
    withAll: { '--pet-store.stargate.public-url=http://localhost:<1p>' expandMacrosWith: port .
        '--pet-store.stargate.port=<1p>' expandMacrosWith: port .
        '--pet-store.stargate.operations-secret=<1s>' expandMacrosWith: 'secret' .
        '--pet-store.stargate.allowed-origins=http://localhost/,http://test:3000/' .
        '--pet-store.stargate.consul-agent-location=' }.

  runningApplication configuration parameters
    detect: [ :parameter | parameter name = 'Allowed Origins' ]
    ifFound: [ :parameter |
        self
          assert: parameter summary
          equals:
            'A comma-separated list of URLs used as allowed origins for CORS. Defaults to [ :api |  ]';
          assert: parameter commandLineArgumentName equals: 'pet-store.stargate.allowed-origins';
          assert: parameter environmentVariableName equals: 'PET_STORE__STARGATE__ALLOWED_ORIGINS'.
        self assert: allowedOrigins isEmpty.
        ( runningApplication configuration valueFor: parameter ) value: self.
        self
          assertCollection: allowedOrigins
          hasSameElements:
          { WebOrigin basedOn: 'http://localhost/' asUrl .
            WebOrigin basedOn: 'http://test:3000/' asUrl }
      ]
    ifNone: [ self fail: 'Allowed Origins parameter not found' ].
  logRecords := OrderedCollection new.
  logRecords
    add: '[INFO] persistent-pet-store';
    add: '[INFO] Obtaining configuration.';
    add: '[WARNING] "Log HTTP Requests" parameter not provided.';
    add: '[WARNING] "Concurrent Connections Threshold" parameter not provided.';
    add: '[WARNING] "Scheme" parameter not provided. Using default';
    add: '[WARNING] "Service Discovery Healthcheck interval ms" parameter not provided';
    add: '[WARNING] "Service Discovery Timeout ms" parameter not provided';
    add: '[WARNING] "Service Discovery Time Slot between retries in ms" parameter not provided';
    add: '[INFO] Public URL:';
    add: '[INFO] Port:';
    add: '[INFO] Operations Secret';
    add: '[INFO] Log HTTP Requests: false';
    add: '[INFO] Concurrent Connections Threshold: 32';
    add: '[INFO] Consul Agent Location';
    add: '[INFO] Scheme: http';
    add: '[INFO] Service Discovery Healthcheck interval ms: 10000';
    add: '[INFO] Service Discovery Timeout ms: 60000';
    add: '[INFO] Service Discovery Time Slot between retries in ms: 100';
    add: 'Allowed Origins: [ :api | self configureAllowOrigins: webOrigins to: api ]';
    add: '[INFO] Obtaining configuration... [DONE]';
    add: '[INFO] Installing system';
    add: '[INFO] Starting up system';
    add: '[INFO] API Version:';
    add: '[INFO] Creating API...';
    add: '[INFO] Creating API... [DONE]';
    add: '[INFO] Enabling CORS...';
    add: '[INFO] Enabling CORS... [DONE]';
    add: '[INFO] Installing API...';
    add: '[INFO] Installing API... [DONE]';
    add: '[INFO] Starting API...';
    add: '[INFO] Starting API... [DONE]'.
  self assertLogRecordsMatch: logRecords
]

{ #category : 'tests' }
PersistentPetStoreApplicationTest >> testMissingAllowedOriginParameter [

  | logRecords |
  self
    start: PersistentPetStoreApplication
    withAll: { '--pet-store.stargate.public-url=http://localhost:<1p>' expandMacrosWith: port .
        '--pet-store.stargate.port=<1p>' expandMacrosWith: port .
        '--pet-store.stargate.operations-secret=<1s>' expandMacrosWith: 'secret' .
        '--pet-store.stargate.consul-agent-location=' }.

  runningApplication configuration parameters
    detect: [ :parameter | parameter name = 'Allowed Origins' ]
    ifFound: [ :parameter |
        self
          assert: parameter summary
          equals:
            'A comma-separated list of URLs used as allowed origins for CORS. Defaults to [ :api |  ]';
          assert: parameter commandLineArgumentName equals: 'pet-store.stargate.allowed-origins';
          assert: parameter environmentVariableName equals: 'PET_STORE__STARGATE__ALLOWED_ORIGINS'.
        self assert: allowedOrigins isEmpty.
        self assert: exposedHeaders isEmpty.
        ( runningApplication configuration valueFor: parameter ) value: self.
        self assert: allowedOrigins isEmpty.
        self assert: exposedHeaders isEmpty.
        logRecords := OrderedCollection new.
        logRecords
          add: '[INFO] persistent-pet-store';
          add: '[INFO] Obtaining configuration.';
          add: '[WARNING] "Log HTTP Requests" parameter not provided.';
          add: '[WARNING] "Concurrent Connections Threshold" parameter not provided.';
          add: '[WARNING] "Scheme" parameter not provided. Using default';
          add: '[WARNING] "Service Discovery Healthcheck interval ms" parameter not provided';
          add: '[WARNING] "Service Discovery Timeout ms" parameter not provided';
          add:
            '[WARNING] "Service Discovery Time Slot between retries in ms" parameter not provided';
          add: '[WARNING] "Allowed Origins" parameter not provided. Using default.';
          add: '[INFO] Public URL:';
          add: '[INFO] Port:';
          add: '[INFO] Operations Secret';
          add: '[INFO] Log HTTP Requests: false';
          add: '[INFO] Concurrent Connections Threshold: 32';
          add: '[INFO] Consul Agent Location';
          add: '[INFO] Scheme: http';
          add: '[INFO] Service Discovery Healthcheck interval ms: 10000';
          add: '[INFO] Service Discovery Timeout ms: 60000';
          add: '[INFO] Service Discovery Time Slot between retries in ms: 100';
          add: '[INFO] Allowed Origins: [ :api |  ]';
          add: '[INFO] Obtaining configuration... [DONE]';
          add: '[INFO] Installing system';
          add: '[INFO] Starting up system';
          add: '[INFO] API Version: ';
          add: '[INFO] Creating API...';
          add: '[INFO] Creating API... [DONE]';
          add: '[INFO] Installing API...';
          add: '[INFO] Installing API... [DONE]';
          add: '[INFO] Starting API...';
          add: '[INFO] Starting API... [DONE]'.
        self assertLogRecordsMatch: logRecords
      ]
    ifNone: [ self fail: 'Allowed Origins parameter not found' ]
]
