//
//  APIRequestProvider+Internal.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

extension APIRequestProvider {

	func handle(success response: DataResponse<Data>, handler: @escaping (Result<Any>, DataResponse<Data>) -> Void) {
		guard let data = response.data else {
			return
		}
		do {
			let _data = try parse(response: data)
			handler((Result.success(_data)), response)
		} catch {
			handler((Result.failure(error)), response)
		}
	}

	func handle(failure response: DataResponse<Data>, handler: @escaping (Result<Any>, DataResponse<Data>) -> Void) {
		guard let data = response.data, let error = response.error else {
			return
		}
		do {
			let _data = try parse(response: data)
			let errorResponse = try self.parse(error: error, withCustomResponse: _data)
			handler((Result.failure(errorResponse)), response)
		} catch (let parserError) {
			handler((Result.failure(parserError)), response)
		}
	}
}
