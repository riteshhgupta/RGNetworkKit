//
//  Example.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 21/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire
import RGMapper

class APIClient: MappableAPIClientProvider {

	var currentRequests: [(APIRequestProvider, Request)] = []
}

struct APIRequest: APIRequestProvider {

	var baseURL: URL {
		return URL(string: "https://api.imgur.com/3")!
	}
	var path: String {
		return "/galleryy.json"
	}
}

struct User: Mappable {

	let name: String

	static func map(_ mapper: Mapper) throws -> User {
		return User(
			name: try mapper["status"]^^
		)
	}
}

struct ResponseError {

	let message: String
	let request: String
}

extension ResponseError: MappableErrorProtocol {

	var localizedMessage: String {
		return message
	}
}

extension ResponseError: Mappable {

	static func map(_ mapper: Mapper) throws -> ResponseError {
		return ResponseError(
			message: try mapper["data"]["error"]^^,
			request: try mapper["data"]["request"]^^
		)
	}
}
