//
//  APIRequestProtocol.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 29/01/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import RGMapper

/// create an object which conforms to `APIRequestProvider`
/// use `request(router: handler:)` to make an api call
/// type of the handler will decide which request function will be called
/// all the requirements of `APIRequestProvider` have default implementations

public protocol APIRequestProvider: class {

	var sessionManager: SessionManager { get }

	var dataRequest: DataRequest? { get set }

	/// implement this method to provide custom parsing logic for response, by default it uses `JSONSerialization.jsonObject(:)`

	func parse(response: Data) throws -> Any

	/// implement this method to provide custom parsing logic for error, by default it returns the `error` (first argument)

	func parse(error: Error, withCustomResponse data: Any) throws -> Error

	/// default implemenation of this method doesn't add any validation or parsing or mapping
	/// it's a vary raw method which can be used for total control over the response handling

	func request(router: APIRouterProvider, completion handler: @escaping (DataResponse<Data>) -> Void)

	/// default implementation of this method add basic validation, basic error handling and
	/// takes care of parsing the data, mapping has to be taken care though

	func request(router: APIRouterProvider, completion handler: @escaping (Result<Any>, DataResponse<Data>) -> Void)

	/// default implementation of this method add basic validation, error handling for parsing &
	/// also takes care of mapping the response via `RGMapper` using `Mappable` protocol

	func request<T: Mappable>(router: APIRouterProvider, completion handler: @escaping (Result<T>, DataResponse<Data>) -> Void)
}
