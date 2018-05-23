//
//  DataResponse+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 23/05/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

public extension DataResponse {

	var contentType: String? {
		return response?
			.allHeaderFields["Content-Type"]
			as? String
	}

	var isJSONResponse: Bool {
		return contentType == "application/json"
	}

	var hasData: Bool {
		return data?.isEmpty ?? false
	}
}
