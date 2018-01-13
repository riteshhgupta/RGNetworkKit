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
		apiClient.dataRequest(
			request: APIRequest(),
			completion: handler
		)
//		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: { self.apiClient.cancel() })
	}

/// simplest form of handler which gives you alamofire object `DataResponse<Data>` as response
/// which you can customise as per your needs

	var handler: (DataResponse<Data>) -> Void {
		return { response in
			print(response)
		}
	}

/// this handler takes care of api & mapping error handling and provides a Result object which has
/// the mapped response from the server e.g. `User`

//	var handler: (Result<User>, DataResponse<Data>) -> Void {
//		return { (user, response) in
//		}
//	}
}
