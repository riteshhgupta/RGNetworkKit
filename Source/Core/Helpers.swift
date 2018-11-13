//
//  Helpers.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 16/08/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import Alamofire

func +(first: [String: Any]?, second: [String: Any]?) -> [String: Any]? {
	if let first = first, let second = second {
		var dict = first
		for (key, value) in second {
			dict[key] = value
		}
		return dict
	} else if let first = first {
		return first
	} else if let second = second {
		return second
	}
	return nil
}

extension Dictionary where Key: Hashable {

	func compactMap<T>(_ transform: (Value) -> T?) -> [Key: T] {
		var newDict: [Key: T] = [:]
		forEach {
			if let value = transform($0.value) {
				newDict[$0.key] = value
			}
		}
		return newDict
	}
}
