Class {
	#name : 'PersistentPetStoreApplication',
	#superclass : 'PersistentAPIApplication',
	#category : 'Persistent-API-Skeleton-Tests',
	#package : 'Persistent-API-Skeleton-Tests'
}

{ #category : 'accessing' }
PersistentPetStoreApplication class >> commandName [

	^ 'persistent-pet-store'
]

{ #category : 'accessing' }
PersistentPetStoreApplication class >> description [

	^ 'A RESTful API for Pet stores'
]

{ #category : 'class initialization' }
PersistentPetStoreApplication class >> initialize [

  <ignoreForCoverage>
  self initializeVersion
]

{ #category : 'private' }
PersistentPetStoreApplication class >> projectName [

  ^ #PersistentAPISkeleton
]

{ #category : 'accessing' }
PersistentPetStoreApplication class >> saganConfigurationParameters [

	^#()
]

{ #category : 'private' }
PersistentPetStoreApplication class >> sectionsForStargateConfiguration [

  ^ #( 'Pet Store' ) , super sectionsForStargateConfiguration
]

{ #category : 'private - accessing' }
PersistentPetStoreApplication >> controllersToInstall [

  ^ { PetsRESTfulController new . PetOrdersRESTfulController new }
]

{ #category : 'private - accessing' }
PersistentPetStoreApplication >> installation [

  ^ PetStoreInstallation installedBy: self
]

{ #category : 'private - accessing' }
PersistentPetStoreApplication >> serviceDefinitions [

  ^ #(  )
]

{ #category : 'private - accessing' }
PersistentPetStoreApplication >> stargateConfiguration [

  ^ self configuration petStore stargate
]
