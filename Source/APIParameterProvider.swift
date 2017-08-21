//
//  APIParameterProtocol.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

public protocol APIParameterProtocol {

	var params: JSON { get }
}
