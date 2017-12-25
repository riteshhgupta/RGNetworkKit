//
//  Reactive.swift
//  RGNetworkKit
//
//  Created by Ritesh Gupta on 25/12/17.
//  Copyright © 2017 Ritesh. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Alamofire
import RGMapper
import Result
import enum Result.Result

public extension APIRequestProvider {
	
	public func dataRequest(router: APIRouterProvider) -> SignalProducer<DataResponse<Data>, NoError> {
		return SignalProducer { [weak self] sink, disposable in
			guard let this = self else { return }
			this.dataRequest(router: router, completion: {
				sink.send(value: $0)
				sink.sendCompleted()
			})
			disposable.observeEnded { this.cancel() }
			}.observe(on: UIScheduler())
	}
	
	public func mappableRequest<T: Mappable, E>(router: APIRouterProvider) -> SignalProducer<T, APIError<E>> {
		return SignalProducer { [weak self] sink, disposable in
			guard let this = self else { return }
			this.mappableRequest(router: router, completion: { (response: Result<T, APIError<E>>) in
				switch response {
				case .success(let value): sink.send(value: value)
				case .failure(let error): sink.send(error: error)
				}
			})
			disposable.observeEnded { this.cancel() }
			}.observe(on: UIScheduler())
	}
}
