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

// `ReactiveAPIClientProvider` is reactive version of `MappableAPIClientProvider`
// it uses the same underlying logic of `MappableAPIClientProvider`
// instead of closures, it returns a signal producer
public protocol ReactiveAPIClientProvider: MappableAPIClientProvider {

	// corresponding reactive layer of closure based `responseHandler`
	func responseHandler(for request: APIRequestProvider) -> SignalProducer<DataResponse<Data>, NoError>

	// corresponding reactive layer of closure based `mappedResponseHandler`
	func mappedResponseHandler<T: Mappable, E>(for request: APIRequestProvider) -> SignalProducer<T, APIError<E>>

	// corresponding reactive layer of closure based `multipartResponseHandler`
	func multipartResponseHandler(for request: APIRequestProvider) -> SignalProducer<DataResponse<Data>, NoError>

	// corresponding reactive layer of closure based `mappedMultipartResponseHandler`
	func mappedMultipartResponseHandler<T: Mappable, E>(for request: APIRequestProvider) -> SignalProducer<T, APIError<E>>
}

public extension ReactiveAPIClientProvider {

	// default implementation of `responseHandler`
	// it simply converts values from closure to a stream of values
	// it returns the value on UI thread
	// automatically cancels the request once the stream gets disposed
	public func responseHandler(for request: APIRequestProvider) -> SignalProducer<DataResponse<Data>, NoError> {
		return SignalProducer { [weak self] sink, disposable in
			guard let this = self else { return }
			this.responseHandler(for: request, completion: {
				sink.send(value: $0)
				sink.sendCompleted()
			})
			disposable
				.observeEnded { self?.cancel(request: request) }
			}
			.observe(on: UIScheduler())
	}

	public func multipartResponseHandler(for request: APIRequestProvider) -> SignalProducer<DataResponse<Data>, NoError> {
		return SignalProducer { [weak self] sink, disposable in
			guard let this = self else { return }
			this.multipartResponseHandler(for: request, completion: {
				sink.send(value: $0)
				sink.sendCompleted()
			})
			disposable
				.observeEnded { self?.cancel(request: request) }
			}
			.observe(on: UIScheduler())
	}

	// default implementation of `mappedResponseHandler`
	// it simply converts values from closure to a stream of values
	// it returns the value on UI thread
	// automatically cancels the request once the stream gets disposed
	public func mappedResponseHandler<T: Mappable, E>(for request: APIRequestProvider) -> SignalProducer<T, APIError<E>> {
		return SignalProducer { [weak self] sink, disposable in
			guard let this = self else { return }
			this.mappedResponseHandler(for: request, completion: { (response: Result<T, APIError<E>>) in
				switch response {
				case .success(let value):
					sink.send(value: value)
					sink.sendCompleted()
				case .failure(let error):
					sink.send(error: error)
				}
			})
			disposable
				.observeEnded { self?.cancel(request: request) }
			}
			.observe(on: UIScheduler())
	}

	public func mappedMultipartResponseHandler<T: Mappable, E>(for request: APIRequestProvider) -> SignalProducer<T, APIError<E>> {
		return SignalProducer { [weak self] sink, disposable in
			guard let this = self else { return }
			this.mappedMultipartResponseHandler(for: request, completion: { (response: Result<T, APIError<E>>) in
				switch response {
				case .success(let value):
					sink.send(value: value)
					sink.sendCompleted()
				case .failure(let error):
					sink.send(error: error)
				}
			})
			disposable
				.observeEnded { self?.cancel(request: request) }
			}
			.observe(on: UIScheduler())
	}
}
