//
//  APIClientProvider+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import RGMapper
import enum Result.Result

public extension APIClientProvider {

	public var sessionManager: SessionManager {
		return .default
	}

	public func cancel() {
		currentRequest?.cancel()
	}
}

public extension APIClientProvider {
	
	public func dataRequest(request: APIRequestProvider, completion handler: @escaping (DataResponse<Data>) -> Void) {
		currentRequest = sessionManager
			.request(request)
			.validate(statusCode: (200..<300))
			.debugLog()
			.responseData { response in
				handler(response)
		}
	}
	
	public func mappableRequest<T: Mappable, E>(request: APIRequestProvider, completion handler: @escaping (Result<T, APIError<E>>) -> Void) {
		dataRequest(request: request) { response in
			guard let data = response.data, !data.isEmpty else {
				if let error = response.error {
					handler(Result.failure(error.apiError()))
				}
				return
			}
			do {
				let parsedData = try request.parse(response: data)
				let mapper = Mapper(parsedData)
				if response.result.isSuccess {
					let mappedData: T = try mapper^^
					handler(Result.success(mappedData))
				} else {
					let mappedError: E = try mapper^^
					let apiError = APIError.mappedError(mappedError)
					handler(Result.failure(apiError))
				}
			} catch {
				handler(Result.failure(error.apiError()))
			}
		}
	}
}
