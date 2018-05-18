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

	var defaultHeaders: [String: String] {
		return [
			"Content-Type": "application/json",
			"Accept": "application/json" + (version == nil ? "" : "; version=\(version!)")
		]
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

	var urlWithPath: URL {
		var url = baseURL
		if !path.isEmpty {
			url = baseURL.appendingPathComponent(path)
		}
		return url
	}

	var allParameters: [String: Any]? {
		return method.modelParams(parameterProvider) + defaultParams
	}

	var allHeaders: [String: Any] {
		return (defaultHeaders + headers)!
	}

	public func asURLRequest() throws -> URLRequest {
		var request = URLRequest(url: urlWithPath)
		request.httpMethod = method.rawValue
		request.timeoutInterval = timeoutInterval
		allHeaders.forEach { request.setValue($1 as? String, forHTTPHeaderField: $0) }
		request = method.appendHttpBody(for: request, with: parameterProvider)
		return try URLEncoding.default.encode(request, with: allParameters)
	}
	
	public func parse(response: Data) throws -> Any {
		return try JSONSerialization.jsonObject(with: response, options: .allowFragments)
	}
}
