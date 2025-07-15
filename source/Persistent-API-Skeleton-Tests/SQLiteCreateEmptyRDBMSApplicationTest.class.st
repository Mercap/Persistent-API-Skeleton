Class {
	#name : 'SQLiteCreateEmptyRDBMSApplicationTest',
	#superclass : 'CreateEmptyRDBMSApplicationTest',
	#category : 'Persistent-API-Skeleton-Tests',
	#package : 'Persistent-API-Skeleton-Tests'
}

{ #category : 'tests' }
SQLiteCreateEmptyRDBMSApplicationTest >> testConfigurationParameters [

	| parameters parameter |

	parameters := CreateEmptyRDBMSApplication saganConfigurationParametersForSQLite.

	self assert: parameters size equals: 7.

	parameter := parameters first.
	self
		assert: parameter name equals: 'Database File Name';
		assert: parameter summary equals: 'SQLite Database file name. Defaults to default.db';
		assert: parameter commandLineArgumentName equals: 'sagan.database-file-name';
		assert: parameter environmentVariableName equals: 'SAGAN__DATABASE_FILE_NAME'.
	
	parameter := parameters second.

	self
		assert: parameter name equals: 'Log Database Events';
		assert: parameter summary
		equals: 'A boolean indicating whether should log database events or not. Defaults to false';
		assert: parameter commandLineArgumentName equals: 'sagan.log-database-events';
		assert: parameter environmentVariableName equals: 'SAGAN__LOG_DATABASE_EVENTS'.
		
	parameter := parameters third.

	self
		assert: parameter name equals: 'Maximum Connection Attemps';
		assert: parameter summary equals: 'Number of retries login database attempts. Defaults to 3';
		assert: parameter commandLineArgumentName equals: 'sagan.maximum-connection-attemps';
		assert: parameter environmentVariableName equals: 'SAGAN__MAXIMUM_CONNECTION_ATTEMPS'.

	parameter := parameters fourth.

	self
		assert: parameter name equals: 'Time Slot Between Connection Retries In ms';
		assert: parameter summary
		equals:
			'Timeframe in milliseconds to wait before retrying a login to database. Defaults to 0:00:00:03';
		assert: parameter commandLineArgumentName
		equals: 'sagan.time-slot-between-connection-retries-in-ms';
		assert: parameter environmentVariableName
		equals: 'SAGAN__TIME_SLOT_BETWEEN_CONNECTION_RETRIES_IN_MS'.
	
	parameter := parameters fifth.

	self
		assert: parameter name equals: 'Min Idle Sessions Count';
		assert: parameter summary
		equals: 'Minimum number of idle sessions to keep alive in the pool. Defaults to 2';
		assert: parameter commandLineArgumentName equals: 'sagan.min-idle-sessions-count';
		assert: parameter environmentVariableName equals: 'SAGAN__MIN_IDLE_SESSIONS_COUNT'.

	parameter := parameters sixth.

	self
		assert: parameter name equals: 'Max Idle Sessions Count';
		assert: parameter summary
		equals: 'Maximum number of idle sessions to keep alive in the pool. Defaults to 5';
		assert: parameter commandLineArgumentName equals: 'sagan.max-idle-sessions-count';
		assert: parameter environmentVariableName equals: 'SAGAN__MAX_IDLE_SESSIONS_COUNT'.

	parameter := parameters last.

	self
		assert: parameter name equals: 'Max Active Sessions Count';
		assert: parameter summary equals: 'Maximum number of sessions alive. Defaults to 5';
		assert: parameter commandLineArgumentName equals: 'sagan.max-active-sessions-count';
		assert: parameter environmentVariableName equals: 'SAGAN__MAX_ACTIVE_SESSIONS_COUNT'.

]
