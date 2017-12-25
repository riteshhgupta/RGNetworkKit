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

extension APIError: Error {}

public extension Error {
	
	func apiError<E: Mappable & Error>() -> APIError<E> {
		return APIError<E>.error(self)
	}
}
