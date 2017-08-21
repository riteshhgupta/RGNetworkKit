//
//  APIRequestProtocol.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 29/01/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import RGMapper

public protocol APIRequestProvider {

	var sessionManager: SessionManager { get }

	func parse(response: Data) throws -> Any
	func parse(error: Error, withCustomResponse data: Any) throws -> Error
}
