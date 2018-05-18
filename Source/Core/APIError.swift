//
//  APIError.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 25/12/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import RGMapper

public enum APIError<E: Mappable & Error> {
	
	case mappedError(E)
	case error(Error)
}

extension APIError {

	var error: Error {
		switch self {
		case .error(let error): return error
		case .mappedError(let error): return error
		}
	}
}

extension APIError: Error {}

extension APIError: LocalizedError {

	public var localizedDescription: String {
		return error.localizedDescription
	}
}

public extension Error {
	
	func apiError<E: Mappable & Error>() -> APIError<E> {
		return .error(self)
	}
}
