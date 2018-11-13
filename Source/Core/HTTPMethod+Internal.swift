//
//  HTTPMethod+Internal.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 29/05/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

extension HTTPMethod {

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
			return model?.parameter as? [String: Any]
		}
	}
}
