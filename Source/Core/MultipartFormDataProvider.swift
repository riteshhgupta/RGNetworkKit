//
//  MultipartFormDataProvider.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 03/06/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

public protocol MultipartFormDataProvider {

	var data: Data? { get }
	func appendTo(_ formData: MultipartFormData, for key: String)
}

public extension MultipartFormDataProvider {

	public func appendTo(_ formData: MultipartFormData, for key: String) {
		guard let data = data else {
			return
		}
		formData.append(
			data,
			withName: key
		)
	}
}
