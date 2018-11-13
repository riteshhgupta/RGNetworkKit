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

	var parameter: Any { get }
	var multipartFormParameters: [String: MultipartFormDataProvider] { get }
}

public extension APIParameterProvider {

	var multipartFormParameters: [String: MultipartFormDataProvider] {
		guard let parameter = parameter as? [String: Any] else { return [:] }
		return parameter.compactMap { $0 as? MultipartFormDataProvider }
	}
}
