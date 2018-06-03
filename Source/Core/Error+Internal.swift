//
//  Error+Internal.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 03/06/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

extension Error {

	var dataResponse: DataResponse<Data> {
		return DataResponse(
			request: nil,
			response: nil,
			data: nil,
			result: .failure(self)
		)
	}
}
