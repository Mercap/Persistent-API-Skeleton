Class {
	#name : 'SingleDatabaseRepositoryProviderModuleFactory',
	#superclass : 'Object',
	#instVars : [
		'databaseConfiguration'
	],
	#category : 'Persistent-API-Skeleton',
	#package : 'Persistent-API-Skeleton'
}

{ #category : 'instance creation' }
SingleDatabaseRepositoryProviderModuleFactory class >> configuredBy: theDatabaseConfiguration [

  ^ self new initializeConfiguredBy: theDatabaseConfiguration
]

{ #category : 'instance creation' }
SingleDatabaseRepositoryProviderModuleFactory class >> configuredBy: theDatabaseConfiguration withPoolingOptions: poolingOptionsConfigurationAction [

  | options |
  options := NeoJSONObject new.
  poolingOptionsConfigurationAction value: options.
  theDatabaseConfiguration keysAndValuesDo: [ :key :value | options at: key ifAbsentPut: value ].
  self deprecated: 'Use configuredBy:, passing all keys and values to theDatabaseConfiguration'.
  ^ self configuredBy: options
]

{ #category : 'testing' }
SingleDatabaseRepositoryProviderModuleFactory class >> isAbstract [

  ^ self = SingleDatabaseRepositoryProviderModuleFactory
]

{ #category : 'private' }
SingleDatabaseRepositoryProviderModuleFactory >> databaseLogin [

  self subclassResponsibility
]

{ #category : 'initialization' }
SingleDatabaseRepositoryProviderModuleFactory >> initializeConfiguredBy: theDatabaseConfiguration [

  databaseConfiguration := theDatabaseConfiguration
]

{ #category : 'instance creation' }
SingleDatabaseRepositoryProviderModuleFactory >> toInstallOn: aCompositeSystem [

  | login |
  login := self databaseLogin.
  ^ SingleDatabaseRepositoryProviderModule
      toInstallOn: aCompositeSystem
      usingSessionPoolWith: login
      configuredBy: [ :options |
        databaseConfiguration keysAndValuesDo: [ :key :value | options at: key put: value ] ]
]
