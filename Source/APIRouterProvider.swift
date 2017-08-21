//
//  APIRouterProtocol.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 29/01/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

public protocol APIRouterProvider: URLRequestConvertible {

	var baseUrl: URL { get }

	var path: String { get }
	var headers: [String: String] { get }
	var version: String? { get }
	var timeoutInterval: TimeInterval { get }
	var method: HTTPMethod { get }
	var parameterProvider: APIParameterProtocol? { get }
	var authenticationParams: JSON? { get }
}
