//
//  APIRouterProvider+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

public extension APIRouterProvider {

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

	var parameterProvider: APIParameterProtocol? {
		return nil
	}

	var authenticationParams: JSON? {
		return nil
	}

	var timeoutInterval: TimeInterval {
		return 200.0
	}

	var urlWithPath: URL {
		var url = baseUrl
		if !path.isEmpty {
			url = baseUrl.appendingPathComponent(path)
		}
		return url
	}

	var parameters: JSON? {
		return method.modelParams(parameterProvider) + authenticationParams
	}

	var allHeaders: JSON {
		return (defaultHeaders + headers)!
	}

	public func asURLRequest() throws -> URLRequest {
		var request = URLRequest(url: urlWithPath)
		request.httpMethod = method.rawValue
		request.timeoutInterval = timeoutInterval
		allHeaders.forEach { request.setValue($1 as? String, forHTTPHeaderField: $0) }
		request = method.appendHttpBody(for: request, with: parameterProvider)
		return try URLEncoding.default.encode(request, with: parameters)
	}
}
