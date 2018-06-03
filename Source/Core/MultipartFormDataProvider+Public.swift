//
//  MultipartFormDataProvider+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 03/06/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension String: MultipartFormDataProvider {

	public var data: Data? {
		return data(using: .utf8)
	}
}

extension UIImage: MultipartFormDataProvider {

	public var data: Data? {
		return UIImageJPEGRepresentation(self, 1.0)
	}

	public func appendTo(_ formData: MultipartFormData, for key: String) {
		guard let data = data else {
			return
		}
		formData.append(
			data,
			withName: key,
			fileName: key,
			mimeType: "image/jpg"
		)
	}
}
