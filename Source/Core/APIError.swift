//
//  APIError.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 25/12/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import RGMapper
import Result

// RGNetwork returns APIError which has two cases ––
// 1. `mappedError` which returns a custom error from server (conforming to `Mappable`)
// 2. `error` which returns errors like no internet or something generated via alamofire

public protocol MappableErrorProtocol: LocalizedError, Mappable {

	var localizedMessage: String { get }
}

extension MappableErrorProtocol {

	public var localizedDescription: String {
		return localizedMessage
	}
}

public enum APIError<E: MappableErrorProtocol> {

// custom mappable error
	case mappedError(E)

// generic error like no internet etc
	case error(Error)
}

// `APIError` conforms to `Error` so that it's throwable
extension APIError: Error {}

// `APIError` conforms to `LocalizedError` so that it can return associated `localizedDescription`
extension APIError: LocalizedError {

	public var localizedDescription: String {
		switch self {
		case .error(let error): return error.localizedDescription
		case .mappedError(let error): return error.localizedDescription
		}
	}
}

public extension APIError {

	// it returns the underlying error
	var errorValue: Error {
		switch self {
		case .error(let error): return error
		case .mappedError(let error): return error
		}
	}

	// it returns the underlying mapped error
	var mappedErrorValue: E? {
		guard case .mappedError(let error) = self else { return nil }
		return error
	}
}
