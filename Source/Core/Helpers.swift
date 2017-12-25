//
//  Helpers.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 16/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

public func +(first: [String: Any]?, second: [String: Any]?) -> [String: Any]? {
	if let first = first, let second = second {
		var dict = first
		for (key, value) in second {
			dict[key] = value
		}
		return dict
	} else if let first = first {
		return first
	} else if let second = second {
		return second
	}
	return nil
}

public extension HTTPMethod {

	func appendHttpBody(for request: URLRequest, with model: APIParameterProvider?) -> URLRequest {
		var mutableRequest = request
		let params = model?.parameter ?? [:]
		switch self {
		case .post, .patch, .put:
			do {
				mutableRequest.httpBody = try JSONSerialization.data(
					withJSONObject: params,
					options: JSONSerialization.WritingOptions()
				)
			} catch {
				print(error.localizedDescription)
			}
		default:
			break
		}
		return mutableRequest
	}

	func modelParams(_ model: APIParameterProvider?) -> [String: Any]? {
		switch self {
		case .post, .patch, .put:
			return nil
		default:
			return model?.parameter
		}
	}
}

public extension Request {

	func debugLog() -> Self {
		#if DEBUG
			debugPrint(self)
		#endif
		return self
	}
}
