//
//  GetRequests.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import Foundation
import Alamofire

class GetRequests: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://intense-retreat-87800.herokuapp.com/")!
    
    init (errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetRequests: GetRequestFactory {
    func getUserData(request: String, completionHandler: @escaping (AFDataResponse<RegistrationAndChangesUser>) -> Void) {
        let requestModel = GetUserData(baseUrl: baseUrl, request: request)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension GetRequests {
    struct GetUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getUserData"
        
        let request: String
        var parameters: Parameters? {
            return [
                "request": request
            ]
        }
    }
}
