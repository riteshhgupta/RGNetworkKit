//
//  APIClientProvider.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 29/01/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import Result
import enum Result.Result

/// `APIClientProvider` wraps the structure of an api client
/// use `responseHandler(request: handler:)` to execute an api call
/// all the requirements of `APIClientProvider` have default implementations except `currentRequests`

public protocol APIClientProvider: class {

	// alamofire session manager
	var sessionManager: SessionManager { get }

	// cancel a request
	func cancel(request: APIRequestProvider)

	// execute a request and handle it's response
	func responseHandler(for request: APIRequestProvider, completion handler: @escaping (DataResponse<Data>) -> Void)

	// execute a multipart request and handle it's response
	func multipartResponseHandler(for request: APIRequestProvider, completion handler: @escaping (DataResponse<Data>) -> Void)

	// not to be used externally, only for internal implementation
	// protocols can't have private properties so ¯\_(ツ)_/¯
	var currentRequests: [(APIRequestProvider, Request)] { get set }
}
