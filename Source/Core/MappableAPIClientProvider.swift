//
//  MappableAPIClientProvider.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 23/05/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import RGMapper
import Alamofire
import enum Result.Result

// `MappableAPIClientProvider` adds `Parsing` & `Mapping` capability on top of `APIClientProvider`

public protocol MappableAPIClientProvider: APIClientProvider {

	// handle how to parse and map a valid response
	func mapData<T: Mappable, E>(response: DataResponse<Data>, for request: APIRequestProvider) -> Result<T, APIError<E>>

	// handle how to parse and map an invalid response
	func mapError<T: Mappable, E>(response: DataResponse<Data>, for request: APIRequestProvider) -> Result<T, APIError<E>>

	// execute a request and handle it's response
	func mappedResponseHandler<T: Mappable, E>(for request: APIRequestProvider, completion handler: @escaping (Result<T, APIError<E>>) -> Void)

	// execute a multipart request and handle it's response
	func mappedMultipartResponseHandler<T: Mappable, E>(for request: APIRequestProvider, completion handler: @escaping (Result<T, APIError<E>>) -> Void)
}
