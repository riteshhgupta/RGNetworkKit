//
//  APIRequestProvider+Internal.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 27/05/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation

extension APIRequestProvider {

	var defaultHeaders: [String: String] {
		return [
			"Content-Type": "application/json",
			"Accept": "application/json" + (version == nil ? "" : "; version=\(version!)")
		]
	}

	var allParameters: [String: Any]? {
		return method.modelParams(parameterProvider) + defaultParams
	}

	var allHeaders: [String: Any] {
		return (defaultHeaders + headers)!
	}

	var urlWithPath: URL {
		var url = baseURL
		if !path.isEmpty {
			url = baseURL.appendingPathComponent(path)
		}
		return url
	}
}
