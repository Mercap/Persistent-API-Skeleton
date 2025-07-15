Extension { #name : 'SaganParameterDefinitionProvider' }

{ #category : '*Persistent-API-Skeleton-SQLite' }
SaganParameterDefinitionProvider class >> saganConfigurationParametersForSQLite [

	^ OrderedCollection new
		  add: ( OptionalConfigurationParameter
				    named: 'Database File Name'
				    describedBy: 'SQLite Database file name'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: 'default.db' );
		  addAll: self saganBasicConfigurationParameters;
		  addAll: self saganSessionPoolingConfigurationParameters;
		  yourself
]
