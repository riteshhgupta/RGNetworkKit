//
//  APIRouterProtocol.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 29/01/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

/// create an object which conforms to `APIRouterProvider`
/// inject the created instance into `request(router: handler:)` method of `APIRequestProvider`

public protocol APIRouterProvider: URLRequestConvertible {

	/// it's that component of a url which is common to all the api calls e.g. "https://dog.ceo/api"
	/// it's the only required property to make a complete router object, 
	/// rest all have some default implementations

	var baseURL: URL { get }

	/// it's that component of a url which is specific to a route e.g. "/breed/hound/images"
	/// ideally it shouldn't include the parameters
	var path: String { get }

	/// one can provide very specific header info as per the business logic
	/// this protocol takes care of providing the default headers like "Content-Type": "application/json" etc
	var headers: [String: String] { get }

	/// one can provide the version of the api

	var version: String? { get }

	/// one can provide the timeout interval specific to app
	var timeoutInterval: TimeInterval { get }

	/// every rest api needs to be either GET, POST, PUT, PATH or DELETE
	/// by default it's GET
	var method: HTTPMethod { get }

	/// one can provide the params for an api call like search query
	/// instead of returning the dict, you need to simple return an object which conform to `APIParameterProtocol`
	var parameterProvider: APIParameterProtocol? { get }

	/// one can provide the authenticated params which are specific to an app
	var authenticationParams: JSON? { get }
}
