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

struct APIClient: APIRequestProvider {

	let sessionManager = SessionManager()
}

struct APIRouter: APIRouterProvider {

	var baseUrl: URL {
		return URL(string: "https://dog.ceo/api")!
	}
	var path: String {
		return "/breed/hound/images"
	}
}

struct User: Mappable {

	let name: String = "Ritesh"

	static func map(_ value: Any?) throws -> User {
		return User()
	}
}
