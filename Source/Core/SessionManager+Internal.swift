//
//  SessionManager+Internal.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 03/06/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

extension SessionManager {

	func upload(
		with request: APIRequestProvider,
		execute dataRequestHandler: @escaping (DataRequest) -> Void,
		completion responseHandler: @escaping (DataResponse<Data>) -> Void)
	{
		upload(
			multipartFormData: request.multipartFormData,
			with: request,
			encodingCompletion: { result in
				switch result {
				case .failure(let error):
					responseHandler(error.dataResponse)
				case .success(let dataRequest, _, _):
					dataRequestHandler(dataRequest)
				}
		})
	}
}
