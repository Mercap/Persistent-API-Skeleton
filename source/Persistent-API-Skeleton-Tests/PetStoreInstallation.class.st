Class {
	#name : 'PetStoreInstallation',
	#superclass : 'SystemInstallation',
	#category : 'Persistent-API-Skeleton-Tests',
	#package : 'Persistent-API-Skeleton-Tests'
}

{ #category : 'instance creation' }
PetStoreInstallation class >> installedBy: anApplication [

  ^ self new
]

{ #category : 'installing' }
PetStoreInstallation >> beAwareOfShutDownOf: aCompositeSystem [

  
]

{ #category : 'accessing' }
PetStoreInstallation >> modulesToInstall [

	^#()
]

{ #category : 'accessing' }
PetStoreInstallation >> name [

  ^ 'Pet Store'
]
