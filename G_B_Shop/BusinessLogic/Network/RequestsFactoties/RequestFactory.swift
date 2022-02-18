//
//  RequestFactory.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeRegistrationAndDataChangesFactory() -> RegistrationAndDataChangesFactory {
        let errorParser = makeErrorParser()
        return RegistrationAndChanges(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeProductsFactory() -> ProductsRequestFactory {
        let errorParser = makeErrorParser()
        return ProductsRequests(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeProductsReviewsFactory() -> ProductsReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return ProductsReviewsRequests(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeCartRequestsFactory() -> CartRequestsFactory {
        let errorParser = makeErrorParser()
        return CartRequests(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGetRequestsFactory() -> GetRequestFactory {
        let errorParser = makeErrorParser()
        return GetRequests(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
