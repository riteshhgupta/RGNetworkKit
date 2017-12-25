//
//  APIParameterProvider.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation

/// `APIRouterProvider` requires an object which conform to `APIParameterProvider`
/// it provides the parameters to `APIRouterProvider`

public protocol APIParameterProvider {

	var parameter: [String: Any] { get }
}
