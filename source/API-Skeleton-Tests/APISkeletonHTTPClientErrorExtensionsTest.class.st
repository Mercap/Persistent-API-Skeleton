Class {
	#name : 'APISkeletonHTTPClientErrorExtensionsTest',
	#superclass : 'TestCase',
	#category : 'API-Skeleton-Tests',
	#package : 'API-Skeleton-Tests'
}

{ #category : 'tests' }
APISkeletonHTTPClientErrorExtensionsTest >> testHTTPClientErrorAsJRPCResponse [

	self
		should: [ HTTPClientError badRequest signal: 'Bad Request' ]
		raise: HTTPClientError badRequest
		withExceptionDo: [ :error | 
			| response |

			response := error asJRPCResponse.
			self
				assert: response isError;
				assert: response error code equals: -32603;
				assert: response error message equals:  'Internal JSON-RPC error.';
				assert: (response error data at: 'errorClass') equals: 'HTTPClientError';
				assert: (response error data at: 'messageText') equals: 'Bad Request';
				assert: (response error data at: 'code') equals: '400'
			]
]

{ #category : 'tests' }
APISkeletonHTTPClientErrorExtensionsTest >> testUnprocessableEntityAsJRPCResponse [

	self
		should: [ HTTPClientError unprocessableEntity signal: 'Invalid parameter format' ]
		raise: HTTPClientError unprocessableEntity
		withExceptionDo: [ :error | 
			| response |

			response := error asJRPCResponse.
			self
				assert: response isError;
				assert: response error code equals: -32602;
				assert: response error message equals: 'Invalid parameter format'
			]
]
