//
//  APIClientProvider+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import Result
import enum Alamofire.Result

// default implementations of `APIClientProvider`

public extension APIClientProvider {

	// `.default` is a shared instance of `SessionManager`, one can pass a new instance as well
	public var sessionManager: SessionManager {
		return .default
	}

	// `urlWithPath` is checked to match two requests
	func cancel(request: APIRequestProvider) {
		guard let index = currentRequests.index(where: { $0.0.urlWithPath == request.urlWithPath }) else { return }
		currentRequests[index].1.cancel()
	}

	// `responseHandler` when executed returns `Data` as a response from server
	// it applies a validation on status code i.e. anything between 200..300 is a valid response
	func responseHandler(for request: APIRequestProvider, completion handler: @escaping (DataResponse<Data>) -> Void) {
		let dataRequest = sessionManager.request(request)
		requestWorker(
			for: request,
			dataRequest: dataRequest,
			completion: handler
		)
	}

	// `multipartResponseHandler` when executed returns `Data` as a response from server
	// it applies a validation on status code i.e. anything between 200..300 is a valid response
	func multipartResponseHandler(for request: APIRequestProvider, completion handler: @escaping (DataResponse<Data>) -> Void) {
		sessionManager.upload(
			with: request,
			execute: { dataRequest in
				self.requestWorker(
					for: request,
					dataRequest: dataRequest,
					completion: handler
				)},
			completion: handler
		)
	}
}
