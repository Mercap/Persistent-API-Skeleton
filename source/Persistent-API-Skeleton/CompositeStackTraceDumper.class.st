Class {
	#name : 'CompositeStackTraceDumper',
	#superclass : 'StackTraceDumper',
	#instVars : [
		'dumpers'
	],
	#category : 'Persistent-API-Skeleton',
	#package : 'Persistent-API-Skeleton'
}

{ #category : 'instance creation' }
CompositeStackTraceDumper class >> composingAll: dumpers [

	^ self new initializeComposingAll: dumpers
]

{ #category : 'initialization' }
CompositeStackTraceDumper >> dumpStackTraceFor: anError [

	dumpers do: [ :dumper | dumper dumpStackTraceFor: anError ]
]

{ #category : 'initialization' }
CompositeStackTraceDumper >> initializeComposingAll: aDumpersCollection [

	dumpers := aDumpersCollection
]
