//
//  ViewController.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 28/01/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import UIKit
import Alamofire
import RGMapper
import enum Result.Result

class ViewController: UIViewController {

	let apiClient = APIClient()

	override func viewDidLoad() {
		super.viewDidLoad()

// 	How to make a request?
		let req = APIRequest()

//	How to execute a request?
		apiClient.mappedResponseHandler(
			for: req,
			completion: handler
		)

//		How to cancel a request?
//		self.apiClient.cancel(request: req)
	}

/// simplest form of handler which gives you alamofire object `DataResponse<Data>` as response
/// which you can customise as per your needs
//
//	var handler: (DataResponse<Data>) -> Void {
//		return { response in
//			print(response)
//		}
//	}

/// this handler takes care of api & mapping error handling and provides a Result object which has
/// the mapped response from the server e.g. `User`

	var handler: (Result<User, APIError<ResponseError>>) -> Void {
		return { (result) in
			print(result)
		}
	}
}
