//
//  APIRequestProvider+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import RGMapper

public extension APIRequestProvider {

	func parse(response: Data) throws -> Any {
		return try JSONSerialization.jsonObject(with: response, options: .allowFragments)
	}

	func parse(error: Error, withCustomResponse data: Any) throws -> Error {
		return error
	}

	func request(router: APIRouterProvider, completion handler: @escaping (DataResponse<Data>) -> Void) {
		sessionManager
			.request(router)
			.debugLog()
			.responseData(completionHandler: handler)
	}

	func request(router: APIRouterProvider, completion handler: @escaping (Result<Any>, DataResponse<Data>) -> Void) {
		sessionManager
			.request(router)
			.validate(statusCode: (200..<300))
			.debugLog()
			.responseData(completionHandler: {(response: DataResponse<Data>) in
				if response.result.isSuccess {
					self.handle(success: response, handler: handler)
				} else {
					self.handle(failure: response, handler: handler)
				}
			})
	}

	func request<T: Mappable>(router: APIRouterProvider, completion handler: @escaping (Result<T>, DataResponse<Data>) -> Void) {
		request(router: router) { (response: (Result<Any>, DataResponse<Data>)) in
			let (result, _response) = response
			switch result {
			case .success(let data):
				do {
					let _data: T = try data^^
					handler((Result.success(_data)), _response)
				} catch {
					handler((Result.failure(error)), _response)
				}
			case .failure(let error):
				handler((Result.failure(error)), _response)
			}
		}
	}
}
