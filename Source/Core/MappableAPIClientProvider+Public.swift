//
//  MappableAPIClientProvider+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 23/05/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import RGMapper
import enum Result.Result

public extension MappableAPIClientProvider {

	// default implementation of `mappedResponseHandler`
	// `isSuccess` depends on the status code validation (200..300)
	func mappedResponseHandler<T: Mappable, E>(for request: APIRequestProvider, completion handler: @escaping (Result<T, APIError<E>>) -> Void) {
		responseHandler(for: request) { [weak self] (response) in
			guard let this = self else { return }
			if response.result.isSuccess {
				handler(this.mapData(response: response, for: request))
			} else {
				handler(this.mapError(response: response, for: request))
			}
		}
	}

	func mappedMultipartResponseHandler<T: Mappable, E>(for request: APIRequestProvider, completion handler: @escaping (Result<T, APIError<E>>) -> Void) {
		multipartResponseHandler(for: request) { [weak self] (response) in
			guard let this = self else { return }
			if response.result.isSuccess {
				handler(this.mapData(response: response, for: request))
			} else {
				handler(this.mapError(response: response, for: request))
			}
		}
	}

	// default parsing + mapping of json response
	func mapData<T: Mappable, E>(response: DataResponse<Data>, for request: APIRequestProvider) -> Result<T, APIError<E>> {
		do {
			let parsedData = try request.parse(response: response)
			let mapper = Mapper(parsedData)
			let mappedData: T = try mapper^^
			return Result.success(mappedData)
		} catch {
			return Result.failure(.error(error))
		}
	}

	// default parsing + mapping of error response
	func mapError<T: Mappable, E>(response: DataResponse<Data>, for request: APIRequestProvider) -> Result<T, APIError<E>> {
		guard response.shouldParseData else {
			if let error = response.error { return Result.failure(.error(error)) }
			let error = RGNetworkKitError.badResponse
			return Result.failure(.error(error))
		}
		do {
			let parsedData = try request.parse(response: response)
			let mapper = Mapper(parsedData)
			let mappedData: E = try mapper^^
			return Result.failure(.mappedError(mappedData))
		} catch {
			return Result.failure(.error(error))
		}
	}
}

fileprivate extension DataResponse {

	var shouldParseData: Bool {
		return isJSONResponse && hasData
	}
}
