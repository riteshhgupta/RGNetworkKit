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

public extension APIClientProvider {
	
	public func dataRequest(request: APIRequestProvider) -> SignalProducer<DataResponse<Data>, NoError> {
		return SignalProducer { [weak self] sink, disposable in
			guard let this = self else { return }
			this.dataRequest(request: request, completion: {
				sink.send(value: $0)
				sink.sendCompleted()
			})
			disposable.observeEnded { self?.currentRequest?.cancel() }
			}
			.observe(on: UIScheduler())
	}
	
	public func mappableRequest<T: Mappable, E>(request: APIRequestProvider) -> SignalProducer<T, APIError<E>> {
		return SignalProducer { [weak self] sink, disposable in
			guard let this = self else { return }
			this.mappableRequest(request: request, completion: { (response: Result<T, APIError<E>>) in
				switch response {
				case .success(let value):
					sink.send(value: value)
				case .failure(let error):
					sink.send(error: error)
				}
				sink.sendCompleted()
			})
			disposable.observeEnded { self?.currentRequest?.cancel() }
			}
			.observe(on: UIScheduler())
	}
}
