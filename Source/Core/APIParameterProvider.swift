//
//  APIParameterProvider.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

/// `APIParameterProvider` provides the parameters to `APIRouterProvider`
/// `APIRouterProvider` requires an object which conforms to `APIParameterProvider`

public protocol APIParameterProvider {

	var parameter: [String: Any] { get }
	var multipartFormParameters: [String: MultipartFormDataProvider] { get }
}

public extension APIParameterProvider {

	var multipartFormParameters: [String: MultipartFormDataProvider] {
		return parameter.compactMap { $0 as? MultipartFormDataProvider }
	}
}
