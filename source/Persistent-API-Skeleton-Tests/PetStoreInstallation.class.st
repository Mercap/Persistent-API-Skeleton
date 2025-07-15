Class {
	#name : 'PetStoreInstallation',
	#superclass : 'SystemInstallation',
	#instVars : [
		'application'
	],
	#category : 'Persistent-API-Skeleton-Tests',
	#package : 'Persistent-API-Skeleton-Tests'
}

{ #category : 'instance creation' }
PetStoreInstallation class >> installedBy: anApplication [

^self new initializeInstalledBy: anApplication
]

{ #category : 'installing' }
PetStoreInstallation >> beAwareOfShutDownOf: aCompositeSystem [ 
]

{ #category : 'installing' }
PetStoreInstallation >> initializeInstalledBy: anApplication [

application := anApplication
]

{ #category : 'installing' }
PetStoreInstallation >> modulesToInstall [

	^#()
]

{ #category : 'installing' }
PetStoreInstallation >> name [

	^'Pet Store' 
]
