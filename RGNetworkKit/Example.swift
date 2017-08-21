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

class APIClient: APIRequestProvider {

	var dataRequest: DataRequest?
}

struct APIRouter: APIRouterProvider {

	var baseURL: URL {
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
