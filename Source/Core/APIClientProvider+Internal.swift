//
//  APIClientProvider+Internal.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 03/06/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import Result
import enum Result.Result

extension APIClientProvider {

	func requestWorker(
		for request: APIRequestProvider,
		dataRequest: DataRequest,
		completion handler: @escaping (DataResponse<Data>) -> Void)
	{
		dataRequest
			.validate(statusCode: (200..<300))
			.debugLog()
			.responseData(completionHandler: handler)
		currentRequests.append((request, dataRequest))
	}
}
