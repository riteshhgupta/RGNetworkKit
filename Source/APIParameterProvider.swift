//
//  APIParameterProtocol.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation

/// JSON is not a concrete type, rather just a typealias

public typealias JSON = [String: Any]

/// `APIRouterProvider` requires an object which conform to `APIParameterProtocol`
/// it provides the parameters to `APIRouterProvider`

public protocol APIParameterProtocol {

	var params: JSON { get }
}
