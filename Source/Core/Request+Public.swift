//
//  Request+Public.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 23/05/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

public extension Request {

	func debugLog() -> Self {
		#if DEBUG
		debugPrint(self)
		#endif
		return self
	}
}
