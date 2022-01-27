//
//  AbstractRequestFactory.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
import Alamofire
protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    
    @discardableResult
    func request<T: Decodable>(
    request: URLRequestConvertible, completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest
    
}

extension AbstractRequestFactory {
    
    @discardableResult
    public func request<T: Decodable>(
    request: URLRequestConvertible, completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
        return sessionManager
            .request(request)
            .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
    }
}

