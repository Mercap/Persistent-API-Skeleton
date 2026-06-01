Class {
	#name : 'CreateEmptyRDBMSApplicationTest',
	#superclass : 'LaunchpadTest',
	#category : 'Persistent-API-Skeleton-Tests',
	#package : 'Persistent-API-Skeleton-Tests'
}

{ #category : 'testing' }
CreateEmptyRDBMSApplicationTest class >> isAbstract [

  ^ self = CreateEmptyRDBMSApplicationTest
]

{ #category : 'tests' }
CreateEmptyRDBMSApplicationTest >> testCommandName [

  self assert: CreateEmptyRDBMSApplication commandName equals: 'create-empty-rdbms'
]

{ #category : 'tests' }
CreateEmptyRDBMSApplicationTest >> testDescription [

	self
		assert: CreateEmptyRDBMSApplication description
		equals: 'Creates the database structure'
]
