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
		return URL(string: "https://dog.ceo/api")!
	}
	var path: String {
		return "/breed/hound/images"
	}
}

struct User: Mappable {

	let name: String

	static func map(_ mapper: Mapper) throws -> User {
		let name: String = try mapper["status"]^^
		return User(name: name)
	}
}

struct ResponseError {}

extension ResponseError: Error {}

extension ResponseError: Mappable {

	static func map(_ mapper: Mapper) throws -> ResponseError {
		return ResponseError()
	}
}
