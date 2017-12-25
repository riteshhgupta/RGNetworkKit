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

/// create an object which conforms to `APIRequestProvider`
/// use `request(router: handler:)` to make an api call
/// type of the handler will decide which request function will be called
/// all the requirements of `APIRequestProvider` have default implementations except `dataRequest`

public protocol APIRequestProvider: class {

	var sessionManager: SessionManager { get }

	var dataRequest: DataRequest? { get set }
	
	var dataResponse: DataResponse<Data>? { get set }
	
	/// implement this method to provide custom parsing logic for response, by default it uses `JSONSerialization.jsonObject(:)`
	func parse(response: Data) throws -> Any
}
