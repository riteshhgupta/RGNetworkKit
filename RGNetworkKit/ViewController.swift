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

class ViewController: UIViewController {

	let apiClient = APIClient()

	override func viewDidLoad() {
		super.viewDidLoad()
		apiClient.request(
			router: APIRouter(),
			completion: handler
		)
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: { self.apiClient.cancel() })
	}

/// simplest form of handler which gives you alamofire object `DataResponse<Data>` as response
/// which you can customise as per your needs

	var handler: (DataResponse<Data>) -> Void {
		return { response in
			print(response)
		}
	}

/// this handler takes care of basic api error handling and provides a Result object which has
/// the unmapped (raw) response from the server (Any) which you can map later

//	var handler: (Result<Any>, DataResponse<Data>) -> Void {
//		return { (data, response) in
//		}
//	}

/// this handler takes care of api & mapping error handling and provides a Result object which has
/// the mapped response from the server e.g. `User`

//	var handler: (Result<User>, DataResponse<Data>) -> Void {
//		return { (user, response) in
//		}
//	}
}
