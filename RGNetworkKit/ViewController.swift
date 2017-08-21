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
	}

	var handler: (Result<User>, DataResponse<Data>) -> Void {
		return { (user, response) in
		}
	}
}
