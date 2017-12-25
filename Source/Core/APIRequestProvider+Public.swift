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
import enum Result.Result

public extension APIRequestProvider {

	public func cancel() {
		dataRequest?.cancel()
	}

	public var sessionManager: SessionManager {
		return SessionManager.`default`
	}

	public func parse(response: Data) throws -> Any {
		return try JSONSerialization.jsonObject(with: response, options: .allowFragments)
	}
}

public extension APIRequestProvider {
	
	public func request(router: APIRouterProvider, completion handler: @escaping (DataResponse<Data>) -> Void) {
		dataRequest = sessionManager
			.request(router)
			.validate(statusCode: (200..<300))
			.debugLog()
			.responseData { [weak self] response in
				guard let this = self else { return }
				this.dataResponse = response
				handler(response)
		}
	}
	
	public func request<T: Mappable, E>(router: APIRouterProvider, completion handler: @escaping (Result<T, APIError<E>>) -> Void) {
		request(router: router) { [weak self] response in
			guard let this = self, let data = response.data else {
				if let error = response.error { handler(Result.failure(error.apiError())) }
				return
			}
			do {
				let parsedData = try this.parse(response: data)
				if response.result.isSuccess {
					let mappedData: T = try parsedData^^
					handler(Result.success(mappedData))
				} else {
					let mappedError: E = try parsedData^^
					let apiError = APIError.mappedError(mappedError)
					handler(Result.failure(apiError))
				}
			} catch {
				handler(Result.failure(error.apiError()))
			}
		}
	}
}
