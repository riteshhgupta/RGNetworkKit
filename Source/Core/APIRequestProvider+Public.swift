//
//  APIRequestProvider+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

public extension APIRequestProvider {

	var version: String? {
		return nil
	}

	var path: String {
		return ""
	}

	var method: HTTPMethod {
		return .get
	}

	var headers: [String: String] {
		return [:]
	}

	var parameterProvider: APIParameterProvider? {
		return nil
	}

	var defaultParams: [String: Any]? {
		return nil
	}

	var timeoutInterval: TimeInterval {
		return 200.0
	}

	var isMultipart: Bool {
		return false
	}

	public func asURLRequest() throws -> URLRequest {
		var request = URLRequest(url: urlWithPath)
		request.httpMethod = method.rawValue
		request.timeoutInterval = timeoutInterval
		allHeaders.forEach { request.setValue($1 as? String, forHTTPHeaderField: $0) }
		if !isMultipart { request = method.appendHttpBody(for: request, with: parameterProvider) }
		return try URLEncoding.default.encode(request, with: allParameters)
	}

	public func parse(response: DataResponse<Data>) throws -> Any {
		guard let data = response.data else { throw RGNetworkKitError.noData }
		return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
	}
}
